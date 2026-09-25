# Météo — Flutter, Supabase et OpenWeatherMap

App météo offline-first : authentification JWT (Supabase), villes favorites synchronisées, météo actuelle et prévisions à 5 jours (OpenWeatherMap), cache local Hive.

## Fonctionnalités

- Inscription, connexion et déconnexion (Supabase Auth, JWT et refresh token)
- Écrans : **Mes villes** (favoris et température), **Détail** (météo actuelle et prévisions à 5 jours), **Recherche** (geocoding et ajout aux favoris), **Profil**
- **Offline-first** : les données en cache s'affichent immédiatement, puis sont mises à jour depuis le réseau. Hors ligne, les dernières données en cache restent affichées.
- Messages d'erreur réseau en français et bouton « Réessayer »
- Skeleton loaders (shimmer) pendant les chargements

## Architecture

Organisation feature-first, avec un découpage `data / domain / presentation` dans chaque feature.

```
lib/
  app/        routeur go_router (redirection selon l'état d'auth), MaterialApp
  core/       socle réutilisable, indépendant des features
    config/       Env (.env)
    network/      AuthInterceptor, OwmInterceptor, NetworkInfo
    error/        Failure (union freezed) + mapping DioException → Failure
    result/       Result<T> = Success | Failed
    cache/        CacheStore / HiveCacheStore
    storage/      AuthSession + SessionStorage (flutter_secure_storage)
    repository/   BaseRepository : offlineFirst() et guard()
    widgets/      ResultView, Skeleton*, ErrorView, EmptyView, ScrollableFill
  features/
    auth/     Supabase Auth (GoTrue REST)
    weather/  météo actuelle et prévisions (OpenWeatherMap)
    cities/   recherche (OWM geocoding) et favoris (Supabase PostgREST)
```

**Flux de données :** Widget → provider Riverpod → interface `Repository` (domain) → `RepositoryImpl` (data) → `RemoteDataSource` (Dio) + `CacheStore` (Hive)

- **Repository pattern :** l'UI ne dépend que des interfaces du domaine. Les implémentations renvoient `Result<T>` et ne lèvent jamais d'exception.
- **Offline-first** (`BaseRepository.offlineFirst`) :
  1. Le cache est émis s'il existe.
  2. Hors ligne, on s'arrête là. Sans cache, on émet `Failure.network`.
  3. En ligne, on appelle l'API, on écrit le résultat dans le cache et on émet la donnée fraîche. Si l'appel échoue alors qu'un cache existe, les données en cache restent affichées.
  4. Le cache n'est pas cloisonné par utilisateur : il est vidé à la déconnexion, à l'expiration de la session et à chaque connexion, pour qu'un utilisateur ne voie jamais les données du précédent.
- **Auth :**
  - Il y a deux clients Dio Supabase. Le client *auth* (login, signup, refresh) n'a pas d'intercepteur. Le client *données* porte l'`AuthInterceptor`.
  - L'intercepteur injecte `Authorization: Bearer <jwt>`. Il rafraîchit le token préventivement quand il est expiré, et aussi sur une 401. C'est un `QueuedInterceptor` : les 401 concurrents partagent un seul refresh, puis les requêtes sont rejouées via un `retryDio` séparé (sans `AuthInterceptor`), avec le nouveau Bearer explicite — rejouer via le Dio intercepté bloquait sa file d'erreurs quand la requête rejouée renvoyait aussi 401.
  - Si le refresh token est refusé, la session et le cache sont effacés (`AuthRepository.clearLocalData`) et l'utilisateur est renvoyé au login ; une requête dont le refresh préventif est refusé échoue en 401 au lieu de partir sans token. En cas d'erreur réseau, la session est conservée (offline-first).
  - `signOut` est best-effort : l'appel réseau et chaque nettoyage local (session, cache) sont isolés par try/catch, pour qu'il se termine toujours, même si l'un d'eux échoue.
- **Sérialisation :** DTO `freezed` + `json_serializable`. Le JSON brut de l'API est mis en cache et re-parsé à la lecture. Une entrée devenue illisible est supprimée.

## APIs utilisées

| API | Usage | Endpoints |
|---|---|---|
| Supabase Auth | inscription, connexion, refresh, logout | `/auth/v1/signup`, `/auth/v1/token?grant_type=password\|refresh_token`, `/auth/v1/logout` |
| Supabase PostgREST | villes favorites (RLS par utilisateur) | `/rest/v1/favorite_cities` |
| OpenWeatherMap | météo actuelle, prévisions 5 j / 3 h, geocoding | `/data/2.5/weather`, `/data/2.5/forecast`, `/geo/1.0/direct` |

## Configuration

1. **Prérequis :** Flutter 3.41+ (Dart 3.11).
2. **Supabase :**
   - Créez un projet sur [supabase.com](https://supabase.com).
   - Dans **SQL Editor**, exécutez [`supabase/schema.sql`](supabase/schema.sql).
   - Récupérez `Project URL` et la clé `anon` dans **Project Settings → API**.
   - Facultatif : désactivez **Authentication → Providers → Email → Confirm email** pour tester sans confirmation d'email.
3. **OpenWeatherMap :** créez une clé gratuite sur [openweathermap.org](https://home.openweathermap.org/api_keys). L'activation peut prendre jusqu'à 2 h.
4. **Variables d'environnement :**
   ```bash
   cp .env.example .env   # puis renseigner les 3 valeurs
   ```
   Le fichier `.env` est déclaré comme asset (obligatoire pour compiler) et n'est jamais commité. S'il est absent ou incomplet au lancement, l'app affiche un écran « Configuration invalide ».

   `.env` est embarqué dans l'APK : la clé OWM est extractible (usage démo) ; la clé anon Supabase est publique par conception, les données sont protégées par la RLS.

## Lancer

```bash
cp .env.example .env 
flutter pub get
dart run build_runner build -d 
flutter run
```

## Tests

```bash
cp .env.example .env
flutter test
```