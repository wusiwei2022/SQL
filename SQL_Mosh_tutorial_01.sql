# This is a breif tutorial following video CodeWithMosh

# Import the database: run the create-databases.sql to import create the schemas

# USE to use a database, the database in use will be in bold
USE sql_store; # Remember to end up every query with a ;

# SELECT syntax: In this section, we are going to discover SELECT command
## SELECT FROM WHERE ORDER: the order of the commands matters 
SELECT  * 
FROM customers
WHERE customer_id = 1
ORDER BY first_name;

## Use AS and Arithmetic operators in SELECT function, AS is to rename the column
SELECT 
	first_name, 
    last_name, 
    points, 
    points + 10 AS "points adjusted"
FROM customers
WHERE points > 1000
ORDER BY points;

## Update the state as "VA" in table sql_store where customer_id = 1 
## You can do it interactively
UPDATE sql_store.customers 
SET state = 'VA' 
WHERE customer_id = 1;

## Use DISTINCT to remove duplicated rows 
SELECT DISTINCT state # Duplicated VA is removed
FROM customers;

## Restore the state as "MA" in table sql_store where customer_id = 1 
## You can do it interactively
UPDATE sql_store.customers 
SET state = 'MA' 
WHERE customer_id = 1;

 ## Exercise: return the name, unit price, and new price of all products
 SELECT 
	name,
    unit_price,
    unit_price * 1.1 AS 'new price'
FROM products;
    
# WHERE syntax: In this secton, we are going to discover WHERE command
## WHERE to filter by number: >, <, >=, <=, !=, =, 
SELECT *
FROM customers
WHERE points >= 3000;

## WHERE to filter by string: =, !=
## Do add '' around the string
SELECT *
FROM customers
WHERE state = 'VA';

SELECT *
FROM customers
WHERE state <> 'NA';

## WHERE to filter by date
## Do add '' around the date although date is not a string
## The standard format for representing a date: XXXX-XX-XX
SELECT *
FROM customers
WHERE birth_date > '1990-01-01'; # Extract customers who were born after 1990-01-01 

## Exercise: get the orders placed this year
SELECT *
FROM orders
WHERE order_date >= '2019-01-01';

## WHERE with multiple conditions using AND, OR, and NOT
## Priority: AND > OR
SELECT *
FROM customers
WHERE birth_date > '1990-01-01' 
	AND points > 1000 
    OR state = 'VA' ;

## Exercise: 
-- From the order_items table, 
-- Get the items for order 6
-- where the total price is greater than 30
SELECT *
FROM  order_items 
WHERE order_id = 6 
	AND quantity * unit_price > 30;

## WHERE to fileter by IN or NOT IN
SELECT *
FROM customers 
WHERE state NOT IN ('VA', 'MA');

## Exercise:
-- From the products table,
-- Return products with quantity in stock equal to 49, 38, 72
SELECT *
FROM products
WHERE quantity_in_stock IN (49, 38, 72);

## WHERE to filter with BETWEEN command, which can be used to number and date
SELECT *
FROM customers
WHERE points BETWEEN 1000 AND 3000; # between 2 values

## Exercise:
-- From customers table
-- Return customers born between 1/1/1990 and 1/1/2000
SELECT *
FROM customers
WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01'; # between 2 dates

## WHERE to filter with wild cards operater LIKE: 
-- % as the wildcard for any number of characters
-- _ as the wildcard for one single character
SELECT *
FROM customers
WHERE last_name LIKE 'b%'; # Extract all the customers whose name starting with b

SELECT *
FROM customers
WHERE last_name LIKE '%b%'; # Extract all the customers with b in their name

SELECT *
FROM customers
WHERE last_name LIKE 'b____y';

## Exercise
-- Get the customers whose addresses contain TRAIL or AVENUE
SELECT *
FROM customers
WHERE address LIKE '%TRAIL%' OR address LIKE '%AVENUE%';

