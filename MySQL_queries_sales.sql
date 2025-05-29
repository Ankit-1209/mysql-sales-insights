use sales;
show tables;
describe transactions
;

-- 1) Create a View for Market-Wise Annual Sales
CREATE VIEW Market_Annual_Sales AS
SELECT m.markets_name, d.year, SUM(t.sales_qty) AS total_sales
FROM transactions t
JOIN markets m ON t.market_code = m.markets_code
JOIN date d ON t.order_date = d.date
GROUP BY m.markets_name, d.year;

-- 2) Product Types With No Sales in 2020
SELECT DISTINCT product_type
FROM products
WHERE product_code NOT IN (
    SELECT DISTINCT t.product_code
    FROM transactions t
    JOIN date d ON t.order_date = d.date
    WHERE d.year = 2020
);


-- 3) Highest Quantity Ordered Per Day
SELECT d.date, MAX(t.sales_qty) AS max_sales_qty
FROM transactions t
JOIN date d ON t.order_date = d.date
GROUP BY d.date
ORDER BY max_sales_qty DESC
LIMIT 6;

-- 4)Basic SELECT, WHERE, ORDER BY
SELECT * 
FROM customers
WHERE customer_type = 'Brick & Mortar'
ORDER BY custmer_name;
select * from customers;

-- 5) Top 5 Customers by Total Quantity Purchased
SELECT c.customer_code, c.custmer_name, SUM(t.sales_qty) AS total_quantity
FROM transactions t
JOIN customers c ON t.customer_code = c.customer_code
GROUP BY c.customer_code, c.custmer_name
ORDER BY total_quantity DESC
LIMIT 5;

-- 6) Most Popular Product Type by Customer Type
SELECT customer_type, product_type, SUM(sales_qty) AS total_qty
FROM (
    SELECT c.customer_type, p.product_type, t.sales_qty
    FROM transactions t
    JOIN customers c ON t.customer_code = c.customer_code
    JOIN products p ON t.product_code = p.product_code
) AS sub
GROUP BY customer_type, product_type
ORDER BY customer_type, total_qty DESC;

-- 7) Sales Trend Over Years
SELECT d.year, SUM(t.sales_qty) AS yearly_sales
FROM transactions t
JOIN date d ON t.order_date = d.date
GROUP BY d.year
ORDER BY d.year;

-- 8) Customers Who Ordered More Than Average Quantity
SELECT DISTINCT c.customer_code, c.custmer_name
FROM transactions t
JOIN customers c ON t.customer_code = c.customer_code
WHERE t.sales_qty > (
    SELECT AVG(sales_qty)
    FROM transactions
);

-- 9) Add Index on order_date
CREATE INDEX idx_order_date ON transactions(order_date);

-- 10) Top 3 Selling Product Types in Each Zone
SELECT zone, product_type, total_qty
FROM (
  SELECT m.zone, p.product_type, SUM(t.sales_qty) AS total_qty,
         RANK() OVER (PARTITION BY m.zone ORDER BY SUM(t.sales_qty) DESC) AS rnk
  FROM transactions t
  JOIN products p ON t.product_code = p.product_code
  JOIN markets m ON t.market_code = m.markets_code
  GROUP BY m.zone, p.product_type
) ranked
WHERE rnk <= 3;

-- 11) High-Performing Markets (Sales > 135000 units annually)
SELECT m.markets_name, d.year, SUM(t.sales_qty) AS annual_sales
FROM transactions t
JOIN markets m ON t.market_code = m.markets_code
JOIN date d ON t.order_date = d.date
GROUP BY m.markets_name, d.year
HAVING annual_sales > 135000
ORDER BY annual_sales DESC;

-- 12) Product Types With No Sales in 2022
SELECT DISTINCT product_type
FROM products
WHERE product_code NOT IN (
    SELECT DISTINCT t.product_code
    FROM transactions t
    JOIN date d ON t.order_date = d.date
    WHERE d.year = 2022
);
-- 13)Customers Ordering in Multiple Zones
SELECT c.customer_code, c.custmer_name, COUNT(DISTINCT m.zone) AS zone_count
FROM transactions t
JOIN customers c ON t.customer_code = c.customer_code
JOIN markets m ON t.market_code = m.markets_code
GROUP BY c.customer_code, c.custmer_name
HAVING zone_count > 2;

-- 14) Days With No Sales
SELECT d.date, d.month_name
FROM date d
LEFT JOIN transactions t ON d.date = t.order_date
WHERE t.order_date IS NULL;

-- 15) Find Duplicate Orders
SELECT customer_code, product_code, order_date, COUNT(*) AS order_count
FROM transactions
GROUP BY customer_code, product_code, order_date
HAVING order_count > 1;

-- 16)  Products Never Ordered
SELECT product_code, product_type
FROM products
WHERE product_code NOT IN (
    SELECT DISTINCT product_code FROM transactions
);

