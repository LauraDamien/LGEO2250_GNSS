# LGEO2250

**Facteurs influençant le choix de destination Erasmus**

## AUTEURS

- Lucas Wautot
- Nicolas Jamar Rodriguez
- Eléonore Vanderlinden
- Laura Damien

Cours: LGEO2250 – Mesures de terrain en Géographie  
Institution: UCLouvain – Earth and Life Institute

## DESCRIPTION

Ce dépôt contient les données et scripts associés à une enquête visant à identifier les destinations Erasmus les plus populaires et les facteurs influençant ces préférences.

### Question de recherche

Quels facteurs influencent le choix de destination Erasmus chez les étudiants ?


## STRUCTURE DES FICHIERS

`data_raw/`  
`→ enquete_erasmus_raw.xlsx`  
Export original du questionnaire (non modifié).

`data_processed/`  
`→ enquete_erasmus_clean.csv` 
`→ enquete_erasmus_clean2.csv`  
Données nettoyées utilisées pour l’analyse.

`scripts/`  
`script_Erasmus.qmd`    
Scripts permettant les analyses et les figures. 

`metadata`  
`data_dictionary.csv`  
`LICENSE.txt`

## REPRODUCTION DES ANALYSES

Les analyses peuvent être reproduites en :
1. Chargeant data_processed/enquete_erasmus_clean.csv et data_processed/enquete_erasmus_clean2.csv
2. Exécutant les scripts du dossier scripts/
3. Toutes les figures présentées sont générées automatiquement lors de l’exécution des scripts situés dans le dossier scripts/.

## CONFORMITÉ RGPD

Aucune donnée personnelle identifiable n’est incluse.

## CITATION DU JEU DE DONNÉES

Wautot L., Jamar Rodriguez N., Vanderlinden E., Damien L. (2026).
Erasmus Survey Dataset. UCLouvain.

Les métadonnées complètes du jeu de données sont disponibles dans :
metadata/metadata.md

## License

This project is licensed under the **MIT License**.  
See the [LICENSE](./LICENSE) file for details.
