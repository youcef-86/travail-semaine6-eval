-- 1/Afficher la liste des h�tels avec leur station.

SELECT hot_nom, sta_nom 
FROM hotel
INNER JOIN station
ON hot_sta_id


-- 2/Afficher la liste des chambres et leur h�tel

SELECT cha_numero, hot_nom
FROM hotel
INNER JOIN chambre
ON cha_hot_id

-- 3/Afficher la liste des r�servations avec le nom des clients

SELECT res_date, cli_nom 
FROM reservation 
JOIN client
ON reservation.res_cli_id = client.cli_id 

-- 4/Afficher la liste des chambres avec le nom de l'h�tel et le nom de la station

SELECT sta_nom, hot_nom, cha_numero 
FROM station 
JOIN hotel 
ON station.sta_id = hotel.hot_sta_id 
JOIN chambre 
ON hotel.hot_id = chambre.cha_hot_id

-- 5/Afficher les r�servations avec le nom du client et le nom de l'h�tel

SELECT cli_nom, hot_nom, res_date_debut, datediff ('2017-07-15','2017-07-01') AS 'dur�e du s�jour'
FROM hotel
JOIN chambre
ON hotel.hot_id = chambre.cha_hot_id
JOIN reservation
ON chambre.cha_id = reservation.res_cha_id
JOIN client
ON reservation.res_cli_id = client.cli_id