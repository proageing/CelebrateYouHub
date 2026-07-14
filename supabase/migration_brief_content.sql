-- Updates all 8 weeks of nudge content on an already-deployed database to
-- match the latest edit of CY 8Week Brief Nudge Programme App.docx —
-- weeks 5-7 are now down to a single reflection question each, and several
-- weeks have shorter insight/challenge text. Upserts by week_number, so
-- existing weekly_content rows are updated in place; participant
-- submissions and feedback are untouched. Safe to re-run.

insert into public.weekly_content (week_number, title, domain, insight, reflection_prompts, challenge, peer_circle_prompt) values

(1, 'Your Preferred Future & Ikigai', 'Purpose & Identity',
$$Purpose is a longevity superpower. Every Blue Zone population shares a clear Ikigai: a personal, specific reason to get up each morning; a reason to live.$$,
'["Close your eyes and revisit your Preferred Future for 60 seconds. What do you still see, hear and feel?", "Which of your Three Sources of Purpose (People, Contribution, Experiences) feels strongest right now? Which feels thin?"]'::jsonb,
$$Write one sentence: "In 5 years, I am..." — place it where you'll see it daily.
Use each Source of Purpose in your workbook as inspiration.$$,
$$Share your "In 5 years, I am..." sentence with your accountability buddy — and ask them to share theirs.$$),

