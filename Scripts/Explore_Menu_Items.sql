USE restaurant_db;

-- 1. View the menu_items tab;e.
	SELECT * FROM menu_items;

-- 2. Find the mumbe rof items on the menu.
	SELECT COUNT(*) FROM menu_items;
    
-- 3. What are the least and most expensive items on the menu?
	(SELECT *, 'Least Expensive Item'
    FROM menu_items
    ORDER BY price
    LIMIT 1)
    UNION
	(SELECT *, 'Most Expensive Item'
    FROM menu_items
    ORDER BY price DESC
    LIMIT 1);
    
-- 4. How many Italian Dishes are on the menu?
	Select COUNT(*) AS 'Number of Italian Dishes'
	FROM menu_items
    WHERE Category = 'Italian';
    
-- 5. What are the least and most expensive Italian Dishes on the menu?
	(SELECT *, 'Least Expensive Item' AS ' '
    FROM menu_items
    WHERE category = 'Italian'
    ORDER BY price
    LIMIT 1)
    UNION
	(SELECT *, 'Most Expensive Item'
    FROM menu_items
    WHERE category = 'Italian'
    ORDER BY price DESC
    LIMIT 1);
    
-- 6. How many Dishes are in each category?
	SELECT Category, COUNT(category) AS 'Count of Dishes'
    FROM menu_items
    GROUP BY category
    ORDER BY COUNT(category) DESC;

-- 7. What is the average dish price within each category?
	SELECT Category, CAST(AVG(price) AS DECIMAL(4,2)) AS 'Average Price of Dishes'
    FROM menu_items
    GROUP BY category
    ORDER BY AVG(price) DESC;