## Exercise
-- Get the customers whose phone numbers end with 9
SELECT *
FROM customers
WHERE phone NOT LIKE '%9';

## WHERE to filter with Wild Card Operator REGEEXP stands for regular expression
## REGEXP allows to search for more complex patterns
-- REGEXP 'EXP'
-- REGEXP '^EXP': ^ stands for starting with
-- REGEXP 'EXP$': $ stands for ending with
-- REGEXP 'EXP1|EXP2': | stands for OR, so match EXP1 or EXP2
-- REGEXP '[abc]e': match ae, be, or ce
-- REGEXP '[a-h]e': match ae, be, ce, de, ee, fe, ge, he
SELECT *
FROM customers
WHERE last_name REGEXP 'field'; # To extract people with 'field' in their name

SELECT *
FROM customers
WHERE last_name REGEXP '^field'; 

SELECT * 
FROM customers
WHERE last_name REGEXP 'field$';

SELECT *
FROM customers
WHERE last_name REGEXP 'field$|^max|rose';

SELECT *
FROM customers
WHERE last_name REGEXP '[gim]e[a-y]'; 

SELECT *
FROM customers
WHERE last_name REGEXP '[a-h]e';

## Exercise: Get the customers whose 
-- First names are ELKA or AMBUR
-- Last names end with EY or ON
-- Last names start with MY or contains SE
-- Last names contain B followed by R or U

SELECT *
FROM customers
WHERE first_name = 'ELKA' OR first_name = 'AMBUR';

SELECT *
FROM customers
WHERE last_name REGEXP 'EY$|ON$';

SELECT *
FROM customers
WHERE last_name REGEXP '^MY|SE';

SELECT *
FROM customers
WHERE last_names REGEXP 'B[RU]';

## WHERE to extract NULL or NOT NULL value (missing value): IS NULL
SELECT *
FROM customers
WHERE PHONE IS NULL;

SELECT *
FROM customers
WHERE PHONE IS NOT NULL;

## Exersice: Get the orders that are not shipped
SELECT *
FROM sql_store.orders
WHERE shipper_id IS NULL;

# Table is by default orderred by the primary key
-- The primary key should unique identify the records in that table
-- You can open the tool panel to edit the primary key, the column names and how the columns are placed

# Order by to order by a designated column 

## DESC: By default, it orders ascendingly. By using DESC, it can order descendingly 
SELECT *
FROM customers
ORDER BY first_name DESC;

## Order by multiple columns
SELECT *
FROM customers
ORDER BY state DESC, city;

## sql can order by columns not selected
SELECT customer_id, first_name, last_name
FROM customers
ORDER BY state DESC, city;

## sql can order by alias or modified columns
SELECT 
	customer_id, 
	first_name,
    last_name,
    points * 1.1 AS new_points
FROM customers
ORDER BY new_points;
    
## sql can also order by 1st, 2nd, ... columns
SELECT  customer_id, first_name, last_name
FROM customers
ORDER BY 1, 2;

## Exercise: extract all the items of order 2 and sort by total price 
SELECT *, quantity * unit_price AS total_price
FROM order_items
WHERE order_id = 2
ORDER BY unit_price * quantity DESC;

# LIMIT: to limit the records returned from the query
## LIMIT clause should always come at the end
SELECT *
FROM customers
ORDER BY customer_id DESC
LIMIT 3; # Retreive the first 3 rows 

SELECT *
FROM customers 
ORDER BY customer_id DESC
LIMIT  6, 3; # Skip the first 6 and retreive the next 3

## Exercise: to get the top three loyalist customers with highest points
SELECT *
FROM customers
ORDER BY points DESC
LIMIT 3;

# JOIN ON: query from multiple tables
## INNER JOIN to query from 2 tables
SELECT order_id, o.customer_id, first_name, last_name # Need to clearity the table when a column is ambiguous
FROM orders o # Give orders an alias as o
INNER JOIN customers c # Give customers an alias as c 
	ON o.customer_id = c.customer_id; 

