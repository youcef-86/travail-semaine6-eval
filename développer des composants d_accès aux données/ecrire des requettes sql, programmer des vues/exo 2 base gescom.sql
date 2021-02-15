-- exo1  afficher par code produit, la somme des quantités commandées et le prix total

CREATE VIEW v_Details 
AS SELECT pro_id AS 'code produit', SUM(ode_unit_price*ode_quantity) AS PrixTot, SUM(ode_quantity) AS QteTot 
FROM orders_details 
JOIN products 
ON orders_details.ode_pro_id = products.pro_id 
ORDER BY PrixTot, QteTot

-- exo2 Afficher les ventes dont le code produit est ZOOM (affichage de toutes les colonnes de la table orders_details).


CREATE VIEW v_Ventes_Zoom
AS SELECT * 
FROM products
JOIN orders_details
ON products.pro_id = orders_details.ode_pro_id
WHERE pro_ref = "ZOOM";

-- select * 
-- FROM products
-- WHERE pro_ref = "ZOOM";


-- SELECT *
-- FROM orders_details
-- WHERE ode_pro_id = 41


CREATE VIEW v_catalogue_produits 
AS SELECT pro_id,pro_ref,pro_name,cat_id,cat_name 
FROM products 
JOIN categories 
ON products.pro_cat_id = categories.cat_id
WHERE pro_id = "id, la référence, nom produits, id et nom catégorie";