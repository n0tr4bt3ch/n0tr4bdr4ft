-- Supabase schema for the NBA Fantasy Draft Assistant cloud sync.
-- Safe to re-run. Cloud rows are private to the authenticated owner.

create table if not exists public.draft_state (
  user_id uuid primary key references auth.users(id) on delete cascade,
  state jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.draft_state enable row level security;
grant select, insert, update, delete on public.draft_state to authenticated;

do $$
begin
  if not exists (
    select 1 from pg_policies
    where schemaname = 'public' and tablename = 'draft_state'
      and policyname = 'draft_state_select_own'
  ) then
    create policy draft_state_select_own
      on public.draft_state for select to authenticated
      using ((select auth.uid()) = user_id);
  end if;

  if not exists (
    select 1 from pg_policies
    where schemaname = 'public' and tablename = 'draft_state'
      and policyname = 'draft_state_insert_own'
  ) then
    create policy draft_state_insert_own
      on public.draft_state for insert to authenticated
      with check ((select auth.uid()) = user_id);
  end if;

  if not exists (
    select 1 from pg_policies
    where schemaname = 'public' and tablename = 'draft_state'
      and policyname = 'draft_state_update_own'
  ) then
    create policy draft_state_update_own
      on public.draft_state for update to authenticated
      using ((select auth.uid()) = user_id)
      with check ((select auth.uid()) = user_id);
  end if;

  if not exists (
    select 1 from pg_policies
    where schemaname = 'public' and tablename = 'draft_state'
      and policyname = 'draft_state_delete_own'
  ) then
    create policy draft_state_delete_own
      on public.draft_state for delete to authenticated
      using ((select auth.uid()) = user_id);
  end if;
end $$;
