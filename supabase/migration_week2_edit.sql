-- Week 2's second reflection prompt dropped the "Looking at your LifeTime..."
-- sentence, per the updated CY 8Week Brief Nudge Programme App.docx. Run
-- once in the Supabase SQL Editor. Only touches weekly_content, week 2.

update public.weekly_content
set reflection_prompts = '["What did you do this past week that honoured your CHOPE — even in a small way?", "Which SIAM (saboteur) did you catch yourself falling into?"]'::jsonb
where week_number = 2;