## EXERCISE: return order_items and product name corresponding to the product_id 
SELECT o.order_id, o.product_id, p.name AS product_name, o.quantity, o.unit_price
FROM order_items o
INNER JOIN products p
	ON o.product_id = p.product_id;

## INNER JOIN to query from tables in distinct databases
SELECT * 
FROM order_items o
INNER JOIN sql_inventory.products p # Prefix the table if the table is not a part of the current database
	ON o.product_id = p.product_id;

## INNER JOIN to join a table with itself
USE sql_hr;

SELECT 
	e.employee_id, 
	e.first_name, 
    m.first_name AS manager
FROM employees e
INNER JOIN employees m # Use 2 different alias
	on e.reports_to = m.employee_id;

## INNER JOIN multiple tables with multiple joins
USE sql_store;

SELECT 
	o.order_id,
    o.order_date,
    c.first_name,
    c.last_name,
    os.name AS status
FROM orders o
INNER JOIN customers c
	ON o.customer_id = c.customer_id
INNER JOIN order_statuses os
	ON o.status = os.order_status_id;

## Exercise: JOIN clients, payment_methods and payments 
USE sql_invoicing;

SELECT  
	p.date, 
    p.invoice_id,
    p.amount, 
    c.name AS client_name, 
    pm.name AS payment_method
FROM payments p
INNER JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id
INNER JOIN clients c 
	ON p.client_id = c.client_id;

## Composite primary key: Use > 1 columns as the primary key when the two variables can determine a unique item
## INNER JOIN 2 tables with composite primary key
USE sql_store;

SELECT *
FROM order_items oi
INNER JOIN order_item_notes oin
	ON oi.order_id = oin.order_id
    AND oi.product_id = oin.product_id;
 
 ## Implicitly join 2 tables using WHERE 
 ## Not recommended because you will accidentally CROSSJOIN 2 tables if we missed the where clause
 SELECT *
 FROM orders o, customers c
 WHERE o.customer_id = c.customer_id;
 
## OUTJOIN (LEFT JOIN and RIGHT JOIN) to also return items not matched in the 2 tables
SELECT 
	c.customer_id, 
    c.first_name, 
    c.last_name, 
    o.order_id 
FROM customers c
LEFT JOIN orders o
	ON c.customer_id = o.customer_id;
    
## EXERCISE: OUT JOIN product table with order_items table
SELECT 
	p.product_id, 
	p.name AS product_name, 
    oi.quantity
FROM products p
	LEFT JOIN order_items oi
    ON p.product_id = oi.product_id;
    
## OUTER JOIN between multiple tables (In practice, avoid using RIGHT JOIN)
SELECT 
	c.customer_id, 
    c.first_name, 
    c.last_name, 
    o.order_id,
    o.shipper_id,
    sh.name AS shipper
FROM customers c
LEFT JOIN orders o
	ON c.customer_id = o.customer_id
LEFT JOIN shippers sh
	ON o.shipper_id = sh.shipper_id;
    
## JOIN order table, customer table, shipper table, order_status table
SELECT 
	o.order_id,
    o.order_date, 
    c.first_name AS customer, 
    sh.name AS shipper, 
    os.name AS status 
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
INNER JOIN order_statuses os
    ON o.status = os.order_status_id
LEFT JOIN shippers sh
    ON o.shipper_id = sh.shipper_id
ORDER BY order_id;

## OUT JOIN a table with itself
USE sql_hr;

SELECT e.employee_id, e.first_name, m.first_name AS manager
FROM employees e
LEFT JOIN employees m
    ON e.reports_to = m.employee_id;
    
