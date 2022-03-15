use classicmodels;

/* BÁSICOS - INTERMEDIARIO */

--  1) essa query pega todas as informações da tabela 'employees'
SELECT * 
FROM employees;

--  2) essa query pega todas as informações da tabela 'customers'
SELECT * 
FROM customers;

--  3) essa query pega todas as informações da tabela 'products'
SELECT * 
FROM products;

--  4) essa query pega todas as informações da tabela 'payments'
SELECT * 
FROM payments;

--  5) essa query pega apenas as informações 'firstName' e 'lastName' da tabela 'employees'
SELECT firstName, lastName
FROM employees;

--  6) essa query pega apenas as informações 'comments' e 'orderDate' da tabela 'orders'
SELECT comments, orderDate
FROM orders;

--  7) essa query pega apenas as informações 'productName' e 'productVendor' da tabela 'products'
SELECT productName, productVendor
FROM products;

--  8) essa query pega apenas as informações 'firstName' e 'lastName' da tabela 'employees', trocando o nome da coluna por 'Primeiro Nome' e 'Ultimo Nome' respectivamente
SELECT firstName as 'Primeiro Nome', lastName as 'Ultimo Nome'
FROM employees;

--  9) essa query pega apenas as informações 'firstName' e 'lastName' da tabela 'employees', trocando o nome da coluna por 'Primeiro Nome' e 'Ultimo Nome' respectivamente e ordenando o 'firstName' descrescentemente
SELECT firstName as 'Primeiro Nome', lastName as 'Ultimo Nome'
FROM employees
ORDER BY firstName DESC;

--  10) essa query pega apenas as informações 'firstName' e 'lastName' da tabela 'employees', trocando o nome da coluna por 'Primeiro Nome' e 'Ultimo Nome' respectivamente e ordenando o 'firstName' alfabeticamente
SELECT firstName as 'Primeiro Nome', lastName as 'Ultimo Nome'
FROM employees
ORDER BY firstName ASC;

--  11) essa query pega apenas as informações 'firstName' e 'lastName' da tabela 'employees', trocando o nome da coluna por 'Primeiro Nome' e 'Ultimo Nome' respectivamente e ordenando o 'firstName' alfabeticamente, também isolando somente as pessoas que começam com a letra 'A'
SELECT firstName as 'Primeiro Nome', lastName as 'Ultimo Nome'
FROM employees
WHERE firstName like 'a%'
ORDER BY firstName ASC;

--  12) essa query pega apenas as informações 'firstName' e 'lastName' da tabela 'employees', trocando o nome da coluna por 'Primeiro Nome' e 'Ultimo Nome' respectivamente e ordenando o 'firstName' alfabeticamente, também isolando somente as pessoas que possuem a letra 'A' em alguma parte
SELECT firstName as 'Primeiro Nome', lastName as 'Ultimo Nome'
FROM employees
WHERE firstName like '%a%'
ORDER BY firstName ASC;

-- 13) começando a usar inner join para pegar todas as informações
SELECT * 
FROM payments as p
INNER JOIN customers as c ON p.customerNumber = c.customerNumber;

-- 14) começando a usar inner join para pegar algumas informações ta tabela payments
SELECT p.paymentDate
FROM payments as p
INNER JOIN customers as c ON p.customerNumber = c.customerNumber;

-- 15) começando a usar inner join para pegar algumas informações da tabela payment e da tabela costumers
SELECT p.paymentDate, c.customerName
FROM payments as p
INNER JOIN customers as c ON p.customerNumber = c.customerNumber;

/* AVANÇADOS */

--  16) veremos agora para quem cada funcionario se reporta 
SELECT firstName as 'Primeiro Nome', lastName as 'Ultimo Nome', reportsTo as 'Codigo do supervisor'
FROM employees
ORDER BY firstName ASC;

--  17) colocaremos a condição de ser um supervisor selecionado
SELECT firstName as 'Primeiro Nome', lastName as 'Ultimo Nome', reportsTo as 'Codigo do supervisor'
FROM employees
WHERE reportsTo = 1143
ORDER BY firstName ASC;

--  18) colocaremos a condição de ser um supervisor selecionado, ordenando pelo supervisor
SELECT firstName as 'Primeiro Nome', lastName as 'Ultimo Nome', reportsTo as 'Codigo do supervisor'
FROM employees
WHERE reportsTo = 1143
ORDER BY reportsTO ASC;

--  19) agora substituiremos o codigo, pelo nome do supervisor, usando join em uma mesma tabela
SELECT e.firstName as 'Primeiro Nome', e.lastName as 'Ultimo Nome', e.reportsTo as 'Codigo do supervisor', s.firstName as 'Supervisor'
FROM employees as e
JOIN employees as s ON e.reportsTo = s.employeeNumber
WHERE e.reportsTo = 1143
ORDER BY e.firstName ASC;

--  20) agora substituiremos o codigo, pelo nome do supervisor, usando join em uma mesma tabela, e ordenando pelo nome do supervisor
SELECT e.firstName as 'Primeiro Nome', e.lastName as 'Ultimo Nome', e.reportsTo as 'Codigo do supervisor', s.firstName as 'Supervisor'
FROM employees as e
JOIN employees as s ON e.reportsTo = s.employeeNumber
WHERE e.reportsTo = 1143
ORDER BY s.firstName ASC;

