-- TRANSACTIONS --
-- creation de la bdd test
CREATE DATABASE IF NOT EXISTS test;
-- utilisation de la bdd test
USE test;

DROP TABLE IF EXISTS tv;

CREATE TABLE tv (
	id INT PRIMARY KEY AUTO_INCREMENT,
	marque VARCHAR(50),
	modele VARCHAR(50),
	taille SMALLINT,
	annee DATE
);

-- insertion de données
INSERT INTO tv(marque, modele, taille, annee) VALUES ("Panasonic", "xyz", 55, "2003-12-01");
INSERT INTO tv(marque, modele, taille, annee) VALUES ("Sony", "abc", 65, "2013-11-15");
SELECT * FROM tv;

-- modifications éffectuées
START TRANSACTION;
	UPDATE tv SET marque = "Samsung"
	WHERE modele = "xyz";
	SELECT * FROM tv;	
COMMIT;

SELECT * FROM TV;

-- modifications annulées
START TRANSACTION;
	UPDATE tv SET marque = "LG"
	WHERE modele = "abc";
ROLLBACK;

SELECT * FROM tv;

-- insertion de donnée annulée
START TRANSACTION;
	INSERT INTO tv(marque, modele, taille, annee) VALUES ("Sony", "abc", 65, "2013-11-15");
ROLLBACK;

SELECT * FROM tv;