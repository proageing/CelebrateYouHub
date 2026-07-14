-- Fixes protect_profile_privilege_columns, which was incorrectly blocking
-- direct database access (SQL Editor, Table Editor) from changing
-- is_admin/team_id/cohort_id — it should only stop a signed-in participant
-- from self-escalating via the app, not block you working directly in the
-- database. Safe to run any time; this is just a function replacement.

create or replace function public.protect_profile_privilege_columns()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if auth.uid() is not null and not public.is_admin() then
    if new.is_admin is distinct from old.is_admin
       or new.team_id is distinct from old.team_id
       or new.cohort_id is distinct from old.cohort_id then
      raise exception 'Only an admin can change is_admin, team_id or cohort_id';
    end if;
  end if;
  return new;
end;
$$;
