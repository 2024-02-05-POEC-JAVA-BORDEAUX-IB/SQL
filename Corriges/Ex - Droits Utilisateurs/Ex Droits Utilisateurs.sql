-- question 1
-- Création de la base de données
CREATE DATABASE ma_bdd;

-- Utilisation de la base de données
USE ma_bdd;

-- Création de la table
CREATE TABLE ma_table (
    id INT PRIMARY KEY,
    nom VARCHAR(50),
    description TEXT
);

-- Insertion de quelques données dans la table (facultatif)
INSERT INTO ma_table (id, nom, description) VALUES
(1, 'Donnée 1', 'Description de la donnée 1'),
(2, 'Donnée 2', 'Description de la donnée 2');

-- question 2
CREATE USER 'nouvel_utilisateur'@'localhost' IDENTIFIED BY 'mdp123';

-- question 3
-- attention * est considerée comme une table à part entière qui gère les accès des autres tables.
-- si on veut supprimer un droit sur une table, il faut qu'il soit existant sur cette table.
-- on peut pas supprimer un droit sur une table specifique si on lui a pas donner.
-- exemple on donne des droits sur *, il faudra supprimer sur * et non sur une autre table.

-- acces sur *
GRANT ALL PRIVILEGES ON ma_bdd.* TO 'nouvel_utilisateur'@'localhost';
FLUSH PRIVILEGES;

-- acces sur ma_table
GRANT ALL PRIVILEGES ON ma_bdd.ma_table TO 'nouvel_utilisateur'@'localhost';
FLUSH PRIVILEGES;

-- question 4
-- suppression sur *
REVOKE SELECT ON ma_bdd.* FROM 'nouvel_utilisateur'@'localhost';
FLUSH PRIVILEGES;

-- suppression sur ma_table
REVOKE SELECT ON ma_bdd.ma_table FROM 'nouvel_utilisateur'@'localhost';
FLUSH PRIVILEGES;

-- question 5
SHOW GRANTS FOR 'nouvel_utilisateur'@'localhost';
