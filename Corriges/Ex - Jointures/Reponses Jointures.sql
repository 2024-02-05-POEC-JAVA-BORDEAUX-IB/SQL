-- desactiver only_full_group_by
-- SET sql_mode = (SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

-- activer only_full_group_by
-- SET sql_mode = CONCAT(@@sql_mode, ',ONLY_FULL_GROUP_BY');


-- Creation de la BDD films
CREATE DATABASE IF NOT EXISTS films;

-- Utilisation de la BDD films
USE films;

-- Creation Table actors
CREATE TABLE IF NOT EXISTS actors (
    actor_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    birthdate DATE
);

-- Creation Table movies
CREATE TABLE IF NOT EXISTS movies (
    movie_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    published_date INTEGER,
    note DECIMAL(3,1)
);

-- Creation Table categories
CREATE TABLE IF NOT EXISTS categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL
);

-- Creation Table movies_categories (link between categories and movies)
CREATE TABLE IF NOT EXISTS movies_categories (
    movie_id INTEGER REFERENCES movies(movie_id),
    category_id INTEGER REFERENCES categories(category_id),
    PRIMARY KEY (movie_id, category_id)
);

-- Creation Table movies_actors (link between actors and movies)
CREATE TABLE IF NOT EXISTS movies_actors (
    actor_id INTEGER REFERENCES actors(actor_id),
    movie_id INTEGER REFERENCES movies(movie_id),
    PRIMARY KEY (actor_id, movie_id)
);

-- Insertion des données dans la table categories
INSERT INTO categories (category_name) VALUES
    ('Drama'),
    ('Romance'),
    ('Mystery'),
    ('Thriller'),
    ('Musical'),
    ('Biography'),
    ('Adventure'),
    ('Sci-Fi'),
    ('Crime'),
    ('Action'),
    ('War'),
    ('History');

-- Insertion des données dans la table movies
INSERT INTO movies (title, published_date, note) VALUES
    ('The Great Gatsby', 2013, 7.2),
    ('Shutter Island', 2010, NULL),
    ('La La Land', 2016, 8.0),
    ('A Beautiful Mind', 2001, 8.2),
    ('The Shape of Water', 2017, NULL),
    ('Blade Runner 2049', 2017, NULL),
    ('Jurassic Park', 1993, NULL),
    ('Fight Club', 1999, 8.8),
    ('The Matrix', 1999, 8.7),
    ('The Godfather', 1972, 9.2),
    ('Pulp Fiction', 1994, 8.9),
    ('The Dark Knight', 2008, 9.0),
    ('The Dark Knight Rises', 2012, 8.4),
    ('Forrest Gump', 1994, 8.8),
    ('Goodfellas', 1990, 8.7),
    ('Saving Private Ryan', 1998, 8.6),
    ('Gladiator', 2000, 8.5),
    ('Titanic', 1997, 7.8),
    ('The Revenant', 2015, 8.0),
    ('Spider-Man', 2002, 7.4),
    ('Dunkirk', 2017, 7.8),
    ('Inception', 2010, 8.8),
    ('Wonder Woman', 2017, 7.4);

-- Insertion des données dans la table actors
INSERT INTO actors (name, birthdate) VALUES
    ('Tobey Maguire', NULL),
    ('Willem Dafoe', NULL),
    ('Leonardo DiCaprio', '1974-11-11'),
    ('Cillian Murphy', '1976-05-25'),
    ('Kate Winslet', '1975-10-05'),
    ('Russell Crowe', '1964-04-07'),
    ('Tom Hanks', '1956-07-09'),
    ('Matt Damon', '1970-10-08'),
    ('Samuel L. Jackson', '1948-12-21'),
    ('Robert De Niro', '1943-08-17'),
    ('Gal Gadot', '1985-04-30'),
    ('Christian Bale', '1974-01-30'),
    ('Joseph Gordon-Levitt', '1981-02-17'),
    ('Tom Hardy', '1977-09-15'),
    ('John Travolta', '1954-02-18'),
    ('Keanu Reeves', '1964-09-02'),
    ('Laurence Fishburne', '1961-07-30'),
    ('Brad Pitt', '1963-12-18'),
    ('Ryan Gosling', '1980-11-12'),
    ('Al Pacino', '1940-04-25'),
    ('Robin Wright', '1966-04-08');

