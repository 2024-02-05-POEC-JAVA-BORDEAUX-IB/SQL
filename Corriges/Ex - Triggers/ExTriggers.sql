CREATE DATABASE IF NOT EXISTS test;
USE test;

-- Création de la table des employés
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    salary DECIMAL(10, 2)
);

-- Création de la table de journal des modifications
CREATE TABLE employee_audit_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    action_type VARCHAR(10),
    action_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    OLD_employee_name VARCHAR(50),
    OLD_salary DECIMAL(10, 2),
    NEW_employee_name VARCHAR(50),
    NEW_salary DECIMAL(10, 2)
);

-- Création du déclencheur pour l'INSERT dans la table des employés
DELIMITER //
CREATE TRIGGER employee_audit_insert_trigger
AFTER INSERT
ON employees FOR EACH ROW
BEGIN
    INSERT INTO employee_audit_log (
        employee_id,
        action_type,
        NEW_employee_name,
        NEW_salary
    ) VALUES (
        NEW.employee_id,
        'INSERT',
        NEW.employee_name,
        NEW.salary
    );
END;
//
DELIMITER ;

-- Création du déclencheur pour l'UPDATE dans la table des employés
DELIMITER //
CREATE TRIGGER employee_audit_update_trigger
AFTER UPDATE
ON employees FOR EACH ROW
BEGIN
    INSERT INTO employee_audit_log (
        employee_id,
        action_type,
        OLD_employee_name,
        OLD_salary,
        NEW_employee_name,
        NEW_salary
    ) VALUES (
        OLD.employee_id,
        'UPDATE',
        OLD.employee_name,
        OLD.salary,
        NEW.employee_name,
        NEW.salary
    );
END;
//
DELIMITER ;

-- Création du déclencheur pour le DELETE dans la table des employés
DELIMITER //
CREATE TRIGGER employee_audit_delete_trigger
AFTER DELETE
ON employees FOR EACH ROW
BEGIN
    INSERT INTO employee_audit_log (
        employee_id,
        action_type,
        OLD_employee_name,
        OLD_salary
    ) VALUES (
        OLD.employee_id,
        'DELETE',
        OLD.employee_name,
        OLD.salary
    );
END;
//
DELIMITER ;


-- test avec une insertion, suppression et modification.
-- insertion
INSERT INTO employees (employee_id, employee_name, salary)
VALUES (1, 'John Doe', 50000.00);

-- modification
UPDATE employees
SET salary = 55000.00
WHERE employee_id = 1;

-- suppression
DELETE FROM employees
WHERE employee_id = 1;