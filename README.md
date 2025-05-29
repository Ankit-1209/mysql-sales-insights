# Sales Dataset SQL Analysis Project
## 📊 Objective
This project demonstrates my ability to perform SQL-based data analysis on a relational sales dataset. The goal was to write efficient, insightful queries that uncover patterns, trends, and business metrics from raw sales data.

## 🧰 Tools Used
- **MySQL Workbench 8.0**
- **Local Dataset**: `sales` dataset (imported via CSV files)
- **SQL Language** 

## 📁 Files Included
- `MySQL_queries_sales`: All SQL queries written for analysis.
- `MySQL_screenshots_query result`: Contains screenshots of the import process, query results, and table schemas.
- `README.md`: This file.

## 🧠 What I Did

### ✅ Step 1: Data Import
- Imported CSV files into MySQL using **Table Data Import Wizard**
- Tables included: `customers`, `products`, `orders`, `date`, `markets`, `transactions`

### ✅ Step 2: Data Exploration & Queries
- Used `SELECT`, `WHERE`, `ORDER BY`, `GROUP BY` to find top-selling products, customer segments, and market-wise performance
- Joined tables using `INNER JOIN`, `LEFT JOIN` to combine customer, order, and product data
- Created **subqueries** for advanced filtering
- Used **aggregate functions** like `SUM`, `AVG`, `COUNT`
- Built **views** for reusable analysis
- Created **indexes** on frequently queried columns like `order_date`

## 📊 Key Insights
- Top 5 customers contributed to over 30% of revenue
- Most sales came from the **E-commerce** customer type
- Some products had **zero sales** in the last year
- Certain customers ordered the same product multiple times in a day
- Specific months had noticeable drops in sales

## 🧾 How to Use
1. Clone/download this repository
2. Open `MySQL_queries_sales` in MySQL Workbench
3. Run each query sequentially to explore insights
4. Use or tweak queries for deeper analysis

Made as part of a Data Analysis Internship Task ✅  
Using real-world structured data, logic, and SQL proficiency 📈