## USING: INNER JOIN 2 tables with USING clause if the shared columns are exactly the same
 USE sql_store;
 SELECT
	o.order_id,
    c.first_name,
    sh.name AS shipper
 FROM orders o
 JOIN customers c
	-- ON o.customer_id = c.customer_id
	USING (customer_id)
JOIN shippers sh
	-- ON o.customer_id = sh.customer_id
	USING (shipper_id);
    
## USING is applicable to Composite Primary Key
SELECT *
FROM order_items oi
JOIN order_item_notes oin
	-- ON oi.order_id = oin.order_id AND
	-- oi.product_id = oin.product_id
    USING (order_id, product_id);
    
## INNER JOIN payments, clients, and payment_method with USING
USE sql_invoicing;
SELECT 
	p.date,
    c.name AS client,
    p.amount,
    pm.name AS payment_method
FROM payments p
JOIN clients c
	USING (client_id)
JOIN payment_methods AS pm
	ON p.payment_method = pm.payment_method_id;

## NATURE JOIN to let sql join 2 table on its own by guessing the shared column （Not recommended）
USE sql_store;
SELECT 
	o.order_id,
    c.first_name
FROM orders o
NATURAL JOIN customers c; 

## CROSS JOIN: to select and join all the records from the 2 tables
SELECT
	c.first_name AS customer,
    p.name AS product
FROM customers c
CROSS JOIN products p # each record in the 1st table will be matched with all the records in the 2nd table
ORDER BY customer;

## Implicit version of CROSS JOIN
SELECT 
	c.first_name AS customer,
    p.name AS product
FROM customers c, products p
ORDER BY customer;

# EXERCISE: Do a CROSS JOIN between shippers and products
-- Using the implicit syntax
-- And then using the explicit syntax
SELECT 
	p.name AS product,
    sh.name AS shipper
FROM products p
CROSS JOIN shippers sh;

SELECT
	p.name AS products,
    sh.name AS shipper
FROM products p, shippers sh
ORDER BY products;

## UNION: combine rows from multiple tables
## The number of columns each query return should be identical
## The new column name sticks to the first table
SELECT 
	order_id,
    order_date,
    'Active' AS status
FROM orders
WHERE order_date >= '2019-01-01'
UNION
SELECT 
	order_id,
    order_date,
    'Archived' AS status
FROM orders
WHERE order_date < '2019-01-01';

SELECT first_name 
FROM customers
UNION
SELECT name
FROM shippers;

## EXERCISE: categorize the customers by the points and order by customers' names
SELECT 
	customer_id,
    first_name,
    points,
    'Bronze' AS type
FROM customers 
WHERE points <2000
UNION
SELECT 
	customer_id,
    first_name,
    points,
    'Silver' AS type
FROM customers 
WHERE points BETWEEN 2000 AND 3000
UNION
SELECT 
	customer_id,
    first_name,
    points,
    'Gold' AS type
FROM customers 
WHERE points > 3000
ORDER BY first_name;

# Column attributes, insert, update, and delete data
## Column attributes
-- Datatype: CHAR(50), VARCHAR(50): character but more space saving(when you only have 5 characters, sql only uses 5 and save the rest 45) 
-- PK: Primary key
-- NN: Not Null
-- AI: Auto increment which can automatically gives a unique value when inserting a new row, usually with Primary Key
-- Default/Expression: default value

## INSERT INTO table VALUES(): Insert a row into a table
INSERT INTO customers
VALUES (
	DEFAULT,
    'John',
    'Smith',
    '1990-01-01',
    NULL,
    'address',
    'city',
    'CA',
    DEFAULT);
    
-- Only supply values for designated columns
INSERT INTO customers (
	first_name, 
    last_name, 
    birth_date,
    address,
    city,
    state)
VALUES (
	'John',
    'Smith',
    '1990-01-01',
    'address',
    'city',
    'CA'
); # The columns can be listed in any orders

## Insert multiple rows
INSERT INTO shippers (name)
VALUES 
	('shipper1'),
	('shipper2'),
    ('shipper3');
	
