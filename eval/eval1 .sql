-- exo1 Créez une vue qui affiche le catalogue produits. L'id, la référence et le nom des produits, ainsi que l'id et le nom de la catégorie doivent apparaître.

CREATE VIEW v_catalogue_produits 
AS SELECT pro_id,pro_ref,pro_name,cat_id,cat_name 
FROM products 
JOIN categories 
ON products.pro_cat_id = categories.cat_id


-- exo2 procedures stockées

DELIMITER |

CREATE PROCEDURE facture(IN p_libelle VARCHAR(50),OUT p_montant_total INT)

BEGIN 

SELECT SUM(ode_unit_price * ode_quantity) INTO p_montant_total
FROM orders_details 
JOIN orders 
ON orders_details.ode_ord_id = orders.ord_id
WHERE ord_id = p_libelle;

END |
DELIMITER ;

-- APPELER LA COMMANDE
CALL facture(3, @p_total);
SELECT @p_total AS 'prix total';





-- Triggers Présentez le déclencheur after_products_update demandé dans la phase 2 de la séance sur les déclencheurs.

CREATE TRIGGER after_products_update
AFTER INSERT  
ON products
FOR EACH ROW
BEGIN
   IF stock < stock_alert THEN 
   DELETE FROM nom de la table (commander_article) WHERE codart =new.pro_id; 
   INSERT INTO commander_articles (codart, date, qte) values('1', '12/02/2021', '2',new.pro_id)
   INSERT INTO MATABLE (marub1, marub2) values ('valeurrub1', 12,new.pro_id)
   END IF;
END

DELIMITER |
CREATE TRIGGER after_products_update
AFTER UPDATE  
ON products
FOR EACH ROW
BEGIN
   IF new.pro_stock < new.pro_stock_alert THEN 
   DELETE FROM commander_articles WHERE codart = new.pro_id; 
   INSERT INTO commander_articles (codart, date, qte) values(new.pro_id, now(), new.pro_stock_alert);
   END IF;
END|
DELIMITER ;



      -- exo Transactions

-- 1/Créer une ligne 'employés retraités' dans la table "POSTS"
insert into posts (pos_libelle) values (' retraité');
-----------------------------------------------------------------------------------------------------
-- 2/Sortir le Magasin d'Arras et aussi uniquement les employés de ce magasin "d'Arras"
START TRANSACTION;

SET @idshop = (select shop_id from shops where shop_city = 'Arras');

SET @idretraite = (select pos_id 
from posts
where pos_libelle = 'Retraité');
------------------------------------------------------------------------------------------------------------
-- 3/Modifier la fiche de 'HANNAH' dans la table 'Employees"
update employees 
set emp_pos_id = @idretraite
where emp_lastname = 'HANNAH' 
AND  emp_firstname = 'Amity'
AND emp_shop_id = @idshop;
--------------------------------------------------------------------------------------------------------
-- 4/Faire une requête pour sortir la liste avec l'ID des employés "Pépinieristes" dans la Table Posts
SELECT pos_id 
FROM posts 
WHERE pos_libelle = 'Pépinieriste';
------------------------------------------------------------------------------------------------------
-- 5/Nouvelle Requête avec SELECT(sortant tous les employés ayant pour poste Pépiniériste)
SELECT * 
FROM employees 
JOIN posts 
ON employees.emp_pos_id = posts.pos_id
WHERE pos_libelle = 'Pépinieriste'
AND emp_shop_id = @idshop
------------------------------------------------------------------------------------------------------------
-- 6/Trouver l'ancien Pépiniériste(avec date d'entrée en Entreprise "Emp_enter_date) en utilisant la fontion "MIN"
SET @id_new_manager = (SELECT emp_id 
FROM employees 
JOIN posts ON employees.emp_pos_id = posts.pos_id
WHERE pos_libelle = 'Pépinieriste' AND emp_shop_id = @idshop
ORDER BY emp_enter_date
LIMIT 1);
-- sinon avec la deuxieme fonction "MIN"----------------------------------------------------------
SET @idshop = (select sho_id from shops where sho_city = 'Arras');
SELECT MIN(emp_enter_date)
FROM employees 
JOIN posts ON emp_pos_id = posts.pos_id
WHERE pos_libelle = 'Pépiniériste' AND emp_sho_id = @idshop;
---------------------------------------------------------------------------------------------------------
-- 7/Recuperer ensuite cet ID(de l'ancien pépiniériste qui deviendra le nouveau Manager<à la place d'Hannah'),modifier sa fiche Emp_Salary en faisant un Update(Salaire X 1.5)

SET @idshop = (select sho_id from shops where sho_city = 'Arras'); -- ville Arras

SET @id_new_manager = (SELECT emp_id -- id du monsieur que sera le nouveau manager
FROM employees 
JOIN posts ON emp_pos_id = posts.pos_id
WHERE pos_libelle = 'Pépiniériste' AND emp_sho_id = @idshop
ORDER BY emp_enter_date
limit 1);

SET @post_id_manager = (SELECT pos_id -- id du poste manager
FROM posts 
WHERE pos_libelle LIKE '%Manage%'
limit 1);
-- modifier sa fiche Emp_Salary en faisant un Update(Salaire X 1.5)
UPDATE employees
SET 
emp_salary = (emp_salary*1.5),
emp_pos_id = @post_id_manager -- affecter le nouveau id "comme manager"
WHERE emp_id = @id_new_manager;

-------------------------------------------------------------------------------
-- 8/Update de nouveau sur tous les pépiniéristes pour mettre en valeur de la Rubrique "Emp_Superior" l'ID de leur nouveau Manag

SET @les_pepinieristes = (SELECT pos_id
FROM posts
WHERE pos_libelle = 'Pépinieriste');

SET @id_new_manager = (SELECT emp_id -- id du monsieur que sera le nouveau manager
FROM employees 
WHERE emp_firstname = 'Dorian');

UPDATE employees
SET 
emp_superior_id = @id_new_manager
WHERE emp_pos_id = @les_pepinieristes;

-- to verify

SELECT *
FROM employees
JOIN posts
ON pos_id = emp_pos_id
WHERE emp_superior_id = 10;
-------
SELECT emp_lastname, emp_firstname
FROM employees
WHERE emp_id = 10;
