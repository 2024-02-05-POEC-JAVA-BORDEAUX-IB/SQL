/*
Explication élaboration d'une requête avec SELECT
SELECT -- Obligatoire, les champs à retourner (colonnes)
FROM -- Obligatoire, la table concerné par les requêtes (table)
WHERE -- Optionnel conditions pour filtrer les résultats (conditions =, != , LIKE, IN etc)
AND ou OR -- Combiner plusieurs conditions à la suite
GROUP BY -- Optionnel, regrouper les informations suite à l'utilisation des fonctions d'agrégations (AVG, MIN, MAX, SUM, GROUP_CONCAT, etc.)
ORDER BY -- Optionnel organisation des résultats soit croissant ASC ou décroissant DESC (ACS ou DESC)
LIMIT -- Optionnel Limiter le nombre de résultat (penser à la pagination)
OFFSET -- Optionnel A partir du résultat X (Par défaut offset vaut 0 donc il commence au tout premier résultat)
*/

-- 1. Station le plus frequentée en 2021
SELECT station AS "Station qui differe selon SGBDR", MAX(trafic) AS "Max"
FROM `2021`;


-- 2. Station le moins frequentée en 2021
-- solution avec backtick
SELECT station, MIN(trafic) AS trafic
FROM `2021`;

-- solution sans backtick
SET @@session.sql_mode=ANSI_QUOTES;
-- 2. Station le moins frequentée en 2021
SELECT station, MIN(trafic) AS trafic
FROM "2021";

-- 3. Total trafic
SELECT SUM(trafic) AS total
FROM `2021`;

-- 4. Stations par arrondissement
SELECT paris_district AS 'Arrondissement de Paris', COUNT(station) AS "Total stations"
FROM `2021`
WHERE UPPER(city) = 'PARIS' AND paris_district != ''
GROUP BY paris_district
ORDER by "Total stations" DESC;

-- 5. Total stations metro
SELECT COUNT(network) AS total_stations_metro
FROM `2021`
WHERE network='Métro';

-- 6. Total stations RER
SELECT COUNT(network) AS total_stations_rer
FROM `2021`
WHERE network != 'Métro';

-- 7. Tous les noms des stations des villes 
SELECT station, city
FROM `2021`
WHERE UPPER(city) in ('BOBIGNY','LA COURNEUVE', 'SAINT DENIS', 'PANTIN', 'MONTREUIL', 'BAGNOLET')
ORDER BY city ASC;

-- 8. Toutes les infos sur les stations de Vincennes
SELECT *
FROM `2021`
WHERE UPPER(city) = 'VINCENNES';

-- 9. Toutes les stations qui commencent par "porte"
SELECT station
FROM `2021`
WHERE UPPER(station) LIKE 'PORTE%'
ORDER BY station DESC;

-- 10. Toutes les stations qui ont un -
SELECT station, city
FROM `2021`
WHERE UPPER(station) LIKE '%-%'
ORDER BY city, station ASC;

-- 11. Toutes les stations avec une correspondance avec le RER A trié par trafic croissant
-- solution 1
SELECT station, trafic
FROM `2021`
WHERE UPPER(connection_1) = 'A'
OR UPPER(connection_2) = 'A'
OR UPPER(connection_3) = 'A'
OR UPPER(connection_4) = 'A'
OR UPPER(connection_5) = 'A'
ORDER BY trafic ASC;

-- solution 2 avec IN
SELECT station, trafic
FROM `2021`
WHERE 'A' IN (UPPER(connection_1), UPPER(connection_2), UPPER(connection_3), UPPER(connection_4), UPPER(connection_5))
ORDER BY trafic ASC;


-- 12. Toutes les infos sur Gagny (aucune station dans la base de données porte ce nom donc 0 resultat)
SELECT *
FROM `2021`
WHERE UPPER(station) = 'GAGNY';

-- 13. Toutes les stations de la ligne 14
-- solution 1
SELECT LOWER(GROUP_CONCAT(station SEPARATOR ', ')) AS "Station de la ligne 14"
FROM `2021`
WHERE connection_1 = '14'
OR connection_2 = '14'
OR connection_3 = '14'
OR connection_4 = '14'
OR connection_5 = '14';

-- solution 2
-- avec IN
SELECT LOWER(GROUP_CONCAT(station SEPARATOR ', ')) AS "Station de la ligne 14"
FROM `2021`
WHERE '14' IN (connection_1, connection_2, connection_3, connection_4, connection_5);

-- 14. Les 5 stations de la ligne 1 les plus frequentés
SELECT station, trafic
FROM `2021`
WHERE connection_1 = '1'
OR connection_1 = '1'
OR connection_2 = '1'
OR connection_3 = '1'
OR connection_4 = '1'
OR connection_5 = '1'
ORDER BY trafic DESC
LIMIT 5 OFFSET 0;

-- solution 2
-- Avec IN
SELECT station, trafic
FROM `2021`
WHERE '1' IN (connection_1, connection_1, connection_2, connection_3, connection_4, connection_5)
ORDER BY trafic DESC
LIMIT 5 OFFSET 0;


-- BONUS
-- 1. Moyenne des fréquentations de l'ensemble des stations du 13ème arrondissement
SELECT AVG(trafic) AS "moyenne frequentation" FROM `2021` WHERE paris_district = 13;

-- 2. Toutes les villes différentes de Paris
SELECT DISTINCT city
FROM `2021`
WHERE UPPER(city) != 'PARIS'
ORDER BY city ASC;

-- 3. Stations avec "marie" ou "ville" dans le nom
SELECT station
FROM `2021`
WHERE station LIKE '%mairie%' OR station LIKE '%ville%'
ORDER BY station ASC;

-- 4. La somme des fréquentations par arrondissements de Paris
SELECT DISTINCT city, paris_district, SUM(trafic) OVER (PARTITION BY paris_district) AS total
FROM `2021`
WHERE city = 'Paris' AND paris_district != ''
ORDER BY total DESC;
