-- Ties teams to a single batch (cohort) and enforces at the database level
-- that a participant's team must belong to their own cohort. Run once in
-- the Supabase SQL Editor. Safe on an existing database — existing teams
-- get cohort_id = NULL (treated as unscoped/legacy) until you assign them
-- a batch from the admin panel.

alter table public.teams add column cohort_id uuid references public.cohorts (id) on delete cascade;

create or replace function public.validate_profile_team_cohort()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  team_cohort uuid;
begin
  if new.team_id is not null then
    select cohort_id into team_cohort from public.teams where id = new.team_id;
    if team_cohort is not null and new.cohort_id is distinct from team_cohort then
      raise exception 'This team belongs to a different batch than the participant''s assigned batch';
    end if;
  end if;
  return new;
end;
$$;

create trigger validate_profile_team_cohort
  before insert or update on public.profiles
  for each row execute procedure public.validate_profile_team_cohort();
