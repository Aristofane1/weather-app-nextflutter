-- Table des villes favorites, isolée par utilisateur via RLS.
create table if not exists public.favorite_cities (
  id bigint generated always as identity primary key,
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  name text not null,
  country text,
  state text,
  lat double precision not null,
  lon double precision not null,
  created_at timestamptz not null default now(),
  unique (user_id, lat, lon)
);

alter table public.favorite_cities enable row level security;

drop policy if exists "own rows" on public.favorite_cities;
create policy "own rows" on public.favorite_cities
  for all
  using (user_id = auth.uid())
  with check (user_id = auth.uid());

-- Droits de table explicites pour le rôle des utilisateurs connectés (la RLS filtre ensuite les lignes).
grant select, insert, delete on public.favorite_cities to authenticated;
