-- JOINTURES --
CREATE DATABASE test;
USE test;

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




-- INNER JOIN
-- selection des livres ayant des auteurs
SELECT b.title, b.year_published, ba.author_id
FROM books AS b
INNER JOIN books_authors AS ba ON b.book_id = ba.book_id;

-- LEFT JOIN
-- selection des livres n'ayant pas d'auteur
SELECT b.title, b.year_published, ba.author_id
FROM books AS b
LEFT JOIN books_authors AS ba ON b.book_id = ba.book_id
WHERE ba.author_id IS NULL;

-- JOIN -> jointure sur 3 tables ou plus
-- selectionne les livres ayant dez auteurs et affiche le nom du livre et des infos sur l'auteur
SELECT b.title, a.first_name, a.last_name
FROM books AS b
JOIN books_authors AS ba ON b.book_id = ba.book_id
JOIN authors AS a ON a.author_id = ba.author_id;

-- effacer contenu d'une table (TRUNCATE TABLE nom_table avec MySQL et postgres)
-- Dans le cas présent le suppression ne fonctionne que si on a précisé ON DELETE CASCADE sur la contrainte
DELETE FROM books;

-- si ON DELETE CASCADE n'est pas précisé il faut :
-- Supprimer les enregistrements de la table books_authors liés à la table books
-- sous requete : c'est une alternative à un JOIN.
DELETE FROM books_authors WHERE book_id IN (SELECT book_id FROM books);
-- Puis ensuite, supprimer le contenu de la table books
DELETE FROM books;