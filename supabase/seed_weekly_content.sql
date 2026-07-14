-- Celebrate You Hub — 8-week nudge curriculum content
-- Run this AFTER schema.sql, once, in the Supabase SQL Editor.
-- Source: CY_8Week_Nudge_Programme.docx (2026 edition)

insert into public.weekly_content (week_number, title, domain, insight, reflection_prompts, challenge, peer_circle_prompt) values

(1, 'Your Preferred Future & Ikigai', 'Purpose & Identity',
$$In Celebrate You! you created a vivid Preferred Future using all five senses — and you explored your Ikigai, your deeply personal reason to get up each morning.

These two are connected: research from Rush University (6,985 participants) found that adults with a strong sense of purpose have 20% lower all-cause mortality. Purpose protects the heart, brain and immune system. All five Blue Zone populations had a clear Ikigai — not a grand mission, but a specific, personal reason: tending a garden, being a grandmother, walking with a neighbour.

You also took the Sunday Afternoon Test: how you feel on Sunday afternoons reveals how strong your current sources of meaning are.
- Calm and content → your life has active sources of meaning carrying you through.
- Empty, restless or anxious → you may need more purpose anchors.$$,
'["Close your eyes for 60 seconds and revisit the Preferred Future you described in your workbook. What do you see, hear, or feel in that image? Has anything shifted since the course?", "Which of your Three Sources of Purpose — Relational, Contribution, Experiential — feels strongest right now? Which feels thin or neglected?"]'::jsonb,
$$Do both of these in the next 48 hours:
1. Write one sentence beginning with "In 5 years, I am..." and place it somewhere you will see it daily — phone wallpaper, desk note, or fridge door.
2. Name your Three Sources of Purpose (one Relational, one Contribution, one Experiential) in your workbook (Page 24).$$,
$$Share your "In 5 years, I am..." sentence with your accountability buddy from the course. Ask them to read theirs to you too.$$),

(2, 'Protect Your CHOPE', 'Purpose & Identity',
$$In the course, you identified your top CHOPE — a priority you want to jealously protect — and your top SIAM — something that could sabotage it.

Dr Becca Levy at Yale University showed that people with a negative mindset about ageing experience poorer health outcomes and lower life expectancy. Your CHOPE is your antidote. When daily choices align with what you value most, stress and regret diminish. Misalignment accumulates silently over months and years.

Your Ikigai from Week 1 and your CHOPE are closely linked: the things you most want to protect are usually pointing towards your deeper reason to get up each morning.$$,
'["Look at the CHOPE you wrote in your workbook. What is one small thing you did this past week that honoured it? And what is one SIAM you caught yourself falling into?", "Look at your LifeTime — the personal timeline from the course connecting past, present and preferred future. Does the path between now and your preferred future feel clearer or more uncertain than it did on Day 1?"]'::jsonb,
$$Choose one 30-minute block this week to deliberately honour your CHOPE. Block it in your calendar before you read on.
Write your top SIAM down and identify one strategy to "attack" it this week — as your group did in the course activity.$$,
$$Tell your accountability buddy what your CHOPE is and what SIAM you are working to attack. Ask them to check in with you mid-week.$$),

(3, 'Time to Move — How Is Your Plan Going?', 'Physical Health & Movement',
$$On Day 2 of the course, you built a personal physical activity plan — grounded in your Deep Squat, Balance Test and Hand Grip Strength results. You also learned that VO₂ Max is the single strongest predictor of longevity: a JAMA 2018 study (122,000 participants) found that the least fit individuals had 5× higher mortality risk than the most fit. That is bigger than the risk from smoking, high blood pressure or diabetes.

The two training tools from your plan:
- Zone 2 Training (Foundation): 60–70% max HR, full conversation possible, 150 minutes per week — brisk walking, cycling, swimming.
- Norwegian 4×4 HIIT (Accelerator): 4 minutes hard + 3 minutes easy, repeated 4 times = 28 minutes. 1–2 sessions per week maximum.

The Disability Threshold from the course shows why starting now matters: physical capacity declines gradually, but once it falls below the threshold for daily activities, independence is threatened. Building reserve now is the strategy.$$,
'["Be honest with yourself: since the course ended, have you started exercising according to your personal plan? If yes — what has been working? What has been hardest to maintain? If not yet — what specifically got in the way?", "Look at your fitness plan in your workbook (Page 51). Which activities did you choose — and have you tried them yet?"]'::jsonb,
$$Complete at least two exercise sessions this week from your personal plan. If you have not started yet, keep it simple:
- One Zone 2 session: 30 minutes of brisk walking where you can speak in full sentences but not sing.
- One strength session: 2 sets of 10 bodyweight squats + 2 sets of 10 modified push-ups.
Log it — even a simple tick in your calendar counts. Starting is the only requirement.$$,
$$Check in with your peer circle: has anyone started their plan? Share what you did — or what got in the way. Invite a peer to join one of your sessions this week. Social exercise sticks better than solo exercise.$$),

