-- Fixes profiles being created the moment an invite email is sent, rather
-- than when the person actually confirms it — some invitees never will.
-- Run once in the Supabase SQL Editor. Safe on an existing database; this
-- only changes future signups/invites, it does not touch already-created
-- profiles (see the note at the bottom for cleaning those up if needed).

drop trigger if exists on_auth_user_created on auth.users;

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  invite public.invited_participants%rowtype;
begin
  if new.email_confirmed_at is null then
    return new;
  end if;

  if exists (select 1 from public.profiles where id = new.id) then
    return new;
  end if;

  select * into invite from public.invited_participants where email = new.email;

  insert into public.profiles (id, email, full_name, cohort_id, team_id)
  values (new.id, new.email, invite.full_name, invite.cohort_id, invite.team_id);

  if invite.email is not null then
    delete from public.invited_participants where email = invite.email;
  end if;

  return new;
end;
$$;

create trigger on_auth_user_created
  after insert or update on auth.users
  for each row execute procedure public.handle_new_user();

-- Optional cleanup: find profiles that were created for people who have
-- never actually confirmed their email (created under the old behaviour).
-- Review this list before deleting anything — it's just a SELECT.
--
-- select p.id, p.email, p.full_name, u.email_confirmed_at, u.created_at
-- from public.profiles p
-- join auth.users u on u.id = p.id
-- where u.email_confirmed_at is null
-- order by u.created_at desc;
