-- Adds multi-cohort (multi-batch) support to an already-deployed database.
-- Run this once in the Supabase SQL Editor. Safe to run even with existing
-- participants/submissions — it only adds new structure, nothing is dropped.

create table public.cohorts (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  start_date date not null,
  created_at timestamptz not null default now()
);

alter table public.profiles add column cohort_id uuid references public.cohorts (id) on delete set null;

alter table public.cohorts enable row level security;

create policy "cohorts: select own or admin" on public.cohorts
  for select using (
    id in (select cohort_id from public.profiles where id = auth.uid())
    or public.is_admin()
  );
create policy "cohorts: admin write" on public.cohorts
  for all using (public.is_admin()) with check (public.is_admin());

-- Stops a participant from self-assigning a team/cohort or granting themselves
-- admin by calling the profiles update endpoint directly (the existing
-- "profiles: update own" policy only restricts *which row*, not *which
-- columns*, a non-admin can update).
create or replace function public.protect_profile_privilege_columns()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if not public.is_admin() then
    if new.is_admin is distinct from old.is_admin
       or new.team_id is distinct from old.team_id
       or new.cohort_id is distinct from old.cohort_id then
      raise exception 'Only an admin can change is_admin, team_id or cohort_id';
    end if;
  end if;
  return new;
end;
$$;

create trigger protect_profile_privilege_columns
  before update on public.profiles
  for each row execute procedure public.protect_profile_privilege_columns();
