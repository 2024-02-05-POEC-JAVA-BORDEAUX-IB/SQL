CREATE DATABASE IF NOT EXISTS test;
USE test;

-- Création de la table products
CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    stock_quantity INT
);

-- Création de la table orders
CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE IF NOT EXISTS results (
    results_id INT PRIMARY KEY AUTO_INCREMENT,
    results_message VARCHAR(50)
);

/*
-- inserer des données dans products et orders
INSERT INTO products VALUES (1, 'Product A', 100);
INSERT INTO products VALUES (2, 'Product B', 50);
INSERT INTO orders VALUES (1, 1, 20);
INSERT INTO orders VALUES (2, 2, 10);
*/

-- Début de la transaction
START TRANSACTION;

-- Déclarer les variables pour choisir quelle quantité à la commande et a quel produit cela se refere.
SET @product_id = 1;
SET @order_id = 1;

-- Récupérer la quantité commandée
SELECT quantity INTO @order_quantity FROM orders WHERE order_id = @order_id;

-- Récupérer la quantité en stock du produit defini par @product_id
SELECT stock_quantity INTO @stock_quantity FROM products WHERE product_id = @product_id;

-- Vérifier si la quantité en stock est suffisante
UPDATE products
SET stock_quantity = CASE 
                        WHEN @stock_quantity >= @order_quantity 
                        THEN stock_quantity - @order_quantity 
                        ELSE stock_quantity 
                     END
WHERE product_id = @product_id;

-- Insérer la nouvelle commande si la mise à jour a affecté des lignes (c'est-à-dire si la quantité en stock était suffisante)
INSERT INTO orders (product_id, quantity)
VALUES (@product_id, @order_quantity);

-- Insérer le résultat dans la table results
INSERT INTO results (results_message)
VALUES (
    CASE 
        WHEN @stock_quantity >= @order_quantity 
        THEN 'Transaction réussie'
        ELSE 'Transaction échouée (insuffisance de stock)'
    END
);

-- Commit de la transaction en cas de succès
COMMIT;

-- Sélectionner tous les résultats de la table results
SELECT * FROM results;