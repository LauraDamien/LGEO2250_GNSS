# Métadonnées du jeu de données

## 1. Identification du jeu de données

**Projet :** GNSS et cartographie topographique 

**Créateurs :**
- Luc Ntede Anegue  
- Laura Damien  
- Roseline Maillard  
- Éléonore Vanderlinden  

**Date de création du jeu de données :** 11/03/2026 (08h30–10h30)
**Institution :** UCLouvain - École de Géographie  
**Campagne d’échantillonnage :** Relevé GNSS, Place Louis Pasteur (Louvain-la-Neuve)
**Type de ressource :** Jeu de données géospatiales (GNSS)  
**Version :** 1.0  

---

## 2. Description du contenu

Jeu de données GNSS (N = 96 points) collecté dans le cadre d’un relevé topographique comprenant :

- Coordonnées tridimensionnelles (X, Y, Z)  
- Qualité de la solution GNSS (fix, float, single)  
- Hauteur d’antenne  
- Temps de collecte  
- Estimations d’erreurs  

Les points comprennent :
- 19 points spécifiques (éléments du terrain)  
- 77 points collectés le long de transects  

---

## 3. Méthodologie de collecte

**Méthode :** Relevé GNSS avec récepteurs Emlid (station de base + rover)  
**Stratégie d’échantillonnage :** Mixte (ciblée + systématique)  
**Période de collecte :** 03/2026  
**Date de terrain :** 11/03/2026 (08h30–10h30)  
**Contexte géographique :** Place Louis Pasteur, Louvain-la-Neuve (Belgique)  

**Protocole :**
- Station de base installée sur trépied en zone dégagée  
- Rover monté sur perche maintenue verticale  
- Acquisition via **Emlid Flow**  
- Suivi du nombre de satellites visibles  
- Mode de collecte : **averaging (5 secondes par point)**  

---

## 4. Structure des fichiers

### Données brutes
- **Fichier :** data_raw/base_station.ubx  
  - Description : Données GNSS station de base  

- **Fichier :** data_raw/rover.ubx  
  - Description : Données GNSS rover  

### Données traitées
- **Fichier :** data_processed/points_corriges.csv  
  - Description : Points GNSS corrigés (PPK)  

- **Fichier :** data_processed/points_non_corriges.csv  
  - Description : Points GNSS non corrigés  

**Format :** CSV  
**Encodage :** UTF-8  
**Séparateur :** Virgule (,)  
**Valeurs manquantes :** cellules vides  

---

## 5. Types de variables

- Variables continues :
  - Coordonnées (X, Y, Z)  
  - Hauteur d’antenne  
  - Erreurs estimées  

- Variables catégorielles :
  - Type de solution (fix, float, single)  

- Variables temporelles :
  - Temps de collecte  

- Identifiant :
  - ID unique par point  

---

## 6. Traitements effectués

- Post-traitement cinématique (**PPK**) avec **Emlid Studio**  
- Le traitement repose sur l’utilisation des données de la      station de base et du rover afin de corriger les erreurs de positionnement :
  - Atmosphériques (ionosphère, troposphère)  
  - Horloges satellites  
  - Orbites satellites  

- Paramétrage :
  - Mode : **Stop and Go**  
  - Elevation mask : **20° (au lieu de 15°)**  

- Filtrage :
  - Conservation des solutions **fix** et **float**  
  - Exclusion des solutions **single**  

---

## 7. Interopérabilité

**Formats utilisés :**
- UBX  
- CSV  

**Logiciels compatibles :**
- Emlid Studio  
- R  
- Python  
- QGIS  
- ArcGIS  
- Excel  

---

## 8. Sensibilité et protection des données

- Aucune donnée personnelle  
- Données purement géospatiales  
- Conforme aux principes du RGPD  

---

## 9. Réutilisation

Les données sont :

- Structurées  
- Nettoyées et filtrées  
- Directement exploitables pour :
  - Cartographie  
  - Analyse topographique  
  - Interpolation spatiale  

---

## 10. Qualité des données

### Sources d’erreurs

Certaines observations présentent des limitations dues à :

- Visibilité réduite des satellites  
- Effets de multipath (bâtiments, végétation)  
- Temps d’acquisition insuffisant  

### Qualité des solutions

| Type de solution | Description                     | Impact |
|------------------|---------------------------------|--------|
| Fix              | Solution entièrement corrigée   | Haute précision |
| Float            | Solution partiellement corrigée | Précision moyenne |
| Single           | Solution non corrigée           | Faible précision |

---

## 11. Licence

MIT License  

---

## 12. Provenance scientifique

Jeu de données créé dans le cadre du cours **LGEO2250 – Mesures de terrain en Géographie**  
(UCLouvain, année académique 2025–2026).

Les données ont été collectées, traitées et analysées par des étudiants en sciences géographiques dans un objectif pédagogique.