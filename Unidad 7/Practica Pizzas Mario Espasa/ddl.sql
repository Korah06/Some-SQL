CREATE TABLE pizzas(
	nPizza VARCHAR(30),
	price Numeric(4,2),
	PRIMARY KEY(nPizza)
);

CREATE TABLE preparation(
	nPizza VARCHAR(30),
	ingredient VARCHAR(30),
	quantity NUMERIC(5,2),
	PRIMARY KEY(nPizza,ingredient),
	CONSTRAINT FK_preparation FOREIGN KEY (nPizza) REFERENCES pizzas(nPizza)
);


CREATE TABLE CLIENT(
	clientCod VARCHAR(2),
	name VARCHAR(20),
	PRIMARY KEY(clientCod)
);

CREATE TABLE sales(
	orderCod VARCHAR(5),
	nPizza VARCHAR(30),
	clientCod VARCHAR(2),
	date DATE,
	PRIMARY KEY(orderCod),
	CONSTRAINT FK_sales1 FOREIGN KEY (clientCod) REFERENCES client(clientCod),
	CONSTRAINT FK_sales2 FOREIGN KEY (nPizza) REFERENCES pizzas(nPizza)
);
