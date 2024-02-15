USE questions;

-- 1 Distribution des réponses
SELECT question_text, COUNT(response)
FROM survey_data
GROUP BY question_text
ORDER BY question_text;

-- 2 La succursale la plus populaire.
SELECT response AS location, COUNT(*)
FROM survey_data
WHERE question_text LIKE '2.%'
GROUP BY response
ORDER BY COUNT(*) DESC;

-- 3a Segmentation démographique par âge
SELECT response AS age_group, COUNT(response)
FROM survey_data 
WHERE question_text LIKE '3.%'
GROUP BY response
ORDER BY response;

-- 3b Segmentation démographique par genre
SELECT response AS gender, COUNT(response)
FROM survey_data 
WHERE question_text LIKE '4.%'
GROUP BY response
ORDER BY response;

-- 3c Segmentation démographique par revenue
SELECT response AS income_group, COUNT(response)
FROM survey_data 
WHERE question_text LIKE '5.%'
GROUP BY response
ORDER BY response;

-- 4 Score de recommandation
SELECT user_id, 
	CASE 
		WHEN CAST(response AS DECIMAL) >= 9 THEN 'Promoter'
		ELSE 'Passive'
	END AS nps_segment
FROM survey_data 
WHERE question_text LIKE '1.%'
LIMIT 8;

-- 5 Pourcentage de répondants qui agiraient en tant que promoteurs pour nos produits.
SELECT ROUND((COUNT(CASE WHEN CAST(response AS DECIMAL) >= 9 THEN 1 END) * 100.0) / COUNT(*)) AS percentage_promoters
FROM survey_data
WHERE question_text LIKE '1.%';