-- Insertion des données dans la table movies_categories
INSERT INTO movies_categories (movie_id, category_id) VALUES
    (1, 1),   -- The Great Gatsby: Drama
    (1, 2),   -- The Great Gatsby: Romance
    (2, 3),   -- Shutter Island: Mystery
    (2, 4),   -- Shutter Island: Thriller
    (3, 1),   -- La La Land: Drama
    (3, 5),   -- La La Land: Musical
    (4, 6),   -- A Beautiful Mind: Biography
    (4, 1),   -- A Beautiful Mind: Drama
    (5, 7),   -- The Shape of Water: Adventure
    (5, 1),   -- The Shape of Water: Drama
    (6, 8),   -- Blade Runner 2049: Sci-Fi
    (6, 4),   -- Blade Runner 2049: Thriller
    (7, 7),   -- Jurassic Park: Adventure
    (7, 8),   -- Jurassic Park: Sci-Fi
    (8, 1),   -- Fight Club: Drama
    (9, 10),  -- The Matrix: Action
    (9, 8),   -- The Matrix: Sci-Fi
    (10, 9),  -- The Godfather: Crime
    (10, 1),  -- The Godfather: Drama
    (11, 9),  -- Pulp Fiction: Crime
    (11, 1),  -- Pulp Fiction: Drama
    (12, 10), -- The Dark Knight: Action
    (12, 9),  -- The Dark Knight: Crime
    (13, 10), -- The Dark Knight Rises: Action
    (13, 9),  -- The Dark Knight Rises: Crime
    (14, 1),  -- Forrest Gump: Drama
    (14, 2),  -- Forrest Gump: Romance
    (15, 6),  -- Goodfellas: Biography
    (15, 9),  -- Goodfellas: Crime
    (16, 1),  -- Saving Private Ryan: Drama
    (16, 11), -- Saving Private Ryan: War
    (17, 10), -- Gladiator: Action
    (17, 7),  -- Gladiator: Adventure
    (18, 1),  -- Titanic: Drama
    (18, 2),  -- Titanic: Romance
    (19, 10), -- The Revenant: Action
    (19, 7),  -- The Revenant: Adventure
    (20, 10), -- Spider-Man: Action
    (20, 8),  -- Spider-Man: Sci-Fi
    (21, 10), -- Dunkirk: Action
    (21, 12), -- Dunkirk: History
    (22, 10), -- Inception: Action
    (22, 7),  -- Inception: Adventure
	(23, 10), -- Wonder Woman: Action
    (23, 7);  -- Wonder Woman: Adventure

-- Insertion des données dans la table movies_actors
INSERT INTO movies_actors (actor_id, movie_id) VALUES
    (1, 1),   -- Tobey Maguire dans The Great Gatsby
    (1, 20),  -- Tobey Maguire dans Spider-Man
    (2, 20),  -- Willem Dafoe dans Spider-Man
    (3, 1),   -- Leonardo DiCaprio dans The Great Gatsby
    (3, 2),   -- Leonardo DiCaprio dans Shutter Island
    (3, 18),  -- Leonardo DiCaprio dans Titanic
    (3, 19),  -- Leonardo DiCaprio dans The Revenant
    (3, 22),  -- Leonardo DiCaprio dans Inception
    (4, 21),  -- Cillian Murphy dans Dunkirk
    (4, 12),  -- Cillian Murphy dans The Dark Knight
    (5, 18),  -- Kate Winslet dans Titanic
    (6, 4),   -- Russell Crowe dans A Beautiful Mind
    (6, 17),  -- Russell Crowe dans Gladiator
    (7, 14),  -- Tom Hanks dans Forest Gump
    (7, 16),  -- Tom Hanks dans Saving Private Ryan
    (8, 16),  -- Matt Damon dans Saving Private Ryan
    (9, 11),  -- Samuel L. Jackson dans Pulp Fiction
    (9, 15),  -- Samuel L. Jackson dans Goodfellas
    (10, 15), -- Robert De Niro dans Goodfellas
    (11, 23), -- Gal Gadot dans Wonder Woman
    (12, 12), -- Christian Bale dans The Dark Knight
    (12, 13), -- Christian Bale dans The Dark Knight Rises
    (13, 12), -- Joseph Gordon-Levitt dans The Dark Knight
    (14, 21), -- Tom Hardy dans Dunkirk
    (14, 13), -- Tom Hardy dans The Dark Knight Rises
    (14, 19), -- Tom Hardy dans The Revenant
    (14, 22), -- Tom Hardy dans Inception
    (15, 11), -- John Travolta dans Pulp Fiction
    (16, 9),  -- Keanu Reeves dans The Matrix
    (17, 9),  -- Laurence Fishburne dans The Matrix
    (18, 8),  -- Brad Pitt dans Fight Club
    (19, 3),  -- Ryan Gosling dans La La Land
    (19, 6),  -- Ryan Gosling dans Blade Runner 2049
    (20, 10), -- Al Pacino dans The Godfather
    (21, 14), -- Robin Wright dans Forrest Gump
    (21, 23); -- Robin Wright dans Wonder Woman

