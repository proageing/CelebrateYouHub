const { createClient } = require("@supabase/supabase-js");

// Deletes a participant's login account entirely. This must run server-side
// with the service_role key — removing a Supabase Auth user isn't something
// the anon/authenticated client role can ever do, by design. Verifies the
// caller is a genuinely signed-in admin (via their own session token) before
// touching anything, since this is destructive and cascades to all of that
// participant's submissions, feedback and peer circle posts.
module.exports = async (req, res) => {
  // Called directly from the browser (admin.html), on a different origin
  // than this function — unlike generate-feedback.js, which only Supabase's
  // webhook ever calls server-to-server. Without these headers the browser
  // blocks the request at the preflight OPTIONS check before it ever
  // reaches the admin/auth logic below.
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Methods", "POST, OPTIONS");
  res.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");

  if (req.method === "OPTIONS") {
    res.status(204).end();
    return;
  }

  if (req.method !== "POST") {
    res.status(405).json({ error: "Method not allowed" });
    return;
  }

  const authHeader = req.headers.authorization || "";
  const token = authHeader.startsWith("Bearer ") ? authHeader.slice(7) : "";
  if (!token) {
    res.status(401).json({ error: "Missing authorization token" });
    return;
  }

  const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_SERVICE_ROLE_KEY);

  const { data: { user }, error: authError } = await supabase.auth.getUser(token);
  if (authError || !user) {
    res.status(401).json({ error: "Invalid or expired session" });
    return;
  }

  const { data: callerProfile } = await supabase.from("profiles").select("is_admin").eq("id", user.id).single();
  if (!callerProfile || !callerProfile.is_admin) {
    res.status(403).json({ error: "Admin access required" });
    return;
  }

  const { participantId } = req.body || {};
  if (!participantId) {
    res.status(400).json({ error: "Missing participantId" });
    return;
  }

  // profiles.id references auth.users(id) on delete cascade, and
  // submissions/feedback_queue/peer_posts all cascade from profiles — so
  // deleting the auth user removes everything belonging to them in one go.
  const { error: deleteError } = await supabase.auth.admin.deleteUser(participantId);
  if (deleteError) {
    res.status(500).json({ error: deleteError.message });
    return;
  }

  res.status(200).json({ ok: true });
};
