/*
Change Over Time
===============================================================================
Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.

SQL Functions Used:
    - Date Functions: DATEPART(), DATETRUNC(), FORMAT()
    - Aggregate Functions: SUM(), COUNT(), AVG()
===============================================================================
*/

SELECT
DATETRUNC(MONTH,order_date) order_date,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total,
SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH,order_date)
ORDER BY DATETRUNC(MONTH,order_date)

-- By using Format

SELECT
FORMAT(order_date, 'yyyy-MMM') order_date,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total,
SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date, 'yyyy-MMM')
ORDER BY FORMAT(order_date, 'yyyy-MMM')