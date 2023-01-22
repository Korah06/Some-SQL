--1

SELECT preparation.quantity, pizzas.price 
FROM pizzas, preparation
WHERE pizzas.npizza = preparation.nPizza
GROUP BY preparation.quantity, pizzas.price

--2

SELECT preparation.nPizza, sum(preparation.quantity) AS cantidad_ingredientes
FROM preparation, pizzas
WHERE pizzas.nPizza = preparation.nPizza
AND quantity > 30
GROUP BY preparation.nPizza;

--3

SELECT preparation.nPizza, price
FROM preparation, pizzas
WHERE pizzas.nPizza = preparation.nPizza
GROUP BY preparation.nPizza, price
HAVING count(ingredient) >= 5
ORDER BY price DESC;

--4

SELECT name, count(nPizza)
FROM sales, client
WHERE client.clientCod = sales.clientCod
GROUP BY sales.clientCod, name
HAVING count(sales.clientCod) =
(SELECT MAX(s.n) FROM (SELECT COUNT(clientCod) as n FROM sales GROUP BY clientCod) as s)

--5

SELECT clientCod, sum(price)
FROM sales, pizzas
WHERE pizzas.nPizza = sales.nPizza
GROUP BY sales.clientCod


--6

SELECT preparation.nPizza,price, sum(preparation.quantity) AS peso
FROM preparation, pizzas
WHERE pizzas.nPizza = preparation.nPizza
AND quantity > 30
GROUP BY preparation.nPizza,price;

--7

SELECT pizzas.nPizza, SUM(price)
FROM sales,pizzas
WHERE pizzas.nPizza = sales.nPizza
AND TO_CHAR(date,'YYYY') = '2019' 
AND TO_CHAR(date, 'MM') = '08'
GROUP BY pizzas.nPizza

--8

SELECT clientCod, sum(price)
FROM sales, pizzas
WHERE pizzas.nPizza = sales.nPizza
GROUP BY sales.clientCod, pizzas.price
ORDER BY price ASC

--9

SELECT name
FROM client
WHERE clientcod NOT IN (SELECT clientcod FROM sales)