-- 1. liste des films par titre décroissant et année de parrution
SELECT title, published_date AS year
FROM movies
ORDER BY title DESC;

-- 2. liste des films avec 'Drama' comme categorie
-- solution 1 avec JOIN
SELECT DISTINCT m.title, m.published_date AS year
FROM movies AS m
JOIN movies_categories mc ON m.movie_id = mc.movie_id
JOIN categories c ON mc.category_id = c.category_id
WHERE c.category_name = 'Drama';

-- solution 2 sans JOIN
SELECT DISTINCT m.title, m.published_date AS YEAR
FROM movies AS m, movies_categories AS mc, categories AS c
WHERE m.movie_id = mc.movie_id AND mc.category_id = c.category_id AND c.category_name = 'Drama';


-- 3. liste des films d'Action et d'Aventure
SELECT m.movie_id, m.title
FROM movies AS m
JOIN movies_categories mc ON m.movie_id = mc.movie_id
JOIN categories c ON mc.category_id = c.category_id
WHERE c.category_name IN ('Action', 'Adventure')
GROUP BY m.movie_id
HAVING COUNT(DISTINCT c.category_name) = 2;

-- 4. Liste des films dont le titre commence par "The".
SELECT title, published_date AS year
FROM movies
WHERE title LIKE 'The%';

-- 5. Les id des 3 films les mieux notés et leurs notes avec deux chiffres apres la virgule
SELECT movie_id, FORMAT(note, 2) AS score
FROM movies
ORDER BY note DESC
LIMIT 3;

-- 6. Le film le plus ancien.
SELECT title, published_date
FROM movies
ORDER BY published_date ASC
LIMIT 1;

-- 7. L'acteur le plus jeune.
-- solution 1 avec YEAR, MONTH, DAY et NOW
SELECT 
    actor_id, name, 
    YEAR(NOW()) - YEAR(birthdate) - 
        (MONTH(NOW()) < MONTH(birthdate) OR 
        (MONTH(NOW()) = MONTH(birthdate) AND DAY(NOW()) < DAY(birthdate))) AS age
FROM actors
ORDER BY birthdate DESC
LIMIT 1;

-- solution 2 avec TIMESTAMPDIFF, CURDATE
SELECT name, TIMESTAMPDIFF(YEAR, birthdate, CURDATE()) AS age
FROM actors
WHERE birthdate IS NOT NULL
ORDER BY age
LIMIT 1;

-- 8. Liste des films sortis dans les années 1990
SELECT m.title, m.published_date AS year
FROM movies AS m
WHERE published_date BETWEEN 1990 AND 1999
ORDER BY published_date;

-- 9. Les films sortis entre 2010 et 2015.
SELECT m.title, m.published_date AS year
FROM movies AS m
WHERE published_date BETWEEN 2010 AND 2015
ORDER BY published_date;

