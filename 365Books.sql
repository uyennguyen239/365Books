-- Retrieve data 2020

SELECT *
FROM order_history
WHERE DATE_PART('year', status_date) = 2020;

-- #Sale Analysis: retrieve total sales revenue for each year
	-- Total sales since 2020 until now
	
SELECT SUM (price_vnd) FROM order_line

	-- Total sales of 2020
	
SELECT SUM(price_vnd * quantity) AS total_revenue_2020
FROM order_line ol 
JOIN cust_order co ON ol.order_id = co.order_id
WHERE DATE_PART('year', co.order_date) = 2020;

	-- Total sales of 2021
	
SELECT SUM(order_line.price_vnd) 
FROM order_line 
INNER JOIN order_history
ON order_line.order_id = order_history.order_id
WHERE DATE_PART('year', status_date) = 2021;

	-- Total sales of 2022
	
SELECT SUM(order_line.price_vnd) 
FROM order_line 
INNER JOIN order_history
ON order_line.order_id = order_history.order_id
WHERE DATE_PART('year', status_date) = 2022;

	-- Total sales of 2023
	
SELECT SUM(order_line.price_vnd) 
FROM order_line 
INNER JOIN order_history
ON order_line.order_id = order_history.order_id
WHERE DATE_PART('year', status_date) = 2023;

	-- Retrieve top selling base on quantity sold
	
SELECT 
	b.book_id,
	b.title,
	b.genres,
	SUM (ol.quantity) AS total_quantity_sold
FROM 
	book b
JOIN
	order_line ol ON ol.book_id = b.book_id
JOIN 
	cust_order co ON co.order_id = ol.book_id
WHERE 
	DATE_PART('year', co.order_date) = 2020
GROUP BY
	b.title,
	b.book_id,
	b.genres
ORDER BY
	total_quantity_sold DESC
LIMIT 50;

	-- Retrieve top revenue by price_vnd and quantity
	
SELECT 
	b.book_id,
	b.title,
	SUM (ol.price_vnd * ol.quantity) AS total_sale_revenue
FROM book b
JOIN order_line ol ON ol.book_id = b.book_id
JOIN cust_order co ON co.order_id = ol.order_id
WHERE 
	DATE_PART ('year', co.order_date) = '2020'
GROUP BY
	b.book_id,
	b.title
ORDER BY total_sale_revenue DESC;

	-- Retrieve top selling by publisher_id 2020
	
SELECT
	p.publisher_name,
	p.publisher_id,
	SUM (ol.quantity) AS total_quantity_sold_publisher
FROM publisher p
JOIN book b ON b.publisher_id = p.publisher_id
JOIN order_line ol ON ol.book_id = b.book_id
JOIN cust_order co ON co.order_id = ol.line_id
WHERE DATE_PART ('year',co.order_date)='2020'
GROUP BY
	p.publisher_name,
	p.publisher_id
ORDER BY total_quantity_sold_publisher DESC;

	-- Retrive top sales revenue by author 2020
	
SELECT
    a.author_id,
    a.author_name,
    SUM(ol.quantity * ol.price_vnd) AS total_sales_revenue
FROM
    book b
JOIN
    order_line ol ON b.book_id = ol.book_id
JOIN
    cust_order co ON ol.order_id = co.order_id
JOIN
    book_author ba ON b.book_id = ba.book_id
JOIN
    author a ON ba.author_id = a.author_id
WHERE
    DATE_PART('year', co.order_date) = 2020
GROUP BY
    a.author_id,
    a.author_name
ORDER BY
    total_sales_revenue DESC;


-- Sales accross genres in 2020

SELECT 
	b.genres,
	SUM (ol.price_vnd) AS total_sales_revenue
FROM book b
JOIN order_line ol ON ol.book_id = b.book_id
JOIN cust_order co ON co.order_id = ol.order_id
WHERE DATE_PART ('year', co.order_date) = '2020'
GROUP BY b.genres
ORDER BY total_sales_revenue DESC;

-- Monthly sales in 2020

SELECT DATE_TRUNC('month', co.order_date) AS month,
       SUM(ol.price_vnd) AS total_sales
FROM cust_order co
JOIN order_line ol ON co.order_id = ol.order_id
WHERE DATE_PART('year', co.order_date) = 2020
GROUP BY DATE_TRUNC('month', co.order_date)
ORDER BY total_sales DESC;

-- Customer list in 2020

SELECT 
	c.first_name,
	c.last_name,
	c.email,
	co.customer_id
FROM customer c
JOIN cust_order co ON co.customer_id = c.customer_id
WHERE DATE_PART ('year', co.order_date) = 2021 
GROUP BY 
	c.first_name,
	c.last_name,
	c.email,
	co.customer_id
ORDER BY co.customer_id ASC;


---Top 10 customer place order in 2020

SELECT
	c.customer_id,
	c.first_name,
	c.email,
	COUNT (co.customer_id) as total_orders
FROM customer c
JOIN cust_order co ON co.customer_id = c.customer_id
WHERE DATE_PART ('year', co.order_date)= '2020'
GROUP BY 
	c.customer_id,
	c.first_name,
	c.email
ORDER BY total_orders DESC
LIMIT 10;



-- Count status_id from order_history
SELECT
	ot.status_value,
  oh.status_id,
  COUNT(*) AS count_status_id
FROM order_history oh
JOIN cust_order co ON co.order_id = oh.order_id
JOIN order_status ot ON ot.status_id = oh.status_id
WHERE DATE_PART ('year',co.order_date) = '2020'
GROUP BY 
	oh.status_id,
	ot.status_value;



-- Retrieve total order that cancelled-5 & returned-6 in 2020

SELECT
	oh.status_id,
	os.status_value,
	COUNT (*) AS count_status_id
FROM cust_order co
JOIN order_history oh ON oh.order_id = co.order_id
JOIN order_status os ON os.status_id = oh.status_id
WHERE  DATE_PART ('year',co.order_date) = '2020'
	AND oh.status_id IN (1,5,6)
GROUP BY 
	oh.status_id,
	os.status_value;


