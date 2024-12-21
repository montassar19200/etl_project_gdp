Select * FROM "vente";
Select * FROM "bien";
Select * FROM "region";
Select * FROM "commune";

--1

SELECT COUNT(*) AS "Total_Appartements_Vendus"
FROM Public."bien" B
JOIN Public."vente" V
ON B."id_bien" = V."id_vente"  -- Jointure entre Bien et Vente
WHERE B."type_locale" = 'Appartement'  -- Filtrer uniquement les appartements
  AND EXTRACT(MONTH FROM V."date") BETWEEN 1 AND 6  -- Mois de janvier à juin
  AND EXTRACT(YEAR FROM V."date") = 2020;          -- Année 2020


--2 

SELECT R."libelle" AS Region, 
       COUNT(*) AS Total_Appartements_Vendus
FROM Public."bien" B
JOIN Public."vente" V ON B."id_bien" = V."id_vente"
JOIN Public."commune" C ON B."code_commune" = C."codcom"
JOIN Public."region" R ON C."codreg" = R."reg"
WHERE B."type_locale" = 'Appartement'
  AND EXTRACT(MONTH FROM V."date") BETWEEN 1 AND 6
  AND EXTRACT(YEAR FROM V."date") = 2020
GROUP BY R."libelle"
ORDER BY Total_Appartements_Vendus DESC;

--3
WITH Total_Sales AS (
    SELECT COUNT(*) AS Total_Appartements_Vendus
    FROM Public."bien" B
    JOIN Public."vente" V ON B."id_bien" = V."id_vente"
    WHERE B."type_locale" = 'Appartement'
)
SELECT B."total_piece" AS Nombre_de_Pieces,
       COUNT(*) AS Nombre_de_Ventes,
       ROUND(COUNT(*)::NUMERIC / TS.Total_Appartements_Vendus * 100, 2) AS Proportion_Pourcentage
FROM Public."bien" B
JOIN Public."vente" V ON B."id_bien" = V."id_vente"
JOIN Total_Sales TS ON TRUE
WHERE B."type_locale" = 'Appartement'
GROUP BY B."total_piece", TS.Total_Appartements_Vendus
ORDER BY Proportion_Pourcentage DESC;

--4
SELECT C."coddep" AS Departement,
       ROUND(CAST(AVG(V."valeur" / B."surface_carrez") AS NUMERIC), 2) AS Prix_Moyen_m2
FROM Public."bien" B
JOIN Public."vente" V ON B."id_bien" = V."id_vente"
JOIN Public."commune" C ON B."code_commune" = C."codcom"
WHERE B."surface_carrez" > 0  -- Exclure les biens sans surface
GROUP BY C."coddep"
ORDER BY Prix_Moyen_m2 DESC
LIMIT 10;

--5 

SELECT ROUND(CAST(AVG(V."valeur" / B."surface_carrez") AS NUMERIC), 2) AS Prix_Moyen_m2_Maison
FROM Public."bien" B
JOIN Public."vente" V ON B."id_bien" = V."id_vente"
JOIN Public."commune" C ON B."code_commune" = C."codcom"
JOIN Public."region" R ON C."codreg" = R."reg"
WHERE B."type_locale" = 'Maison'
  AND B."surface_carrez" > 0
  AND R."reg" = 11; -- Code de l'Île-de-France

--6 
SELECT B."id_bien",  
       V."valeur" AS Prix, 
       B."surface_carrez" AS Surface_m2,
       R."libelle" AS Region
FROM Public."bien" B
JOIN Public."vente" V ON B."id_bien" = V."id_vente" 
JOIN Public."commune" C ON B."code_commune" = C."codcom"
JOIN Public."region" R ON C."codreg" = R."reg"
WHERE B."type_locale" = 'Appartement'
  AND V."valeur" IS NOT NULL  -- Exclure les résultats avec des prix nuls
ORDER BY V."valeur" DESC
LIMIT 10;


--7

SELECT R."libelle" AS Region,
       ROUND(AVG(V."valeur" / B."surface_carrez")::numeric, 2) AS Prix_Moyen_m2,  -- Conversion explicite en numeric
       RANK() OVER (ORDER BY AVG(V."valeur" / B."surface_carrez") DESC) AS Rank
FROM Public."bien" B
JOIN Public."vente" V ON B."id_bien" = V."id_vente"
JOIN Public."commune" C ON B."code_commune" = C."codcom"
JOIN Public."region" R ON C."codreg" = R."reg"
WHERE B."type_locale" = 'Appartement'
  AND B."total_piece" > 4
  AND B."surface_carrez" > 0
GROUP BY R."libelle"
ORDER BY Rank;
--8
SELECT C."com" AS Commune,  
       COUNT(V."id_vente") AS Nombre_Ventes
FROM Public."vente" V
JOIN Public."bien" B ON B."id_bien" = V."id_vente"
JOIN Public."commune" C ON B."code_commune" = C."codcom"
WHERE EXTRACT(MONTH FROM V."date") BETWEEN 1 AND 3 
GROUP BY C."com"
HAVING COUNT(V."id_vente") >= 50  
ORDER BY Nombre_Ventes DESC;