-- 10. Quelle est l'année la plus prolifique pour la réalisation de films dans ce jeu de données ?
SELECT published_date, COUNT(*) as film_count
FROM movies
GROUP BY published_date
ORDER BY film_count DESC
LIMIT 1;

-- 11. Combien de films ont été réalisés avant l'année 2000 ?
SELECT COUNT(*) AS NbFilms
FROM movies
WHERE published_date < 2000;

-- 12. Quel âge a chaque acteur ?
SELECT name, TIMESTAMPDIFF(YEAR, birthdate, NOW()) AS age
FROM actors
ORDER BY age DESC;

-- 13. Quel est l'âge moyen des acteurs ?
SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR, birthdate, CURDATE()))) AS 'Age moyen'
FROM actors
WHERE birthdate IS NOT NULL;

--14. Quels sont les âges minimum et maximum des acteurs ? Utilisez une seule requête.
SELECT MIN(TIMESTAMPDIFF(YEAR, birthdate, CURDATE())) AS min_age,
	   MAX(TIMESTAMPDIFF(YEAR, birthdate, CURDATE())) AS max_age
FROM actors
WHERE birthdate IS NOT NULL;

-- 15. Pouvez-vous m'aider à vous rappeler un film avec "2049" dans son titre ?
SELECT m.movie_id, title, published_date AS year, GROUP_CONCAT(c.category_name ORDER BY c.category_name ASC SEPARATOR '/') AS categories
FROM movies AS m
JOIN movies_categories mc ON m.movie_id = mc.movie_id
JOIN categories c ON mc.category_id = c.category_id
WHERE title LIKE '%2049%'
GROUP BY m.movie_id, m.title, m.published_date;

-- 16. Quelles sont mes options pour regarder des films de crime et de biographie ?
-- solution 1 : affichant que les categories selectionnées
SELECT m.movie_id, m.title, m.published_date AS year, GROUP_CONCAT(c.category_name SEPARATOR '/') AS categories
FROM movies AS m
JOIN movies_categories mc ON m.movie_id = mc.movie_id
JOIN categories c ON mc.category_id = c.category_id
WHERE c.category_name IN ('Crime', 'Biography')
GROUP BY m.movie_id, m.title, m.published_date;

-- 16. Quelles sont mes options pour regarder des films de crime et de biographie ?
-- solution affichant par ordre alphabetique toutes les categories des films coorespondant a une des categories recherchées.
SELECT m.movie_id, m.title, m.published_date AS year, GROUP_CONCAT(c.category_name  ORDER BY c.category_name ASC SEPARATOR '/') AS categories
FROM movies AS m
JOIN movies_categories mc ON m.movie_id = mc.movie_id
JOIN categories c ON mc.category_id = c.category_id
WHERE m.movie_id IN (
   		SELECT DISTINCT m.movie_id
        	FROM movies AS m
        	JOIN movies_categories mc ON m.movie_id = mc.movie_id
        	JOIN categories c ON mc.category_id = c.category_id
        	WHERE c.category_name IN ('Crime', 'Biography')
    	)
GROUP BY m.movie_id, m.title, m.published_date;

-- 17. Utilisez la clause CASE pour répertorier les entrées dans la table des notes comme suit : >= 9 Génial, > 8,5 Très bien, >= 7 Bien, <= 5 Ennuyeux.
SELECT note AS score,
    CASE
		WHEN note >= 9 THEN 'Génial'
		WHEN note > 8.5 THEN 'Très bien'
        WHEN note >= 7 THEN 'Bien'
        WHEN note <= 5 THEN 'Ennuyeux'
        ELSE 'Pas de note'
    END AS quote
FROM movies
WHERE note IS NOT NULL;

-- 18. Collecter la liste des acteurs et les films dans lesquels ils ont joué.
SELECT a.actor_id AS id, a.name AS acteur, GROUP_CONCAT(m.title SEPARATOR ', ') AS films
FROM actors AS a
JOIN movies_actors ma ON a.actor_id = ma.actor_id
JOIN movies m ON ma.movie_id = m.movie_id
GROUP BY a.actor_id, a.name
ORDER BY a.actor_id;
