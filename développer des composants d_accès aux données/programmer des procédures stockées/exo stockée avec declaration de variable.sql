-- exo Procédure stockée avec déclaration de variable(s)

DELIMITER |

CREATE PROCEDURE ajoutFournisseur(
    IN p_nom VARCHAR(50), 
    IN p_countries_id CHAR(2),  
    IN p_address VARCHAR(150),
    IN p_zipcode VARCHAR(5),  
    IN p_contact VARCHAR(100),  
    IN p_phone VARCHAR(10),  
    IN p_mail VARCHAR(75)
)

BEGIN
   DECLARE v_ville VARCHAR (50);
   SET v_ville = 'Amiens';   

   INSERT INTO suppliers(sup_name, sup_city, sup_countries_id, sup_address, sup_zipcode, sup_contact, sup_phone, sup_mail) VALUES (p_nom, v_ville, p_countries_id, p_address, p_zipcode, p_contact, p_phone, p_mail);
END |

DELIMITER ;
-- Ecrivez l'appel de la procédure ajoutFournisseur() pour un fournisseur basé en France.

SET @cou_id = (SELECT cou_id AS pays
               FROM countries
               WHERE cou_name = 'France');
CALL ajoutFournisseur ('youcef', @cou_id, '30 rue poulainville', 80000, 'carlito', 0788659944, 'marionafpa@gmail.com')



-- Exercice 1 : création d'une procédure stockée sans paramètre

-- Créez la procédure stockée Lst_Suppliers correspondant à la requête afficher le nom des fournisseurs pour lesquels une commande a été passée.

DELIMITER |

CREATE PROCEDURE Lst_Suppliers()
BEGIN
    SELECT * FROM Suppliers;
END |

DELIMITER ;

-- Exécutez la pour vérifier qu'elle fonctionne conformément à votre attente.
CALL Lst_Suppliers

-- Exécutez la commande SQL suivante pour obtenir des informations sur cette procédure stockée :
SHOW CREATE PROCEDURE Lst_Suppliers



-- Exercice 2 : création d'une procédure stockée avec un paramètre en entrée

DELIMITER |

CREATE PROCEDURE Lst_Rush_Orders(IN p_commande urgente VARCHAR(50))

BEGIN
   SELECT * 
   FROM orders
   WHERE ord_status = 'p_commande urgente';
END |

DELIMITER ;
----  2em exemple en entrée


DELIMITER |
CREATE PROCEDURE Lst_Rush_Orders_total(IN p_libelle VARCHAR (50),
                                       OUT p_total INT)
                                      
BEGIN
	SELECT *
    FROM orders
    WHERE ord_status = p_libelle;
    
END |

DELIMITER ;

-- 3EM EXEMPLE PARAMETTRE ENTRANT ET SORTANT

DELIMITER |
DROP PROCEDURE IF EXISTS Lst_Rush_Orders_total |
CREATE PROCEDURE Lst_Rush_Orders_total(IN p_libelle VARCHAR (50), OUT p_total INT) 
BEGIN 
SELECT SUM(ode_unit_price * ode_quantity) 
FROM orders_details 
JOIN orders 
ON orders_details.ode_ord_id = orders.ord_id
WHERE ord_status = p_libelle;
END |
DELIMITER ;
-- 4em ex sortant
DELIMITER |
DROP PROCEDURE IF EXISTS Lst_Rush_Orders_total |
CREATE PROCEDURE Lst_Rush_Orders_total(IN p_libelle VARCHAR (50), OUT p_total INT) 

BEGIN 

SELECT SUM(ode_unit_price * ode_quantity) INTO p_total
FROM orders_details 
JOIN orders 
ON orders_details.ode_ord_id = orders.ord_id
WHERE ord_status = p_libelle;

END |
DELIMITER ;

--  appeler ma procedure--
SET @p_total = 0;
CALL Lst_Rush_Orders_total("commande urgente",@p_total);
SET @p_total = 0;
CALL Lst_Rush_Orders_total("commande annulée",@p_total);
-- paramettre en sortant
SET @p_total = 0;
CALL Lst_Rush_Orders_total("commande urgente",@p_total);
SELECT @p_total

 
--  appeler ma procedure-- 
CALL Lst_Rush_Orders("commande urgente")



-- Exercice 3 : création d'une procédure stockée avec plusieurs paramètres

DELIMITER |

CREATE PROCEDURE CA_Supplier(p_sup_id INT(10))

BEGIN

SELECT SUM(ode_unit_price * ode_quantity), sup_name,
FROM orders_details 
JOIN orders 
ON orders_details.ode_ord_id = orders.ord_id
JOIN products
ON orders_details.ode_pro_id = products.pro_id
JOIN suppliers
ON products.pro_sup_id = suppliers.sup_id
GROUP BY

   INSERT INTO Supplier(sup_adress, sup_city, sup_contat, sup_id, sup_mail, sup_name, sup_phone, sup_zipcode) VALUES (p_sup_adress, p_sup_city, p_sup_contat, p_sup_id, p_sup_mail, p_sup_name, p_sup_phone, p_sup_zipcode);
END |

DELIMITER ;