(4, 'How Are Your Food Habits?', 'Nutrition & Metabolic Health',
$$In the course you learned the three foundations of longevity nutrition — and got a Singapore-specific framework to apply them:
- The Longevity Plate: ½ plate vegetables and fruit · ¼ plate protein · ¼ plate whole grains. Simple, visual and adaptable to any hawker centre meal.
- Protein for Muscle Insurance: 1.2–1.6g of protein per kg of bodyweight per day (roughly 84–112g for a 70kg adult). Spread across meals — 25–40g per sitting — with leucine-rich sources (chicken, fish, eggs, tofu, tempeh, edamame). Protein also supports BDNF for brain health.
- Hara Hachi Bu — the 80% full rule: the gut takes 20 minutes to signal fullness. Stopping earlier without counting calories activates autophagy and reduces daily intake by 200–300 calories.

The MIND and Mediterranean diets from the course show the downstream impact: PREDIMED Trial cut heart attack and stroke risk by 30%; MIND Diet reduced Alzheimer's risk by 53%.$$,
'["Think about what you have been eating over the past two weeks since the course. Honestly — how different is it from before? Are you building your meals around the Longevity Plate? Have you increased your protein, especially at breakfast? Are you eating slower and stopping before you feel completely full?", "Which of the three habits has been easiest to start? Which has felt hardest?"]'::jsonb,
$$Pick one nutritional habit to focus on this week and do it consistently for 7 days:
- Option A — Longevity Plate: at least one meal per day follows the ½ / ¼ / ¼ template.
- Option B — Protein first: add a protein-rich food to breakfast every day this week (eggs, tofu, Greek yoghurt, legumes).
- Option C — Hara Hachi Bu: practise stopping at 80% full at every dinner, eating slowly, no screens at the table.
Track it with a simple daily tick. Consistency over perfection.$$,
$$Share your chosen habit and one meal you are proud of this week with your peer group. What Blue Zone-inspired food have you found at your local hawker centre or supermarket?$$),

