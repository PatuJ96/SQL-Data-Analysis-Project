# Retail-Data-Warehouse-Analytics-Customer-Product-Performance
This project involves the development of a structured data warehouse reporting using SQL. The goal was to transform raw transactional data into actionable business intelligence by creating optimized Gold tier reporting views. These views provide insights into customer purchasing behavior, product lifecycle performance, and overall revenue metrics.

1. Customer Performance Report (gold.report_customer)
    
This report segments customers and calculates their lifetime value (LTV) metrics, enabling targeted marketing and customer retention strategies.
a) Demographic Analysis: Groups customers by age brackets (age_group).

b) Customer Segmentation: Categorizes buyers into actionable segments (e.g., 'VIP', 'New') based on their purchasing history.

c) Behavioral Metrics: Tracks recency (days since last order) and active lifespan.

d) Financial KPIs: Aggregates total_orders, total_sales, avg_order_value, and avg_monthly_spend to identify the most valuable customer profiles.
