# LGEO2250 – GNSS Terrain Survey (PPK)

## AUTEURS

- Luc Ntede Anegue
- Roseline Maillard
- Eléonore Vanderlinden
- Laura Damien

Cours: LGEO2250 – Mesures de terrain en Géographie  
Institution: UCLouvain – Earth and Life Institute

## DESCRIPTION

Ce dépôt contient les données GNSS collectées lors du terrain à la Place Louis Pasteur, ainsi que les traitements effectués pour produire une cartographie précise du site. Les données ont été acquises à l’aide de deux récepteurs GNSS (base et rover) et traitées en Post-Processing Kinematic (PPK) afin d’améliorer la précision des positions.

### Objectif

Réaliser une cartographie de la Place Louis Pasteur à l’aide de relevés GNSS et comparer la précision des positions obtenues avec et sans corrections (PPK).

## STRUCTURE DES FICHIERS

data_raw/
→ base_raw.ubx
→ rover_raw.ubx
Données GNSS brutes enregistrées sur le terrain (base et rover).

data_processed/
→ survey_raw.csv
→ survey_corrected.csv
Données de relevé GNSS avant et après corrections PPK.

scripts/
traitement_ppk
Traitement des données réalisé avec Emlid Studio.

metadata/
metadata.md
LICENSE.txt

## REPRODUCTION DES ANALYSES

Les analyses peuvent être reproduites en :

1. Chargeant les fichiers .ubx (base et rover)
2. Effectuant le traitement PPK dans Emlid Studio
3. Exportant le fichier CSV corrigé
4. XXX

## CONFORMITÉ RGPD

Aucune donnée personnelle identifiable n’est incluse.

## CITATION DU JEU DE DONNÉES

Ntede Anegue L., Maillard R., Vanderlinden E., Damien L. (2026).
GNSS Survey Dataset – Place Louis Pasteur. UCLouvain

Les métadonnées complètes du jeu de données sont disponibles dans :
metadata/metadata.md

## License

This project is licensed under the **MIT License**.  
See the [LICENSE](./LICENSE) file for details.
