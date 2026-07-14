const { createClient } = require("@supabase/supabase-js");
const Anthropic = require("@anthropic-ai/sdk");
const curriculumContext = require("./curriculumContext");

// Called by a Supabase Database Webhook on INSERT/UPDATE into `submissions`.
// Drafts AI feedback and writes it into `feedback_queue` with status 'pending'
// for a human facilitator to review before it's ever shown to the participant.
module.exports = async (req, res) => {
  if (req.method !== "POST") {
    res.status(405).json({ error: "Method not allowed" });
    return;
  }

  // Accept the shared secret either as a header (x-webhook-secret) or a
  // ?secret= query param — Supabase's webhook UI doesn't always expose a
  // custom-header field, so the query param is the simpler path to wire up.
  const providedSecret = req.headers["x-webhook-secret"] || req.query.secret;
  if (!process.env.WEBHOOK_SECRET || providedSecret !== process.env.WEBHOOK_SECRET) {
    res.status(401).json({ error: "Unauthorized" });
    return;
  }

  const payload = req.body;
  const submission = payload && payload.record;
  if (!submission || !submission.id) {
    res.status(400).json({ error: "Missing submission record in webhook payload" });
    return;
  }

  const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_SERVICE_ROLE_KEY);

  try {
    const [{ data: week, error: weekError }, { data: profile }, existing] = await Promise.all([
      supabase.from("weekly_content").select("*").eq("week_number", submission.week_number).single(),
      supabase.from("profiles").select("full_name").eq("id", submission.participant_id).single(),
      supabase.from("feedback_queue").select("id").eq("submission_id", submission.id).maybeSingle(),
    ]);

    if (weekError || !week) {
      console.error("weekly_content lookup failed", weekError);
      res.status(404).json({
        error: "Week content not found for week_number " + submission.week_number,
        detail: weekError ? weekError.message : "no row returned",
      });
      return;
    }

    // "Ikigai Thread" — Week 1's Three Sources of Purpose answers should be
    // revisited at the Week 4 midpoint and again at Week 8 (per facilitator
    // notes), so the AI can draw a throughline instead of treating each
    // week in isolation.
    let week1Context = null;
    if ([4, 8].includes(submission.week_number)) {
      const [{ data: week1Sub }, { data: week1Content }] = await Promise.all([
        supabase
          .from("submissions")
          .select("reflection_answers")
          .eq("participant_id", submission.participant_id)
          .eq("week_number", 1)
          .maybeSingle(),
        supabase.from("weekly_content").select("reflection_prompts").eq("week_number", 1).maybeSingle(),
      ]);
      if (week1Sub && week1Content) {
        week1Context = { prompts: week1Content.reflection_prompts, answers: week1Sub.reflection_answers };
      }
    }

    const draft = await draftFeedback({ week, submission, participantName: profile?.full_name, week1Context });

    if (existing.data) {
      // Re-submission (participant edited their answers) — refresh the pending draft.
      await supabase
        .from("feedback_queue")
        .update({
          ai_draft: draft.feedback,
          suggested_next_steps: draft.suggested_next_steps,
          status: "pending",
        })
        .eq("id", existing.data.id);
    } else {
      await supabase.from("feedback_queue").insert({
        submission_id: submission.id,
        participant_id: submission.participant_id,
        ai_draft: draft.feedback,
        suggested_next_steps: draft.suggested_next_steps,
        status: "pending",
      });
    }

    res.status(200).json({ ok: true });
  } catch (err) {
    console.error("generate-feedback error", err);
    res.status(500).json({ error: err.message });
  }
};

async function draftFeedback({ week, submission, participantName, week1Context }) {
  const anthropic = new Anthropic({ apiKey: process.env.ANTHROPIC_API_KEY });

  const answers = (submission.reflection_answers || [])
    .map((a, i) => `Q${i + 1}: ${(week.reflection_prompts || [])[i] || ""}\nA${i + 1}: ${a}`)
    .join("\n\n");

  const week1Block = week1Context
    ? `\nIkigai Thread — this participant's Week 1 answers on their sources of purpose, for you to weave in (ask which source has grown strongest or become clearer, don't just repeat it back):\n${(week1Context.prompts || [])
        .map((q, i) => `Q${i + 1}: ${q}\nA${i + 1}: ${(week1Context.answers || [])[i] || ""}`)
        .join("\n\n")}\n`
    : "";

  const keystoneNote =
    week.week_number === 8
      ? "\nThis is Week 8 — the participant's Keystone Habit declaration here is the single most important output of the entire programme. Acknowledge it explicitly and specifically in your feedback, and connect it back to their CHOPE/Ikigai from earlier weeks if the thread above makes that possible.\n"
      : "";

  const userContent = `
Week ${week.week_number}: ${week.title} (Domain: ${week.domain})

This week's challenge was: ${week.challenge}

Participant${participantName ? ` (${participantName})` : ""}'s reflection answers:
${answers}

Challenge status: ${submission.challenge_status}${submission.challenge_notes ? " — notes: " + submission.challenge_notes : ""}
${submission.question_for_facilitator ? `\nThe participant also asked: "${submission.question_for_facilitator}"` : ""}
${week1Block}${keystoneNote}
Write feedback for this participant and suggested next steps for the coming week.
`;

  const response = await anthropic.messages.create({
    // Haiku is fast enough to reliably finish inside Supabase's webhook
    // timeout window (max 10s) while still being well-suited to this
    // structured, curriculum-grounded feedback task.
    model: "claude-haiku-4-5-20251001",
    max_tokens: 800,
    system: `You are drafting facilitator feedback for a participant in the "Celebrate You!" healthy longevity course's 8-week post-course nudge programme.\n${curriculumContext}`,
    messages: [{ role: "user", content: userContent }],
    tools: [
      {
        name: "provide_feedback",
        description: "Provide the feedback draft and suggested next steps for this participant.",
        input_schema: {
          type: "object",
          properties: {
            feedback: {
              type: "string",
              description:
                "2-4 short paragraphs of warm, specific feedback responding directly to what the participant wrote, connecting it to relevant curriculum frameworks.",
            },
            suggested_next_steps: {
              type: "string",
              description: "2-4 concrete, specific bullet points (as plain text lines) the participant can act on this coming week.",
            },
          },
          required: ["feedback", "suggested_next_steps"],
        },
      },
    ],
    tool_choice: { type: "tool", name: "provide_feedback" },
  });

  const toolUse = response.content.find((block) => block.type === "tool_use");
  if (!toolUse) throw new Error("Model did not return structured feedback");
  return toolUse.input;
}
