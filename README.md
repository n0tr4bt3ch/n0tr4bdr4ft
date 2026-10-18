# NBA Fantasy Draft Assistant

A static GitHub Pages app for a 12-team, 8-category head-to-head NBA fantasy snake draft.

## Dashboard features

- Import a 2026–27 projection CSV and a separate ESPN ADP CSV.
- Draft board, manual pick tracking, undo/reset, and JSON backup/restore.
- 5,000-run ADP-based mock draft simulator with sortable availability and pick-pair tables.
- Roster-aware category map, position eligibility counts, next-pick path, and category context on advisor cards.
- Optional email-link sign-in and Supabase cloud sync for projections, ADP, team names, settings, and draft picks.

## Run it

The app is static: open `index.html` locally or publish the repository with GitHub Pages. No build step is required. Import your own current-season projection and ADP files; the app does not connect to ESPN's live draft room.

## Cloud storage

The app uses Supabase Auth (email magic link) and a `public.draft_state` table. The app stores one JSON state row per authenticated user. Browser-local autosave and exportable JSON backups remain available as additional safeguards.

If the Supabase table or row-level security policies need to be created/repaired, open the Supabase SQL Editor for the project configured in `index.html` and run [`supabase/setup.sql`](supabase/setup.sql). The policies restrict each signed-in user to their own row. Confirm Supabase Auth email-link settings and the allowed redirect URL for the deployed GitHub Pages origin.

Do not put a Supabase `service_role` key or other server secret in this static app. The browser may use only a publishable/anon key with row-level security enforced.

## Projection integrity

- Use current 2026–27 projection files for draft decisions.
- The app labels category values from the imported player pool as relative indicators; it does not invent missing per-player statistics.
- Last-season actuals and historical shooting-rate data are historical context, not current-season projections.
- The mock draft is a scenario model anchored to imported ADP and projection ranks, not a guarantee of who will be drafted.
