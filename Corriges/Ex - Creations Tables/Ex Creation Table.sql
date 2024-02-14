-- Creation d'une base de donnée test
CREATE DATABASE test;
-- Utilisation de la bdd test
USE test;

/*
1 - Creer une table simple nommée tv
ajouter les attributs suivants :
	id
	marque
	modele
	taille
	annee
*/

CREATE TABLE tv (
	id INT PRIMARY KEY AUTO_INCREMENT,
	marque VARCHAR(50),
	modele VARCHAR(50),
	taille SMALLINT,
	annee DATE
);

/*
2 - Un étudiant a un seul dossier étudiant.
Implémentez cette association en créant deux tables : etudiants et dossiers_etudiants.

La table etudiants doit contenir les colonnes suivantes :
    id_etudiant (clé primaire, auto-incrémentée)
    nom
    prenom
    id_dossier (clé étrangère référençant l'ID du dossier étudiant dans la table dossiers_etudiants)

La table dossiers_etudiants doit contenir les colonnes suivantes :
    id_dossier (clé primaire, auto-incrémentée)
    informations (texte)
*/

CREATE TABLE dossiers_etudiants (
    id_dossier INT PRIMARY KEY AUTO_INCREMENT,
    informations TEXT
);

CREATE TABLE etudiants (
	id_etudiant INT PRIMARY KEY AUTO_INCREMENT,
	nom VARCHAR(255),
	prenom VARCHAR(255),
	id_dossier INT,
	FOREIGN KEY (id_dossier) REFERENCES dossiers_etudiants(id_dossier)
);

/*
3 - Une classe a plusieurs étudiants.
Implémentez cette association en créant deux tables : classes et etudiants.

La table classes doit contenir les colonnes suivantes :
    id_classe
    nom_classe

La table etudiants doit contenir les colonnes suivantes :
    id_etudiant
    nom
    prenom
    id_classe
*/

CREATE TABLE classes (
	id_classe INT PRIMARY KEY AUTO_INCREMENT,
	nom_classe VARCHAR(255)
);

CREATE TABLE etudiants (
	id_etudiant INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255),
    prenom VARCHAR(255),
    id_classe INT,
    FOREIGN KEY (id_classe) REFERENCES classes(id_classe)
);
	
/*
4 - Un professeur peut enseigner à plusieurs classes et une classe peut avoir plusieurs professeurs.
Implémentez cette association en créant trois tables : professeurs, classes et cours.

La table professeurs doit contenir les colonnes suivantes :
    id_professeur
    nom
    prenom

La table classes doit contenir les colonnes suivantes :
    id_classe
    nom_classe

La table cours (table de jointure) doit contenir les colonnes suivantes :
    id_professeur
    id_classe
*/

CREATE TABLE professeurs (
	id_professeur INT PRIMARY KEY AUTO_INCREMENT,
	nom VARCHAR(255),
	prenom VARCHAR(255)
);

CREATE TABLE classes (
	id_classe INT PRIMARY KEY AUTO_INCREMENT,
	nom_classe VARCHAR(255)
);

CREATE TABLE cours (
	id_professeur INT,
	id_classe INT,
	PRIMARY KEY (id_professeur, id_classe),
	FOREIGN KEY (id_professeur) REFERENCES professeurs(id_professeur),
	FOREIGN KEY (id_classe) REFERENCES classes(id_classe)
);

/*
5 - Vous avez à concevoir une base de données pour gérer des informations sur différents animaux, en utilisant le concept d'HERITAGE en UML.
La classe mère s'appelle "Animal", et deux classes filles : "Chien" et "Chat".

Classe "Animal" :
    id
	nom
	type_animal
	date_naissance
	poids
	couleur

Classe "Chien" (classe fille de "Animal") :
    id
	race

Classe "Chat" (classe fille de "Animal") :
    id
	longueur_poils
*/

-- Table pour la classe mère "animal"
CREATE TABLE animal (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    type_animal VARCHAR(50) NOT NULL,
    date_naissance DATE,
    poids DECIMAL(5, 2),
    couleur VARCHAR(30)
);

-- Table pour la classe fille "chien"
CREATE TABLE chien (
	id INT PRIMARY KEY,
    race VARCHAR(50),
    FOREIGN KEY (id) REFERENCES animal(id)
);

-- Table pour la classe fille "chat"
CREATE TABLE chat (
	id INT PRIMARY KEY,
    longueur_poils VARCHAR(50),
    FOREIGN KEY (id) REFERENCES animal(id)
);


/*
6 - Vous êtes chargé de concevoir une base de données pour suivre les informations sur différents animaux en utilisant le concept de COMPOSITION en UML.
La classe mère s'appelle "Animal", et deux classes filles sont définies : "Chien" et "Chat".

Classe "Animal" :
    id
	nom
	date_naissance
	poids
	couleur

Classe "Chien" (classe fille de "Animal") :
    id
	race

Classe "Chat" (classe fille de "Animal") :
	id
	longueur_poils
*/

-- Table pour la classe mère "animal"
CREATE TABLE animal (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    date_naissance DATE,
    poids DECIMAL(5, 2),
    couleur VARCHAR(30)
);

-- Table pour la classe fille "chien"
CREATE TABLE chien (
	id INT PRIMARY KEY,
    animal_id INT,
    race VARCHAR(50),
    FOREIGN KEY (id) REFERENCES animal(id),
    FOREIGN KEY (animal_id) REFERENCES animal(id)
);

-- Table pour la classe fille "chat"
CREATE TABLE chat (
	id INT PRIMARY KEY,
    animal_id INT,
    longueur_poils VARCHAR(50),
    FOREIGN KEY (id) REFERENCES animal(id),
    FOREIGN KEY (animal_id) REFERENCES animal(id)
);
