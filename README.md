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

`Base_GNSS/`\
`→ *.26O, *.26P, *.26B, *.RTCM3, *.LLH`\
Données GNSS de la station de base.

`Rover_GNSS/`\
`→ *.ubx, *.LLH`\
Données GNSS du rover.

`Arpentage/`\
`→ non_corrigées/ (*.csv)`\
`→ corrigées/ (*_corrected.csv)`\
Données GNSS d’arpentage avant et après corrections PPK.

`GNSS_project.R`\
Script R pour traitement, interpolation (IDW) et analyses.

`metadata.md`\
`LICENSE`

## REPRODUCTION DES ANALYSES

Les analyses peuvent être reproduites en :

1. Chargeant les fichiers (base *.26O et rover *.ubx)
2. Effectuant le traitement PPK dans Emlid Studio
3. Exportant le fichier CSV corrigé 
4. Exécutant les scripts avec GNSS_project.R 
5. Toutes les figures et l'analyse statistiques présentées sont générées automatiquement lors de l’exécution de GNSS_project.R

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
