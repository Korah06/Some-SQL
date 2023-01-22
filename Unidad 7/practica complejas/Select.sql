--2
SELECT poblacions.nom
FROM poblacions, instituts
WHERE instituts.localitat = poblacions.nom
GROUP BY poblacions.nom
HAVING COUNT(poblacions.nom) = 
(SELECT MAX(T.c) FROM 
 						(SELECT COUNT(localitat) AS c FROM instituts GROUP BY instituts.nom) AS T);

--3
SELECT poblacions.nom
FROM poblacions, instituts
WHERE instituts.localitat = poblacions.nom
GROUP BY poblacions.nom
HAVING COUNT(poblacions.nom) = 
(SELECT MIN(T.c) FROM 
 						(SELECT COUNT(localitat) AS c FROM instituts GROUP BY instituts.nom) AS T);