(2, 'Protect Your CHOPE', 'Purpose & Identity',
$$Your CHOPE is your most important priority to protect. When daily choices align with what you value most, stress and regret shrink. When they don't, the cost accumulates quietly. Your CHOPE and your Ikigai are deeply linked — what you protect most often points to your deepest reason to get up each morning.$$,
'["What did you do this past week that honoured your CHOPE — even in a small way?", "Which SIAM (saboteur) did you catch yourself falling into?"]'::jsonb,
$$Block one 30-minute slot this week to deliberately honour your CHOPE.$$,
$$Tell your accountability buddy your CHOPE or the SIAM you're working to overcome. Ask them to check in with you at the end of the week.$$),

(3, 'Time to Move — How''s Your Plan Going?', 'Physical Health & Movement',
$$VO₂ Max is the single strongest predictor of longevity. A major study found that the least fit people had 5× higher mortality risk than the most fit — greater than the risk from smoking, high blood pressure or diabetes! Starting now builds the reserve that protects independence later.$$,
'["Since the course, have you started your personal exercise plan? If yes — what''s working and what''s been hardest?", "If not yet — what specifically got in the way? Look at your fitness plan (Page 51). Which activities did you choose?"]'::jsonb,
$$Complete at least two sessions from your plan this week.
If you haven't started, do: one 15-min brisk walk (moderate intensity) + one strength session (2×10 squats + 2×10 push-ups). Log it — a simple tick counts.$$,
$$Check in with your peer circle: who's started their plan? Invite someone to an exercise session this week.$$),

(4, 'How Are Your Food Habits?', 'Nutrition & Metabolic Health',
$$Food is one of the most powerful levers you have for a longer, healthier life — and small, consistent shifts compound over time.
In Celebrate You! you learned three habits the world's longest-lived populations share: eat more plants and quality protein, stop when you're 80% full, and make every meal an investment in your future self. Simple habits, adaptable to any hawker centre, any day of the week.
This week: notice what's already shifting — and choose one habit to anchor.$$,
'["How different is your eating now compared to before the course?", "Which habit you''re working on has been easiest to start — and which feels hardest?"]'::jsonb,
$$Pick ONE habit and do it consistently for 7 days:
Option A — Longevity Plate: one meal per day follows the ½ / ¼ / ¼ template.
Option B — Protein first: add a protein-rich food to breakfast every day.
Option C — Hara Hachi Bu: stop at 80% full at every dinner, eating slowly, no screens.$$,
$$Share any longevity meal or hack you've found at your local hawker centre or supermarket.$$),

(5, 'Sleep Well, Stress Less', 'Sleep & Stress',
$$Sleep is a non-negotiable must-have to ageing well and looking younger. Sleep and stress form a cycle: poor sleep raises cortisol; high cortisol disrupts sleep. Breaking it requires a daily recovery practice that can shift the quality of your sleep significantly.$$,
'["Which sleep hygiene habits are you consistently doing — and which you are still neglecting? (Regular schedule · Dark, cool bedroom · No screens 30 min before bed · No caffeine after 2pm · Wind-down routine)"]'::jsonb,
$$Each day this week: practise your preferred technique before sleep. The three techniques: Deep Breathing (4-sec inhale, 6-sec exhale for 3 mins). Finger Breathing (trace each finger, inhale up, exhale down — 90 seconds to slow and ground). Container Touch (mentally "place" intrusive thoughts before sleep, freeing your mind to rest).$$,
$$Ask your peer circle: "What's the one thing that's most improved your sleep or stress since the course?"$$),

(6, 'Your Tribe', 'Social Connection',
$$Loneliness is a stronger predictor of early death than smoking 15 cigarettes a day! The KOPI framework (Keepsakes, Overcome, People, Inspire) was designed to help you have deeper conversations than daily routine allows. Your social network isn't a nicety — it's biological infrastructure.$$,
'["Think about the people you listed under \"P — People\" in your KOPI exercise. When did you last have a genuinely meaningful conversation with one of them?"]'::jsonb,
$$Reach out to one person this week for a meaningful conversation.$$,
$$Share your experiences and new ways to build new or lasting relationships.$$),

(7, 'Train Your Brain', 'Cognitive Enhancement',
$$Your brain doesn't just decline with age — it evolves. Wisdom, emotional intelligence and pattern recognition all sharpen over time. The goal isn't to fight ageing; it's to keep your brain challenged, nourished and connected.
In Celebrate You! you learned the 3P enhancement strategies: positive daily habits as your foundation, productive coping skills, and proactive novel challenges to keep your brain sharp. Everything you've worked on over the past six weeks — sleep, food, movement, connection — has already been feeding your brain.
This week, give it something new to chew on.$$,
'["Which of the 3 Ps is strongest in your daily life right now — and which is most neglected?"]'::jsonb,
$$Choose ONE Proactive Stimulation challenge: Learn 10 words in a new language · Try a new recipe from scratch · Take a different route · Play a new strategy game.$$,
$$Share what you tried — especially if it felt awkward. Normalising cognitive challenge in your peer group makes it easier for everyone to keep pushing.$$),

(8, 'Celebrate You!', 'Integration — All Domains',
$$You don't need to have done everything perfectly — you just need to have moved, and noticed that you moved. Research on behaviour change reminds us that change requires less friction, not more willpower. When something feels hard, simplify it.
As you close this programme, declare one keystone habit — the single habit most likely to pull everything else along with it. This isn't the end. It's where small actions become lifetime habits.$$,
'["Return to your Wheel of Life. Re-score each domain and compare to Day 1.", "Where has there been genuine movement — even just one point? Where do you want to focus next? Re-read your \"In 5 years, I am...\" sentence from Week 1. Does it still feel true? Has it deepened?"]'::jsonb,
$$Write three things before you close:
1. One thing you're proud of from these 8 weeks — no matter how small.
2. One Keystone Habit you're committing to for the next 3 months (make it specific, easy to start and deeply yours).
3. One person you'll share this commitment with today — then share it.$$,
$$Celebrate together. Organise an in-person peer circle reunion. Acknowledge each other's progress.$$)

on conflict (week_number) do update set
  title = excluded.title,
  domain = excluded.domain,
  insight = excluded.insight,
  reflection_prompts = excluded.reflection_prompts,
  challenge = excluded.challenge,
  peer_circle_prompt = excluded.peer_circle_prompt;