(5, 'Sleep Well, Stress Less', 'Sleep & Stress',
$$Sleep Quality and Chronic Stress are two of the 7 Pillars of Modifiable Risk from the course — and they are deeply connected. Poor sleep raises cortisol; high cortisol disrupts sleep. Breaking the cycle requires a daily recovery practice.

In the course you completed the Epworth Sleepiness Scale (daytime sleepiness) and the Sleep Hygiene Index (your sleep practices). Those scores are your baseline.

You also practised three somatic techniques that shift your nervous system from stressed to restored:
- Deep Breathing: diaphragmatic breathing that calms the nervous system and keeps attention present. 4-second inhale, 6-second exhale.
- Finger Breathing: trace up each finger on the inhale, down on the exhale — a tactile technique that slows the breath and grounds the body. Takes 90 seconds.
- Container Touch: a grounding technique to mentally "place" intrusive thoughts into an imagined container before sleep, freeing the mind to rest.

Resource: AIM to De-Stress (www.aimtodestress.sg) — a free Singapore platform with sleep tools, stress management practices and guided techniques.$$,
'["Look back at your Epworth Sleepiness Scale and Sleep Hygiene scores from the course. What did they reveal about your current sleep quality? Which of the five core sleep habits are you consistently doing — and which one are you still neglecting? (Regular sleep-wake schedule · Dark and cool bedroom · No screens 30 min before bed · No caffeine after 2pm · A wind-down routine)", "Which of the three techniques (Deep Breathing, Finger Breathing, Container Touch) felt most natural to you during the course?"]'::jsonb,
$$Do two things every day this week:
1. Practise your preferred technique once in the morning (to set your nervous system) and once before sleep (to release the day's stress). Each takes 90 seconds to 3 minutes.
2. Commit to one Sleep Hygiene habit for all 7 nights. Set a phone reminder 30 minutes before your target bedtime labelled "Wind Down."
Visit AIM to De-Stress at www.aimtodestress.sg for additional guided practices if you want to go deeper.$$,
$$Ask your peer circle: "What is the one thing that has most improved your sleep or stress levels since the course?" Try one suggestion from someone else this week.$$),

(6, 'Your Tribe', 'Social Connection',
$$The KOPI framework you practised on Day 1 — Keepsakes, Overcome, People, Inspire — was designed to help you have deeper, more meaningful conversations than daily routine allows.

The research is stark: loneliness is a stronger predictor of early death than smoking 15 cigarettes a day. It is now classified by the WHO as a public health crisis. For older adults, social isolation is a risk factor across multiple longevity pillars: Chronic Stress, Purpose & Meaning and Cardiovascular Fitness.

Research from the Panel of Health and Aging among Older Singaporeans (PHASE, n=4,990) confirms that loneliness significantly predicts lower personal mastery and poorer health outcomes in Singapore's older adult population.

Your social network is not a nicety — it is biological infrastructure.$$,
'["Think about the people you listed under \"P — People\" in your KOPI exercise during the course. When did you last have a genuinely meaningful conversation with one of them — not just a functional message or a quick check-in, but a real exchange?", "Which of your Three Sources of Purpose (from Week 1) is Relational? Have you been actively nurturing it?"]'::jsonb,
$$Reach out to one person this week for a KOPI conversation. You do not need the full framework — simply meet for coffee or a walk and ask one genuine question: "What is something you have been working to overcome recently?" Then listen without offering solutions. The quality of the connection matters more than the setting or the duration.$$,
$$Plan a group check-in with your peer circle from the course — even a 30-minute virtual call. Peer circles that stay connected beyond the programme show significantly better health habit retention at the 3-month re-assessment.$$),

(7, 'Train Your Brain', 'Cognitive Enhancement',
$$In the course you learned that the ageing brain has real gains — Wisdom, accumulated knowledge, pattern recognition and improved emotional regulation — alongside the declines in processing speed and working memory. The goal is to protect the gains while managing the declines.

The 3P Framework from the course gives you three levers:
(a) Positive Lifestyle Change — the foundation your brain runs on: sleep, nutrition, exercise, stress management, social connection and dental hygiene. Everything you have worked on in the past six weeks directly supports brain health.
(b) Productive Skills — targeted daily techniques:
   - Attention: mono-tasking, the Pomodoro Technique (25 min work / 5 min break), removing visual distractions.
   - Memory: Chunk (group items into meaningful clusters), Record (write it down immediately), Mental Rehearsal (say it aloud or visualise it).
   - Flexible Thinking: deliberately alter your routine — a new route, a new coffee order, a new podcast topic.
   - Executive Function: break complex tasks into steps of 15 minutes or less; maintain an organised work environment.
(c) Proactive Stimulation — the brain must encounter something genuinely novel and challenging to induce neuroplasticity and neurogenesis. Routine activities, even engaging ones, do not produce the same growth effect.

Neuroplasticity means the brain can physically rewire itself in response to new experiences at any age. Neurogenesis — the growth of new neurons — continues in the hippocampus well into late adulthood, supported by exercise, sleep, social connection and novel challenge.$$,
'["Which of the 3 Ps is strongest in your daily life right now? Which is most neglected?", "Think about the course activities: Find the Fs (attention), the Ruler Game (processing speed), the Stroop Test (flexible thinking) and the 15-second Recall (memory). Which exercise surprised you most — and what did it reveal about your cognitive strengths or gaps?", "What was the last genuinely novel cognitive challenge you took on — something that made you think in an unfamiliar way?"]'::jsonb,
$$Choose ONE Productive Skills technique and apply it every day this week (Pomodoro Technique for your most demanding work task, Chunk + Record for one item you need to remember each day, or change one part of your daily routine to build Flexible Thinking).

AND choose ONE Proactive Stimulation challenge — do it for at least 20 minutes on three separate days: Learn 10 words in a new language · Try a completely new recipe from scratch · Take a different route and notice three things you have never seen before · Play a new strategy game.

Discomfort during learning is the signal that the brain is working.$$,
$$Share what you tried and what it felt like — especially if it was awkward or uncomfortable. Normalising cognitive challenge in your peer group makes it easier for everyone to keep pushing their boundaries.$$),

(8, 'Celebrate You!', 'Integration — All Five Domains',
$$You have just completed an 8-week journey through all five domains of healthy longevity.

Research on behaviour change (Fogg, 2019) shows that keystone habits — the ones you commit to and identify with — create cascading improvements across other areas of life. You do not need to have done everything perfectly. You need to have moved, and to have noticed that you moved.

The programme began with the Wheel of Life on Day 1 and a Preferred Future. It closes in exactly the same place — but you are different. Your scores will tell that story.$$,
'["Return to the Wheel of Life in your workbook (Page 19). Re-score each domain today and compare to your Day 1 scores: Purpose & Identity · Physical Health & Movement · Nutrition & Metabolic Health · Sleep & Stress · Social Connection · Cognitive Enhancement. Where has there been genuine movement — even just one point upward? Where do you want to focus in the next chapter?", "Re-read the \"In 5 years, I am...\" sentence you wrote in Week 1. Does it still feel true? Has it deepened?"]'::jsonb,
$$Write three things before you close your workbook:
1. One thing you are proud of from these 8 weeks — no matter how small.
2. One Keystone Habit you are committing to for the next 3 months. Choose the single habit most likely to protect your CHOPE and support your Ikigai.
3. One person you will share this commitment with today — and then share it with them.$$,
$$Celebrate together. Organise a peer circle reunion — in person if possible. Share your Wheel of Life re-scores (only what you are comfortable sharing). Acknowledge each other's progress. Schedule your next check-in for the 3-month re-assessment.$$);
