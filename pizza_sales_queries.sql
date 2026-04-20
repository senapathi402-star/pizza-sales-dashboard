-- ============================================
-- PIZZA SALES ANALYTICS
-- Author: Senapathi Krishna Sai
-- Tools: MySQL | Tableau
-- Dataset: 4 Tables - pizzas, pizza_types, orders, order_details
-- ============================================

-- ============================================
-- BASIC ANALYSIS
-- ============================================

-- 1) Find the total number of orders placed
SELECT 
    COUNT(order_id) AS 'Num_of_entries'
FROM 
    orders;
-- Output: 21350

-- ============================================

-- 2) Calculate the total revenue from pizza sales
SELECT 
    ROUND(SUM(quantity * price), 0) AS 'Total_Revenue'
FROM 
    order_details AS od 
JOIN pizzas AS p ON od.pizza_id = p.pizza_id;
-- Output: 817860

-- ============================================

-- 3) Identify the highest-priced pizza
SELECT * 
FROM pizzas 
ORDER BY price DESC 
LIMIT 1;
-- Output: the_greek_xxl | the_greek | XXL | 35.95

-- ============================================

-- 4) Determine the most frequently ordered pizza size
SELECT 
    size,
    COUNT(*) AS 'Order_count'
FROM 
    order_details AS od 
JOIN pizzas AS p ON od.pizza_id = p.pizza_id
GROUP BY size
ORDER BY Order_count DESC 
LIMIT 1;
-- Output: L | 18526

-- ============================================

-- 5) List the top 5 pizzas by order quantity
SELECT 
    p.pizza_type_id,
    SUM(quantity) AS 'Total_quantity'
FROM 
    order_details AS od 
JOIN pizzas AS p 
JOIN pizza_types AS pt
    ON od.pizza_id = p.pizza_id
    AND p.pizza_type_id = pt.pizza_type_id
GROUP BY p.pizza_type_id
ORDER BY SUM(quantity) DESC 
LIMIT 5;
-- Output: classic_dlx(2453), bbq_ckn(2432), hawaiian(2422), pepperoni(2418), thai_ckn(2371)

-- ============================================
-- INTERMEDIATE ANALYSIS
-- ============================================

-- 1) Calculate the total quantity ordered for each pizza category
SELECT 
    category,
    SUM(quantity) AS 'total_quantity'
FROM 
    order_details AS od 
JOIN pizzas AS p 
JOIN pizza_types AS pt
    ON od.pizza_id = p.pizza_id
    AND p.pizza_type_id = pt.pizza_type_id
GROUP BY category
ORDER BY SUM(quantity) DESC;
-- Output: Classic(14888), Supreme(11987), Veggie(11649), Chicken(11050)

-- ============================================

-- 2) Analyze the distribution of orders by hour of day
SELECT 
    HOUR(time) AS order_hour,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_hour
ORDER BY order_hour;
-- Output: Peak hour is 12 PM with 2520 orders

-- ============================================

-- 3) Determine the order distribution of pizzas by name
SELECT 
    name,
    SUM(quantity) AS 'total_quantity'
FROM 
    order_details AS od 
JOIN pizzas AS p 
JOIN pizza_types AS pt
    ON od.pizza_id = p.pizza_id
    AND p.pizza_type_id = pt.pizza_type_id
GROUP BY name
ORDER BY SUM(quantity) DESC;

-- ============================================

-- 4) Calculate the average number of pizzas ordered each day (CTE)
WITH daily_orders AS (
    SELECT 
        date,
        SUM(quantity) AS 'total_orders'
    FROM 
        order_details AS od 
    JOIN orders AS o ON od.order_id = o.order_id
    GROUP BY date
)
SELECT 
    ROUND(AVG(total_orders), 0) AS 'avg_orders_per_day'
FROM daily_orders;
-- Output: 138

-- ============================================

-- 5) Identify the top 3 pizzas based on revenue
SELECT 
    pt.name,
    ROUND(SUM(quantity * price), 0) AS 'total_revenue'
FROM 
    order_details AS od 
JOIN pizzas AS p 
JOIN pizza_types AS pt
    ON od.pizza_id = p.pizza_id
    AND p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_revenue DESC 
LIMIT 3;
-- Output: The Thai Chicken Pizza(43434), The Barbecue Chicken Pizza(42768), The California Chicken Pizza(41410)

-- ============================================
-- ADVANCED ANALYSIS
-- ============================================

-- 1) Calculate each pizza type's percentage contribution to total revenue (Window Function)
SELECT 
    od.pizza_id,
    ROUND(SUM(quantity * price), 0) AS 'total_revenue',
    ROUND((SUM(quantity * price) * 100.0) / SUM(SUM(quantity * price)) OVER (), 2) AS 'revenue_percentage'
FROM 
    order_details AS od 
JOIN pizzas AS p ON od.pizza_id = p.pizza_id
GROUP BY od.pizza_id
ORDER BY revenue_percentage DESC;
-- Output: thai_ckn_l(3.58%), five_cheese_l(3.19%), four_cheese_l(2.89%)

-- ============================================

-- 2) Track cumulative revenue growth over time (Window Function)
SELECT 
    date,
    ROUND(SUM(daily_revenue) OVER (ORDER BY date), 0) AS cumulative_revenue
FROM (
    SELECT 
        date,
        SUM(od.quantity * p.price) AS daily_revenue
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    JOIN pizzas p ON od.pizza_id = p.pizza_id
    GROUP BY date
) revenue_by_day
ORDER BY date;

-- ============================================

-- 3) Determine the top 3 pizzas by revenue within each category (Dense Rank)
SELECT 
    category,
    pizza_type_id,
    revenue,
    ranking
FROM (
    SELECT 
        category,
        p.pizza_type_id,
        ROUND(SUM(quantity * price), 0) AS revenue,
        DENSE_RANK() OVER (PARTITION BY category ORDER BY ROUND(SUM(quantity * price), 0) DESC) AS ranking
    FROM 
        order_details AS od 
    JOIN pizzas AS p 
    JOIN pizza_types AS pt
        ON od.pizza_id = p.pizza_id 
        AND p.pizza_type_id = pt.pizza_type_id
    GROUP BY category, p.pizza_type_id
) AS top_pizzas
WHERE ranking <= 3
ORDER BY category, ranking;
-- Output: Chicken(bbq_ckn, cali_ckn, ckn_alfredo), Classic(hawaiian, the_greek, pepperoni)
--         Supreme(peppr_salami, calabrese, spinach_supr), Veggie(green_garden, spinach_fet)
