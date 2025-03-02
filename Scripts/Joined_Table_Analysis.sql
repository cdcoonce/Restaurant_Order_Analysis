-- 1. Combine the menu_items abd order-details tables into a single table.
	SELECT *
	FROM order_details od
	left JOIN menu_items mi
	ON od.item_id = mi.menu_item_id;

-- 2. What were the least and most ordered items? What categories were they in?
	(SELECT item_name, COUNT(order_details_id) AS 'Items Ordered', Category
	FROM order_details od
	left JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
	GROUP BY item_name, category
	ORDER BY COUNT(order_details_id) DESC
	LIMIT 1)
	UNION
	(SELECT item_name, COUNT(order_details_id) AS 'Items Ordered', Category
	FROM order_details od
	left JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
	GROUP BY item_name, category
	ORDER BY COUNT(order_details_id)
	LIMIT 1);

-- 3. What were the top 5 orders that spent the most money?
	SELECT order_id, SUM(price) AS 'Total Order Price'
	FROM order_details od
	left JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
    GROUP BY order_id
    ORDER BY SUM(price) DESC
    LIMIT 5;
    
-- 4. View the details from the highest spend order.
	SELECT category, COUNT(category) AS 'Number of Items'
	FROM order_details od
	left JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
    WHERE order_id = 440
    GROUP BY category;
    
-- 4. View the details of the top 5 highest spend orders.
	SELECT order_id, category, COUNT(category) AS 'Number of Items'
	FROM order_details od
	left JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
    WHERE order_id IN (440, 2075, 1957, 330, 2675)
    GROUP BY order_id, category;