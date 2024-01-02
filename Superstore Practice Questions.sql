---Easy Practice with Superstore data set


--- Using * and DISTINCT
SELECT * 
FROM RETURNED_ORDERS;

SELECT *
FROM ORDERS; 

SELECT * 
FROM ORDERS LIMIT 100;

SELECT order_id, order_date
FROM ORDERS;

SELECT PRODUCT_ID
FROM ORDERS;

SELECT DISTINCT PRODUCT_ID, SHIP_MODE
FROM ORDERS;



-- Unique list of product names per ship mode
SELECT DISTINCT SHIP_MODE, PRODUCT_NAME
FROM ORDERS
INNER JOIN PRODUCTS  
    ON ORDERS.PRODUCT_ID = PRODUCTS.PRODUCT_ID;




-- list of orders with return status
SELECT DISTINCT orders.order_id, returned 
FROM orders 
LEFT JOIN returned_orders ON orders.order_id = returned_orders.order_id;




--list of all sales reps and all customers
SELECT DISTINCT customers.customer_id,customer_name, sales_person_fullname
FROM customers
FULL JOIN customer_sales_rep
  ON customers.customer_id = customer_sales_rep.customer_id;


-- all orders from customers in central region
SELECT o.customer_id, c.region
FROM orders AS o
INNER JOIN customers AS c
  ON o.customer_id = c.customer_id
WHERE region = 'Central';


-- all unique states and prdouct names in central

SELECT DISTINCT c.state, p.product_name
FROM orders AS o
JOIN customers AS c
    ON o.customer_id = c.customer_id
JOIN products as p
    ON o.product_id = p.product_id
WHERE region = 'Central';



-- unique customer region city from all except central
SELECT DISTINCT city,
                region
FROM customers
WHERE region <> 'Central';


-- unique products that start with letter b
SELECT DISTINCT product_name 
FROM products
WHERE product_name LIKE 'B%';


-- cities with town in name
SELECT DISTINCT city
FROM customers
WHERE city ilike '%town%';


-- unique cities in alabama georgia florida
SELECT DISTINCT city, state
FROM customers 
WHERE state IN ('Alabama', 'Georgia', 'Florida');


--orders qty > 1 profit<0
SELECT order_id, quantity, profit
FROM orders
WHERE quantity > 1 AND profit < 0;


-- orders between jan 1 2019 and dec 31 2019
SELECT order_id, order_date
FROM orders
WHERE order_date BETWEEN '01/01/2019' AND '12/31/2019';


-- # of rows in orders
SELECT count(*)
FROM orders;


-- How many unique products are there
SELECT count(DISTINCT product_id)
FROM products;


-- total quantity ordered
SELECT sum(quantity) AS "Total Quantity"
FROM orders;


-- quantity ordered per product
SELECT sum(quantity) AS "Total Quantity", product_id 
FROM orders
GROUP BY product_id;


--Number of customers by state and sales person
SELECT count(DISTINCT c.customer_id), c.state, sr.sales_person_id
FROM customers AS c
JOIN customer_sales_rep AS sr
  ON c.customer_id = sr.customer_id
GROUP BY c.state, sr.sales_person_id;


--largest discount and total profit per state
SELECT max(discount), sum(profit), state
FROM orders AS o
JOIN customers AS c
  ON o.customer_id = c.customer_id
GROUP BY state;


-- days profit > 500
SELECT date(order_date) , sum(profit)
FROM orders
GROUP BY order_date
HAVING sum(profit) > 500
ORDER BY order_date;


-- states in reverse alphabetical order
SELECT DISTINCT state
FROM customers
ORDER BY state DESC;


-- cnt customers per state sorted
SELECT count(*) AS "# of Customers", state
FROM customers    
GROUP BY state
ORDER BY "# of Customers" DESC;
