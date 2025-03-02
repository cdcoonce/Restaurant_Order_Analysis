-- 1. View the order details table. 
	SELECT *
    FROM order_details;
    
-- 2. What is the date range of the table?
	SELECT MAX(order_date) AS 'Last Order Date', MIN(order_date) 'First Order Date'
    FROM order_details;
    
-- 3. How many orders were made during this date range?
	SELECT COUNT(DISTINCT order_id) AS 'Number of orders'
    FROM order_details;

-- 4. How many items were ordered during this date range?
	SELECT COUNT(*) AS 'ITEMS ORDERED'
    FROM order_Details;
	
-- 5. Which orders had the most number of items?
	SELECT order_id, COUNT(order_id) AS 'Number of Items'
    FROM order_details
    GROUP BY order_id
    ORDER BY COUNT(order_id) DESC;
    
-- 6. How many orders had more than 12 items?
	SELECT COUNT(*)
    FROM
		(SELECT order_id, COUNT(order_id) AS 'Number of Items'
		FROM order_details
		GROUP BY order_id
		HAVING COUNT(order_id) > 12) AS num_items;
