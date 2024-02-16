-- desactiver only_full_group_by
SET sql_mode = (SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

-- activer only_full_group_by
SET sql_mode = CONCAT(@@sql_mode, ',ONLY_FULL_GROUP_BY');


-- TRIGGER --
START TRANSACTION;

CREATE DATABASE IF NOT EXISTS test;
USE test;

CREATE TABLE IF NOT EXISTS livres (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(50),
	date_creation DATETIME
	);

DELIMITER //
CREATE TRIGGER IF NOT EXISTS before_insert_livre
BEFORE INSERT
ON livres
FOR EACH ROW
BEGIN
	SET NEW.date_creation = NOW();
END;
//
DELIMITER ;

INSERT INTO livres (name) VALUES ("SQL pour les nuls");

SELECT * FROM livres;
COMMIT;
