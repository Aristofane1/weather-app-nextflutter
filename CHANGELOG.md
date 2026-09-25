# Changelog

Toutes les évolutions notables de ce projet sont documentées ici.
Format : [Keep a Changelog](https://keepachangelog.com/fr/1.1.0/), versions : [SemVer](https://semver.org/lang/fr/).

## [Unreleased]

## [1.2.0]

### Ajouté
- Internationalisation FR / EN (`flutter gen-l10n`), sélecteur de langue dans Profil (mémorisé), descriptions météo OWM dans la langue choisie.
- Accessibilité : labels sémantiques sur les éléments interactifs (le bouton favori nomme la ville), annonce en une phrase des tuiles ville, état « favori » exposé, tests des guidelines Flutter (taille des cibles, labels, contraste).
- Icônes météo mises en cache sur disque (`cached_network_image`) et décodées à la taille affichée.
- Test d'intégration du parcours complet (connexion → ajout d'une ville → détail → déconnexion) sur de faux repositories.
- CI GitHub Actions : analyse statique, tests unitaires et widget, tests d'intégration sur émulateur Android, APK de debug publié en artifact.

### Modifié
- Les messages d'erreur sont traduits dans la couche présentation (`Failure` ne contient plus de texte).
- Optimisation des rebuilds : `const` systématique, `select` Riverpod, `RepaintBoundary` autour des skeletons.
- README : badges CI, captures, sections i18n, accessibilité, performance, tests, CI.

## [1.1.0]

### Corrigé
- Isolation des données entre utilisateurs : cache vidé à la connexion, à la déconnexion et à l'expiration de session.
- Requêtes rejetées (401) quand le refresh token est refusé, au lieu d'être envoyées sans jeton.
- Route de détail robuste à une URL mal formée ; écran d'erreur de configuration au lieu d'un écran blanc.


## [1.0.0]

### Ajouté
- Authentification Supabase (inscription, connexion, déconnexion) en REST via Dio, JWT injecté par intercepteur, refresh token sur 401.
- Écrans : Connexion, Inscription, Mes villes, Recherche, Détail (météo actuelle + prévisions 5 jours), Profil.
- Mode offline-first : cache Hive affiché immédiatement puis rafraîchi depuis le réseau.
- Architecture feature-first (data / domain / presentation), repository pattern, Riverpod avec génération de code, DTO freezed.
- Tests unitaires (repositories, intercepteur, mapping d'erreurs, cache) et tests widget.
