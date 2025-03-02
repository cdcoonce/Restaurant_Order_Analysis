# Restaurant Sales Analysis - SQL Project

## Overview

This project analyzes restaurant sales and menu item data using SQL. The goal is to explore the restaurant's menu structure, pricing, and ordering trends, uncovering key insights that can help improve business decisions.

## Dataset

The project uses two tables:

1. **menu_items** - Contains details about menu items, including:
   - `menu_item_id`: Unique ID for each item
   - `item_name`: Name of the menu item
   - `category`: Category of the dish (e.g., Italian, American, etc.)
   - `price`: Price of the item

2. **order_details** - Contains order transaction details, including:
   - `order_details_id`: Unique ID for each order detail entry
   - `order_id`: The ID of the order
   - `order_date`: Date when the order was placed
   - `order_time`: Time when the order was placed
   - `item_id`: The menu item ordered (linked to `menu_items`)

## Key Business Questions & SQL Queries

### **Menu Analysis**

#### 1. How many items are on the menu?

```sql
SELECT COUNT(*) AS 'Total Menu Items' FROM menu_items;
```

#### 2. What are the least and most expensive menu items?

```sql
(SELECT *, 'Least Expensive Item' AS 'Price Category'
 FROM menu_items
 ORDER BY price
 LIMIT 1)
UNION
(SELECT *, 'Most Expensive Item'
 FROM menu_items
 ORDER BY price DESC
 LIMIT 1);
```

#### 3. How many dishes are in each category?

```sql
SELECT category, COUNT(*) AS 'Number of Dishes'
FROM menu_items
GROUP BY category
ORDER BY COUNT(*) DESC;
```

#### 4. What is the average price of dishes in each category?

```sql
SELECT category, CAST(AVG(price) AS DECIMAL(4,2)) AS 'Average Price'
FROM menu_items
GROUP BY category
ORDER BY AVG(price) DESC;
```

### **Order Analysis**

#### 5. What is the date range of the dataset?

```sql
SELECT MIN(order_date) AS 'First Order Date', MAX(order_date) AS 'Last Order Date'
FROM order_details;
```

#### 6. How many orders were placed within this date range?

```sql
SELECT COUNT(DISTINCT order_id) AS 'Total Orders'
FROM order_details;
```

#### 7. What are the least and most ordered items, and what categories are they in?

```sql
(SELECT item_name, COUNT(order_details_id) AS 'Items Ordered', category
 FROM order_details od
 LEFT JOIN menu_items mi ON od.item_id = mi.menu_item_id
 GROUP BY item_name, category
 ORDER BY COUNT(order_details_id) DESC
 LIMIT 1)
UNION
(SELECT item_name, COUNT(order_details_id), category
 FROM order_details od
 LEFT JOIN menu_items mi ON od.item_id = mi.menu_item_id
 GROUP BY item_name, category
 ORDER BY COUNT(order_details_id) ASC
 LIMIT 1);
```

#### 8. What were the top 5 most expensive orders?

```sql
SELECT order_id, SUM(price) AS 'Total Order Price'
FROM order_details od
LEFT JOIN menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY order_id
ORDER BY SUM(price) DESC
LIMIT 5;
```

#### 9. What were the details of the top 5 highest spending orders?

```sql
SELECT order_id, category, COUNT(category) AS 'Number of Items'
FROM order_details od
LEFT JOIN menu_items mi ON od.item_id = mi.menu_item_id
WHERE order_id IN (SELECT order_id FROM order_details GROUP BY order_id ORDER BY SUM(price) DESC LIMIT 5)
GROUP BY order_id, category;
```

## Results

- **Date Range:**

Orders in the dataset span from January 1, 2023, to March 31, 2023.

- **Menu Analysis:**

Italian cuisine had the highest average price per dish ($16.75), followed by Asian ($13.48), Mexican ($11.80), and American ($10.07).

Italian food consistently appeared in the highest order values, suggesting it is a high-value menu category.

- **Order Trends:**

The largest number of items in a single order was 14.

The top 5 highest spending orders were dominated by Italian dishes, reinforcing the trend that Italian food contributes significantly to total revenue.

## Technical Concepts Used

- **Aggregation** (`COUNT`, `AVG`, `SUM`, `MIN`, `MAX`)
- **Filtering** (`WHERE`, `HAVING`)
- **Sorting & Limiting** (`ORDER BY`, `LIMIT`)
- **Combining Results** (`UNION`)
- **Joins** (`LEFT JOIN` for merging tables)
- **Subqueries** (used in filtering and ranking queries)
- **Grouping** (`GROUP BY` for category-based analysis)

## How to Run the Queries

1. Ensure you have a MySQL database installed.
2. Create the `restaurant_db` schema.
3. Import the dataset (`menu_items` and `order_details`).
4. Run the queries using MySQL Workbench or any SQL client.
