-- 1. creation BDD :
CREATE DATABASE IF NOT EXISTS sales;
USE sales;

-- 2. creation table telephones :
CREATE TABLE IF NOT EXISTS telephones (
	name VARCHAR(50) NOT NULL,
	manufacturer VARCHAR(50) NOT NULL,
	price NUMERIC NOT NULL,
	units_sold INTEGER
);

-- 3. ajouts des données :
INSERT INTO telephones (name, manufacturer, price, units_sold) VALUES
    ('N1280', 'Nokia', 199, 1925),
    ('Iphone 4', 'Apple', 399, 9436),
    ('Galaxy S 5', 'Samsung', 299, 2359),
    ('S5620 Monte', 'Samsung', 250, 2385),
    ('N8', 'Nokia', 150, 7543),
    ('Droid', 'Motorola', 150, 8395),
    ('Iphone 13 Pro Max', 'Apple', 1300, 12849),
    ('Galaxy Note 20', 'Samsung', 1100, 10353),
    ('Lumia 920', 'Nokia', 299, 5847),
    ('Iphone SE', 'Apple', 499, 9726),
    ('Galaxy S20', 'Samsung', 899, 7435),
    ('P40 Pro', 'Huawei', 799, 5382),
    ('Moto G7', 'Motorola', 199, 6903),
    ('Redmi Note 9 Pro', 'Xiaomi', 299, 4208),
    ('Pixel 5', 'Google', 699, 3121),
    ('Xperia 1 II', 'Sony', 1099, 1923),
    ('3310', 'Nokia', 99, 12568),
    ('Iphone 12', 'Apple', 1099, 10548),
    ('Galaxy A51', 'Samsung', 399, 8620),
    ('P30 Pro', 'Huawei', 899, 6741),
    ('Moto G8', 'Motorola', 249, 5947),
    ('Redmi Note 8 Pro', 'Xiaomi', 249, 5184),
    ('Pixel 4a', 'Google', 499, 3129),
    ('Xperia 5 II', 'Sony', 899, 2387),
    ('6.2', 'Nokia', 179, 8412),
    ('Iphone 11', 'Apple', 799, 10962),
    ('Galaxy A71', 'Samsung', 499, 7692),
    ('P20 Pro', 'Huawei', 699, 4510),
    ('Moto E6 Plus', 'Motorola', 149, 6934),
    ('Redmi Note 7', 'Xiaomi', 199, 4367),
    ('Pixel 3a', 'Google', 399, 2296),
    ('Xperia 10 II', 'Sony', 399, 1715),
    ('Nokia 7.2', 'Nokia', 349, 4598),
    ('Iphone X', 'Apple', 999, 8765),
    ('Galaxy S10', 'Samsung', 799, 6543),
    ('P30 Lite', 'Huawei', 299, 3812),
    ('Moto G6', 'Motorola', 199, 5291),
    ('Redmi Note 6 Pro', 'Xiaomi', 249, 3719),
	('Pixel 2 XL', 'Google', 599, 2098),
    ('Xperia XZ2', 'Sony', 699, 1543),
    ('Nokia 6.1', 'Nokia', 249, 3127),
    ('Iphone XR', 'Apple', 799, 7392),
    ('Galaxy A50', 'Samsung', 349, 5967),
    ('P20 Lite', 'Huawei', 349, 4210),
    ('Moto G5 Plus', 'Motorola', 179, 4923),
    ('Redmi Note 5', 'Xiaomi', 199, 3176),
    ('Pixel XL', 'Google', 499, 1823),
    ('Xperia XZ3', 'Sony', 799, 1287),
    ('Nokia 5.3', 'Nokia', 199, 2587),
    ('Iphone 8', 'Apple', 699, 6098);

-- question 4 :
SELECT DISTINCT name FROM telephones;

-- question 5 :
SELECT name, manufacturer FROM telephones WHERE price > 200 ORDER BY price DESC;

-- question 6 :
SELECT name, manufacturer FROM telephones WHERE price BETWEEN 150 AND 200;

-- question 7 : 
-- soluce 1:
SELECT * FROM telephones WHERE manufacturer = 'Apple' OR manufacturer = 'Samsung';

-- soluce 2:
SELECT * FROM telephones WHERE manufacturer IN ('Samsung', 'Apple');

-- soluce 3:
SELECT * FROM telephones WHERE LOWER(manufacturer) LIKE 'samsung' OR LOWER(manufacturer) LIKE 'apple';

-- question 8 :
-- soluce 1, le revenu total de toutes les ventes cumulées :
SELECT SUM(price * units_sold) AS revenu_total FROM telephones;

-- soluce 2, le revenu total des ventes par telephone :
SELECT name, manufacturer, price, units_sold, price * units_sold AS total_revenue FROM telephones;

-- question 9 :
SELECT COUNT(*) FROM telephones WHERE manufacturer = 'Apple';

-- question 10 :
SELECT name AS modele, manufacturer AS fabricant, price AS prix, units_sold AS "quantite vendue" FROM telephones;

-- question 11 :
SELECT name, (units_sold * price) AS 'vente total'
FROM telephones GROUP BY name, (units_sold * price) 
HAVING (SUM(units_sold * price)) > 1300000 
ORDER BY (units_sold * price) DESC;