--  21) começando a fazer interligação entre tabelas, agora pegaremos o office code de cada funcionario
SELECT firstName as 'Primeiro Nome', lastName as 'Ultimo Nome', officeCode
FROM employees
ORDER BY firstName ASC;

--  22) inserimos o join e renomeamos o employees para 'e' e o offices para 'o'
SELECT firstName as 'Primeiro Nome', lastName as 'Ultimo Nome', e.officeCode
FROM employees as e
JOIN offices as o ON e.officeCode = o.officeCode
ORDER BY firstName ASC;

--  23) pegamos a cidade do office relacionado ao funcionario
SELECT firstName as 'Primeiro Nome', lastName as 'Ultimo Nome', o.city as 'Cidade do escritório'
FROM employees as e
JOIN offices as o ON e.officeCode = o.officeCode
ORDER BY firstName ASC;

--  24) encontrar clientes e listar sua quantidade de pedidos
SELECT c.customerName as "Nome do cliente", o.orderNumber as "Nota fiscal", COUNT(o.orderNumber) as "Quantidade de pedidos"
FROM customers as c
INNER JOIN orders as o ON c.customerNumber = o.customerNumber
GROUP BY c.customerName ASC;

--  25) encontrar clientes e listar o nome do produto comprado, junto da nota
SELECT c.customerName as "Nome do cliente", o.orderNumber as "Nota fiscal", p.productName as "Nome do produto"
FROM customers as c
INNER JOIN orders as o ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails as od ON o.orderNumber = od.orderNumber
INNER JOIN products as p ON od.productCode = p.productCode;

--  26) encontrar clientes e listar o nome do produto e ordenando pela linha de produto, ordenando pela linha do produto
SELECT c.customerName as "Nome do cliente", o.orderNumber as "Nota fiscal", p.productName as "Nome do produto", pl.productLine as "Linha do produto"
FROM customers as c
INNER JOIN orders as o ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails as od ON o.orderNumber = od.orderNumber
INNER JOIN products as p ON od.productCode = p.productCode
INNER JOIN productlines as pl ON p.productLine = pl.productLine
ORDER BY pl.productLine;

--  27) encontrar clientes e listar sua quantidade de pedidos e colocar o nome do produto e ordenando pela linha de produto e colocando a quantidade pedida e o método de pagamento
SELECT c.customerName as "Nome do cliente", o.orderNumber as "Nota fiscal", p.productName as "Nome do produto", pl.productLine as "Linha do produto", od.quantityOrdered as "Quantidade"
FROM customers as c
INNER JOIN orders as o ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails as od ON o.orderNumber = od.orderNumber
INNER JOIN products as p ON od.productCode = p.productCode
INNER JOIN productlines as pl ON p.productLine = pl.productLine
ORDER BY pl.productLine;

--  28) encontrar clientes e listar sua quantidade de pedidos e colocar o nome do produto e ordenando pela linha de produto e colocando a quantidade pedida e o valor do pagamento
SELECT c.customerName as "Nome do cliente", o.orderNumber as "Nota fiscal", p.productName as "Nome do produto", pl.productLine as "Linha do produto", od.quantityOrdered as "Quantidade", pay.amount
FROM customers as c
INNER JOIN orders as o ON c.customerNumber = o.customerNumber
INNER JOIN payments as pay ON c.customerNumber = pay.customerNumber
INNER JOIN orderdetails as od ON o.orderNumber = od.orderNumber
INNER JOIN products as p ON od.productCode = p.productCode
INNER JOIN productlines as pl ON p.productLine = pl.productLine
ORDER BY pl.productLine;

--  29) pegar o total gasto por cliente
SELECT c.customerName as "Nome do cliente", o.orderNumber as "Nota fiscal", p.productName as "Nome do produto", pl.productLine as "Linha do produto", od.quantityOrdered as "Quantidade", SUM(pay.amount) as "Total gasto"
FROM customers as c
INNER JOIN orders as o ON c.customerNumber = o.customerNumber
INNER JOIN payments as pay ON c.customerNumber = pay.customerNumber
INNER JOIN orderdetails as od ON o.orderNumber = od.orderNumber
INNER JOIN products as p ON od.productCode = p.productCode
INNER JOIN productlines as pl ON p.productLine = pl.productLine
GROUP BY c.customerName;

--  30) pegar o total gasto por cliente, ordenando do maior para o menor valor
SELECT c.customerName as "Nome do cliente", o.orderNumber as "Nota fiscal", p.productName as "Nome do produto", pl.productLine as "Linha do produto", od.quantityOrdered as "Quantidade", SUM(pay.amount) as "Total gasto"
FROM customers as c
INNER JOIN orders as o ON c.customerNumber = o.customerNumber
INNER JOIN payments as pay ON c.customerNumber = pay.customerNumber
INNER JOIN orderdetails as od ON o.orderNumber = od.orderNumber
INNER JOIN products as p ON od.productCode = p.productCode
INNER JOIN productlines as pl ON p.productLine = pl.productLine
GROUP BY c.customerName
ORDER BY SUM(pay.amount) DESC;