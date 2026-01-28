# Étiquettes des schémas (`sphinx_tags`)

Ce fichier est une **liste des étiquettes canoniques** utilisées dans les schémas (`.rst`) via la directive :

```rst
.. tags:: etiquette1, etiquette2, etiquette3
```

## Règles

- **Format** : minuscules, mots reliés par un trait d'union (`-`).
- **Séparation** : par des virgules (format requis par `sphinx_tags`).
- **Identifiant vs Libellé** :
  - **L'identifiant** de l'étiquette est le texte entre backticks (ex. `saint-esprit`) — gardons-le en **ASCII** (sans caractères accentués), car c'est une clé technique (liens/URL, compatibilité des outils).
  - **Le libellé** (ex. "Saint-Esprit") est pour les humains — il peut contenir des caractères spéciaux.
- **Axe de la réunion (le plus important !)** : on n'étiquette que ce qui est l'**axe** de la réunion (thème/méthode principal), pas le contexte.
  - Si un sujet apparaît "en passant" (ex. il y a une prière au début, mais la réunion n'est pas sur la prière) — **n'ajoutez pas** cette étiquette.
  - Pour les méthodes : ajoutez l'étiquette de méthode seulement si c'est un **outil de travail clé** lors de la réunion (et pas juste "nous avons discuté").
- **Sélection** : généralement **3–8 étiquettes** par fichier :
  - 1–3 étiquettes de contenu (de quoi parle la réunion)
  - 1–3 étiquettes de méthode (comment nous travaillons)
  - 0–2 étiquettes de type/caractère
  - (optionnel) 1 étiquette auxiliaire
- **On n'étiquette pas les noms des cycles de retraite** (cela découle déjà de la structure des répertoires dans `zrodla/`).

## Contenu (de quoi s'agit-il)

- `resurrection` — Résurrection
- `saint-esprit` — Saint-Esprit
- `eglise` — Église
- `communaute` — Communauté
- `unite` — Unité
- `amour` — Amour
- `service` — Service
- `liberte` — Liberté
- `responsabilite` — Responsabilité
- `vocation` — Vocation
- `mission` — Mission
- `discernement` — Discernement
- `volonte-de-dieu` — Volonté de Dieu
- `decisions` — Décisions
- `desirs` — Désirs
- `recherche` — Recherche
- `identite` — Identité
- `peche` — Péché
- `conversion` — Conversion
- `relations` — Relations
- `communication` — Communication
- `parole-de-dieu` — Parole de Dieu
- `ancien-testament` — Ancien Testament
- `priere` — Prière
- `spiritualite` — Spiritualité
- `eucharistie` — Eucharistie
- `maturite` — Maturité
- `esperance` — Espérance
- `royaume-de-dieu` — Royaume de Dieu
- `verite` — Vérité
- `croix` — Croix
- `temps` — Temps
- `ouverture` — Ouverture
- `traditions-juives` — Traditions juives


## Méthodes actives (comment nous travaillons)

- `questions-de-partage` — Questions de partage
- `discussion` — Discussion
- `carte-mentale` — Carte mentale
- `travail-spatial` — Travail spatial
- `arts-plastiques` — Arts plastiques
- `travail-sur-texte` — Travail sur texte
- `travail-sur-image` — Travail sur image
- `travail-en-groupes` — Travail en groupes
- `travail-sur-definition` — Travail sur définition
- `travail-sur-symboles` — Travail sur symboles
- `travail-avec-musique` — Travail avec musique

## Type / caractère de la réunion

- `formation` — De formation
- `evangelisation` — D'évangélisation
- `integration` — D'intégration
- `atelier` — Atelier
- `biblique` — Biblique
- `de-priere` — De prière
- `mystagogique` — Mystagogique
