-- Celebrate You Hub — database schema
-- Paste this whole file into the Supabase SQL Editor (Project → SQL Editor → New query) and run it once.

-- ============================================================
-- TABLES
-- ============================================================

create table public.teams (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  created_at timestamptz not null default now()
);

-- One row per participant, extending Supabase's built-in auth.users.
create table public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  email text not null,
  full_name text,
  team_id uuid references public.teams (id) on delete set null,
  is_admin boolean not null default false,
  created_at timestamptz not null default now()
);

-- Read-only reference data: the 8 weeks of nudge content.
create table public.weekly_content (
  week_number int primary key,
  title text not null,
  domain text not null,
  insight text not null,
  reflection_prompts jsonb not null,   -- array of question strings
  challenge text not null,
  peer_circle_prompt text not null
);

-- Participant submissions, one per participant per week.
create table public.submissions (
  id uuid primary key default gen_random_uuid(),
  participant_id uuid not null references public.profiles (id) on delete cascade,
  week_number int not null references public.weekly_content (week_number),
  reflection_answers jsonb not null,   -- array of answer strings, same order as reflection_prompts
  challenge_status text not null default 'in_progress', -- 'completed' | 'partial' | 'not_started'
  challenge_notes text,
  question_for_facilitator text,       -- optional free-form question the participant wants answered
  submitted_at timestamptz not null default now(),
  unique (participant_id, week_number)
);

-- AI-drafted feedback, queued for admin review before the participant sees it.
create table public.feedback_queue (
  id uuid primary key default gen_random_uuid(),
  submission_id uuid not null references public.submissions (id) on delete cascade,
  participant_id uuid not null references public.profiles (id) on delete cascade,
  ai_draft text,
  final_feedback text,
  suggested_next_steps text,
  status text not null default 'pending', -- 'pending' | 'approved' | 'sent'
  admin_notes text,
  reviewed_by uuid references public.profiles (id),
  reviewed_at timestamptz,
  created_at timestamptz not null default now()
);

-- Private team (peer circle) board.
create table public.peer_posts (
  id uuid primary key default gen_random_uuid(),
  team_id uuid not null references public.teams (id) on delete cascade,
  participant_id uuid not null references public.profiles (id) on delete cascade,
  author_name text not null,   -- denormalised at insert time so teammates don't need read access to each other's profile row
  week_number int references public.weekly_content (week_number),
  content text not null,
  created_at timestamptz not null default now()
);

-- ============================================================
-- ROW LEVEL SECURITY
-- ============================================================

alter table public.teams enable row level security;
alter table public.profiles enable row level security;
alter table public.weekly_content enable row level security;
alter table public.submissions enable row level security;
alter table public.feedback_queue enable row level security;
alter table public.peer_posts enable row level security;

-- Helper: is the current user an admin?
create or replace function public.is_admin()
returns boolean
language sql
security definer
stable
as $$
  select coalesce((select is_admin from public.profiles where id = auth.uid()), false);
$$;

-- teams: members can see their own team; admins see all.
create policy "teams: select own or admin" on public.teams
  for select using (
    id in (select team_id from public.profiles where id = auth.uid())
    or public.is_admin()
  );
create policy "teams: admin write" on public.teams
  for all using (public.is_admin()) with check (public.is_admin());

-- profiles: everyone can see their own row; admins see all; users can update their own row.
create policy "profiles: select own or admin" on public.profiles
  for select using (id = auth.uid() or public.is_admin());
create policy "profiles: update own" on public.profiles
  for update using (id = auth.uid()) with check (id = auth.uid());
create policy "profiles: admin write" on public.profiles
  for all using (public.is_admin()) with check (public.is_admin());
create policy "profiles: insert own" on public.profiles
  for insert with check (id = auth.uid());

-- weekly_content: readable by any signed-in participant.
create policy "weekly_content: read all authenticated" on public.weekly_content
  for select using (auth.role() = 'authenticated');
create policy "weekly_content: admin write" on public.weekly_content
  for all using (public.is_admin()) with check (public.is_admin());

-- submissions: participants manage their own; admins see/manage all.
create policy "submissions: select own or admin" on public.submissions
  for select using (participant_id = auth.uid() or public.is_admin());
create policy "submissions: insert own" on public.submissions
  for insert with check (participant_id = auth.uid());
create policy "submissions: update own" on public.submissions
  for update using (participant_id = auth.uid()) with check (participant_id = auth.uid());
create policy "submissions: admin write" on public.submissions
  for all using (public.is_admin()) with check (public.is_admin());

-- feedback_queue: participants only ever see rows once status = 'sent'; admins see everything.
create policy "feedback_queue: select sent-own or admin" on public.feedback_queue
  for select using (
    (participant_id = auth.uid() and status = 'sent')
    or public.is_admin()
  );
create policy "feedback_queue: admin write" on public.feedback_queue
  for all using (public.is_admin()) with check (public.is_admin());

-- peer_posts: team members can read/post within their own team; admins see all.
create policy "peer_posts: select own team or admin" on public.peer_posts
  for select using (
    team_id in (select team_id from public.profiles where id = auth.uid())
    or public.is_admin()
  );
create policy "peer_posts: insert own team" on public.peer_posts
  for insert with check (
    participant_id = auth.uid()
    and team_id in (select team_id from public.profiles where id = auth.uid())
  );
create policy "peer_posts: admin write" on public.peer_posts
  for all using (public.is_admin()) with check (public.is_admin());

-- ============================================================
-- AUTO-CREATE PROFILE ON SIGNUP
-- ============================================================

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, email)
  values (new.id, new.email);
  return new;
end;
$$;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();
