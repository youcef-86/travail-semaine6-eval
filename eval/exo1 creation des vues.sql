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