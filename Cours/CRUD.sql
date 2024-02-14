-- recreation des tables puis insertion de données --

-- suppression des tables si elles exitent
DROP TABLE IF EXISTS books_authors;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS authors;


-- creation des tables
CREATE TABLE books (
    book_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150) NOT NULL,
    year_published SMALLINT NOT NULL,
    publisher VARCHAR(50) NOT NULL,
    price DECIMAL(6, 2) NOT NULL CHECK (price >= 0 AND price <= 9999.99)
);

CREATE TABLE authors (
    author_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name  VARCHAR(50) NOT NULL
);

CREATE TABLE books_authors (
    author_id INT,
    book_id INT,
    PRIMARY KEY (author_id, book_id),
    FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON UPDATE CASCADE
	-- sans ON DELETE CASCADE impossible de faire DELETE authors à cause de la contrainte
	-- sans ON UPDATE CASCADE impossible de faire UPDATE books à cause de la contrainte
);

INSERT INTO books (title, year_published, publisher, price) VALUES
('Introduction au SQL', 2000, 'Packt', 15.49),
('La methode Agile', 2005, 'Oreilly', 23.99),
('Git & GitHub', 2020, 'Oreilly', 41.99),
('SQL pour l''analyse des données', 2021, 'Oreilly', 59.99),
('Le CSS', 2014, 'Wiley', 15.99),
('SQL : éléments internes de la base de données', 2018, 'Packt', 63.75),
('Java: Introduction', 2014,'Wiley', 11.99),
('Laravel pour les nuls', 2012, 'Apress', 23.99),
('L''art du SQL', 2015, 'Wiley', 27.75);

INSERT INTO authors (first_name, last_name) VALUES ('Xavier', 'Dupont'), ('Christophe', 'Laporte'), ('Pascal', 'Louis'), ('Claire', 'Martin');
INSERT INTO books_authors (book_id, author_id) VALUES (1, 3),(4, 4),(5, 4),(3, 1),(7, 3),(8, 3),(6, 3),(8, 2);




-- CRUD --
SELECT * FROM books;
SELECT * FROM books LIMIT 1;
SELECT title FROM books;
SELECT title, price FROM books;
SELECT 3+3;SELECT 3+3;
SELECT 3+3 AS "somme des nombres";
SELECT 3+3 FROM books;
SELECT 3+3, title FROM books;
SELECT title, 2024-year_published FROM books;
SELECT title, 2024-year_published AS Age FROM books;

-- en sqlite ou MySQL : LIKE est insensible à la casse.
-- pour faire une comparaison avec des minuscule ou majuscule : utiliser LOWER ou UPPER sur le nom de la colonne
SELECT * FROM books WHERE LOWER(title) LIKE '%sql%';

-- Opérateur UNION
SELECT title FROM books WHERE title LIKE '%sql%'
UNION
SELECT title FROM books WHERE title LIKE '%css%';

SELECT title, publisher, SUM(price) OVER (PARTITION BY publisher ORDER BY price) AS total_price
FROM books;


-- Table temporaire en BONUS si y a le temps
-- selection des livre sql a un prix inferieur a 30
WITH
	sql_books AS (SELECT * FROM books WHERE title LIKE '%sql%'),
	affordable_books AS (SELECT * from books WHERE price < 30)
	SELECT * FROM affordable_books WHERE book_id IN (SELECT book_id FROM sql_books);