## EXERCISE: insert 3 rows in the products table
INSERT INTO products (name, quantity_in_stock, unit_price)
VALUES
	('product1', 10, 5),
    ('product2', 10, 6),
    ('product3', 10, 7);
    
## Insert hierarchical rows
-- LAST.INSERT.ID() can return the Primary key of the last item inserted
-- We can use LAST.INSERT.ID() to insert rows in a second table
INSERT INTO orders (customer_id, order_date, status)
VALUES (1, "2019-01-02", 1);

INSERT INTO order_items
VALUES 
	(LAST_INSERT_ID(), 1, 1, 2.95),
    (LAST_INSERT_ID(), 2, 1, 3.95);

# CREATE TABLE AS: 
## create a new table from an existing table 
CREATE TABLE order_archived AS
SELECT * FROM orders;
-- The primary key are not transplanted to the new table
-- AI (Auto Increment) is not transplanted to the new table
-- The SELECT statement above is a subquery, which is a select statement as a part of another SQL statement
-- Right-click the table and click Truncate table can clean the table 

## Subquery to insert data in one table to another new table
INSERT INTO order_archived
SELECT *
FROM orders
WHERE order_date < '2019-01-01';

## EXERCISE: 
USE sql_invoicing;
CREATE TABLE invoice_archived AS
SELECT 
	i.invoice_id,
    i.number,
    c.name AS client,
    i.invoice_total,
    i.payment_total,
    i.invoice_date,
    i.due_date,
    i.payment_date
FROM invoices i
INNER JOIN clients c
	USING (client_id)
WHERE i.payment_date IS NOT NULL; 

# UPDATE: Update data in SQL
## UPDATE
UPDATE invoices
SET payment_total = 10, payment_date = '2019-03-01'
WHERE invoice_id = 1;

## UPDATE: NULL and DEFAULT can be set as well
UPDATE invoices
SET 
	payment_total = DEFAULT, 
	payment_date = NULL
WHERE invoice_id = 1;

## UPDATE: update columns by calculating other columns
UPDATE invoices
SET 
	payment_total = invoice_total * 0.5,
    payment_date = due_date
WHERE invoice_id = 3;

## Update multiple rows
UPDATE invoices
SET
	payment_total = invoice_total * 0.5,
    payment_date = due_date
WHERE client_id IN (3,4); # By leaving the WHERE clause out, you can update the entire table

## EXERCISE: write a SQL statement to
-- give any customers born before 1990 50 extra points
USE sql_store;
UPDATE customers 
SET points = points + 50
WHERE birth_date < '1990-01-01';

## USE Subquery to update the invoices 
USE sql_invoicing;
UPDATE invoices
SET
	payment_total = invoice_total * 0.5,
    payment_date = due_date
WHERE client_id = 
					(SELECT client_id
                    FROM clients
                    WHERE name = 'Myworks');

USE sql_invoicing;
UPDATE invoices
SET
	payment_total = invoice_total * 0.5,
    payment_date = due_date
WHERE client_id IN # Use in instead of '='  when multiplt rows are returned
					(SELECT client_id
                    FROM clients
                    WHERE state IN ('CA', 'NY'));


## EXERCISE: update the comments in orders for customers with > 3000 points
USE sql_store;
UPDATE orders
SET comments = 'Gold'
WHERE customer_id IN 
	(SELECT customer_id
    FROM customers 
    WHERE points > 3000);
    
## DELETE FROM: delete rows
USE sql_invoicing;
DELETE FROM invoices
WHERE invoice_id = 1; # Without the WHERE clause, you delete all the records in the table

## Delete using subquery
DELETE FROM invoices
WHERE client_id = 
	(SELECT client_id 
    FROM clients
    WHERE name = 'Myworks')

# At the end of this part, let's restore all the datebases by re-running the 'create-databases' script