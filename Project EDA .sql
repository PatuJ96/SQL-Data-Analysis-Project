


-- Explore DataBase tables

SELECT * FROM INFORMATION_SCHEMA.TABLES;


-- Explore DataBase
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers'


/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - To explore the structure of dimension tables.
	
SQL Functions Used:
    - DISTINCT
    - ORDER BY
===============================================================================
*/

-- Retrieve a list of unique countries from which customers originate
SELECT DISTINCT 
    country 
FROM gold.dim_customers
ORDER BY country;

-- Retrieve a list of unique categories, subcategories, and products
SELECT DISTINCT 
    category, 
    subcategory, 
    product_name 
FROM gold.dim_products
ORDER BY category, subcategory, product_name;


/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.

SQL Functions Used:
    - MIN(), MAX(), DATEDIFF()
===============================================================================
*/

-- Determine the first and last order date and the total duration in months

SELECT 
MIN(order_date) AS first_order_date,
MAX(order_date) AS last_order_date,
DATEDIFF(MONTH, MIN(order_date),MAX(order_date)) AS order_range_months
FROM gold.fact_sales;

-- Find the youngest and oldest customer based on birthdate

SELECT 
MIN(birthdate) AS youngest_birthdate,
DATEDIFF(YEAR, MIN(birthdate), GETDATE()) Youngest_Age,
MAX(birthdate) AS oldest_birthdate,
DATEDIFF(YEAR, MAX(birthdate), GETDATE()) oldest_Age
FROM gold.dim_customers;


/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG()
===============================================================================
*/


-- Find the Total Sales
SELECT SUM(sales_amount) as TotalSales FROM gold.fact_sales;

-- Find how many items are sold
SELECT SUM(quantity) as TotalSales FROM gold.fact_sales;

-- Find the average selling price
SELECT AVG(price) AS avg_price FROM gold.fact_sales;

-- Find the Total number of Orders
SELECT COUNT(order_number) AS TotalOrders FROM gold.fact_sales;

SELECT COUNT(DISTINCT order_number) AS TotalOrders FROM gold.fact_sales;

-- Find the total number of products

SELECT COUNT(product_name) AS TotalProducts FROM gold.dim_products;
SELECT COUNT(DISTINCT product_name) AS TotalProducts FROM gold.dim_products;

-- Find the total number of customers
SELECT COUNT(customer_key) AS TotalCustomers FROM gold.dim_customers;
SELECT COUNT(DISTINCT customer_key) AS TotalCustomers FROM gold.dim_customers;


-- Generate a Report that shows all key metrics of the business

SELECT 'Total Sales' AS Measure_name, SUM(sales_amount) as Measure_values FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity', SUM(quantity) FROM gold.fact_sales
UNION ALL
SELECT  'Average Price', AVG(price) FROM gold.fact_sales
UNION ALL
SELECT 'Total Nr. Orders',COUNT(order_number) FROM gold.fact_sales
UNION ALL
SELECT 'Total Nr. Products ', COUNT(product_name) FROM gold.dim_products
UNION ALL
SELECT 'Total Nr. Customers', COUNT(customer_key)  FROM gold.dim_customers;


/*
Magnitude Analysis

Purpose:
    - To quantify data and group results by specific dimensions.
    - For understanding data distribution across categories.

SQL Functions Used:
    - Aggregate Functions: SUM(), COUNT(), AVG()
    - GROUP BY, ORDER BY
*/

-- Find total customers by countries

SELECT
country,
COUNT(customer_key) AS Total_Customer
FROM gold.dim_customers
GROUP BY country
ORDER BY Total_Customer DESC

-- Find total customers by gender

SELECT
gender,
COUNT(customer_key) AS Total_Customer
FROM gold.dim_customers
GROUP BY gender
ORDER BY Total_Customer DESC

-- Find total products by category

SELECT
category,
COUNT(product_key) AS Total_Product
FROM gold.dim_products
GROUP BY category
ORDER BY Total_Product DESC

-- What is the average costs in each category?

SELECT
category,
AVG(cost) AS Avg_cost
FROM gold.dim_products
GROUP BY category
ORDER BY Avg_cost DESC

-- What is the total revenue generated for each category?

SELECT
p.category,
SUM(f.sales_amount) Total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.category
ORDER BY Total_revenue DESC

-- What is the total revenue generated by each customer?
SELECT
c.customer_key,
c.first_name,
c.last_name,
SUM(f.sales_amount) Total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON f.customer_key = c.customer_key
GROUP BY 
c.customer_key,
c.first_name,
c.last_name
ORDER BY Total_revenue DESC


-- What is the distribution of sold items across countries?

SELECT
c.country,
SUM(f.quantity) Total_quantity
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON f.customer_key = c.customer_key
GROUP BY country
ORDER BY Total_quantity DESC



/*
Ranking Analysis
===============================================================================
Purpose:
    - To rank items (e.g., products, customers) based on performance or other metrics.
    - To identify top performers or laggards.

SQL Functions Used:
    - Window Ranking Functions: RANK(), DENSE_RANK(), ROW_NUMBER(), TOP
    - Clauses: GROUP BY, ORDER BY
===============================================================================
*/

-- Which 5 products Generating the Highest Revenue?
SELECT TOP 5
p.product_name,
SUM(f.sales_amount) total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC


-- Optional 
-- Complex but Flexibly Ranking Using Window Functions

SELECT * FROM(
SELECT
p.product_name,
SUM(f.sales_amount) total_revenue,
ROW_NUMBER() OVER(ORDER BY SUM(f.sales_amount) DESC) as rank_products
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.product_name
)t
WHERE rank_products <=5

-- Which 10 CUSTOMERS WHO Generating the Highest Revenue?

SELECT * FROM
(
SELECT
c.customer_key,
c.first_name,
c.last_name,
COUNT(DISTINCT order_number) Total_Orders,
ROW_NUMBER() OVER(ORDER BY COUNT(DISTINCT order_number) DESC) AS Cust_Revenue_Rank
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON f.customer_key = c.customer_key
GROUP BY 
c.customer_key,
c.first_name,
c.last_name
)t
WHERE Cust_Revenue_Rank <= 10

-- OPTIONAL

SELECT TOP 10
c.customer_key,
c.first_name,
c.last_name,
COUNT(DISTINCT order_number) Total_Orders
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON f.customer_key = c.customer_key
GROUP BY 
c.customer_key,
c.first_name,
c.last_name
ORDER BY Total_Orders DESC

-- The 3 customers with the fewest orders placed

SELECT TOP 3
c.customer_key,
c.first_name,
c.last_name,
COUNT(DISTINCT order_number) Total_Orders
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON f.customer_key = c.customer_key
GROUP BY 
c.customer_key,
c.first_name,
c.last_name
ORDER BY Total_Orders ASC

-- Which 5 worst performing products in terms of sales?

SELECT TOP 5
p.product_name,
SUM(f.sales_amount) total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue 


