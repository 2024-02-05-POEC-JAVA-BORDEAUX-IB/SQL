CREATE DATABASE IF NOT EXISTS test;
USE test;

-- ALTER TABLE book RENAME TO books;
-- ALTER TABLE books DROP COLUMN price;
-- ALTER TABLE books ADD COLUMN price DECIMAL(5,2);

-- DROP TABLE IF EXISTS books;

CREATE TABLE IF NOT EXISTS utilisateur (
	id_utilisateur INTEGER PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(50),
	last_name VARCHAR(50)
	);
CREATE TABLE IF NOT EXISTS adresse (
	id_adresse INT PRIMARY KEY AUTO_INCREMENT,
	id_utilisateur INT,
	title VARCHAR(255) NOT NULL,
	publication_date DATE,
	FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)
	);

DROP TABLE IF EXISTS adresse;
DROP TABLE IF EXISTS utilisateur;

-- heritage
CREATE TABLE IF NOT EXISTS vehicule (
	id INT PRIMARY KEY AUTO_INCREMENT,
	marque VARCHAR(50) NOT NULL,
	modele VARCHAR(50) NOT NULL,
	annee_fabrication INT,
	couleur VARCHAR(50));
	
CREATE TABLE IF NOT EXISTS voiture (
	id INT PRIMARY KEY,
	nombre_porte INT,
	FOREIGN KEY (id) REFERENCES vehicule(id));
	
CREATE TABLE IF NOT EXISTS moto (
	id INT PRIMARY KEY,
	type_moto VARCHAR(50),
	FOREIGN KEY (id) REFERENCES vehicule(id));
	
DROP TABLE IF EXISTS moto;
DROP TABLE IF EXISTS voiture;
DROP TABLE IF EXISTS vehicule;

-- Table des auteurs
CREATE TABLE authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    author_name VARCHAR(100) NOT NULL,
    birth_date DATE,
    nationality VARCHAR(50)
);

-- Table des livres
CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    publication_date DATE
);

-- Table intermédiaire représentant la composition
CREATE TABLE books_authors (
    author_id INT,
    book_id INT,
    PRIMARY KEY (author_id, book_id),
    FOREIGN KEY (author_id) REFERENCES authors(author_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

DROP TABLE IF EXISTS books_authors;
DROP TABLE IF EXISTS authors;
DROP TABLE IF EXISTS books;


-- Table des auteurs
CREATE TABLE authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    author_name VARCHAR(100) NOT NULL,
    birth_date DATE,
    nationality VARCHAR(50)
);

-- Table des livres
CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    publication_date DATE,
    -- Autres colonnes spécifiques au livre

    -- Clé étrangère pour la relation de composition
    author_id INT,
    FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE CASCADE ON UPDATE CASCADE
	-- ON DELETE CASCADE signfie que si un auteur est supprimé de la table Author, tous les livres associés à cet auteur seront également supprimés.
	-- ON UPDATE CASCADE signfie que si un auteur est mise à jour dans la table Author, tous les livres associés à cet auteur seront également mis à jour.
	-- Cela correspond davantage à une relation de composition où la suppression de l'objet composite (l'auteur) entraîne la suppression des objets inclus (les livres).
);

DROP TABLE IF EXISTS books_authors;
DROP TABLE IF EXISTS authors;
DROP TABLE IF EXISTS books;