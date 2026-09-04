# SQL Data Analysis Project
### Retail-Data-Warehouse-Analytics-Customer-Product-Performance
This project involves the development of a structured data warehouse reporting using SQL. The goal was to transform raw transactional data into actionable business intelligence by creating optimized Gold tier reporting views. These views provide insights into customer purchasing behavior, product lifecycle performance, and overall revenue metrics.

### 📊 Key Reports Generated

#### 1. Customer Performance Report (gold.report_customer):

This report segments customers and calculates their lifetime value (LTV) metrics, enabling targeted marketing and customer retention strategies.

a) Demographic Analysis: Groups customers by age brackets (age_group).

b) Customer Segmentation: Categorizes buyers into actionable segments (e.g., 'VIP', 'New') based on their purchasing history.

c) Behavioral Metrics: Tracks recency (days since last order) and active lifespan.

d) Financial KPIs: Aggregates total_orders, total_sales, avg_order_value, and avg_monthly_spend to identify the most valuable customer profiles.

#### 2. Product Performance Report (gold.report_products):

This report evaluates inventory performance, helping the business understand which products drive the most revenue and which are underperforming.

a)Product Hierarchy: Categorizes items by category and subcategory (e.g., Bikes > Mountain Bikes).

b)Performance Segmentation: Classifies products into segments like 'High-Performer' and 'Mid-Range' based on sales velocity and revenue generation.

c)Lifecycle Tracking: Monitors product lifespan and recency_in_months to identify aging inventory or trending items.

d)Revenue Metrics: Calculates total_sales, avg_selling_price, and avg_monthly_revenue to gauge overall profitability per item.



### 🛠️ Tech Stack
SQL: Data extraction, transformation, aggregation, Subqueries, CTEs (Common Table Expressions), and view creation.

Database: SQL Server (Microsoft SSMS).
