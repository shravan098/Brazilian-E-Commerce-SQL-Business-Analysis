create database Brazilian_E_Commerce_Public_Dataset ;
use Brazilian_E_Commerce_Public_Dataset ;

SET GLOBAL local_infile = 1;
CREATE TABLE olist_orders (
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    order_status VARCHAR(20),
    order_purchase_timestamp DATETIME,
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME
);

LOAD DATA LOCAL INFILE 'C:\\Users\\shrav\\OneDrive\\Desktop\\olist_orders_dataset.csv'
INTO TABLE olist_orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE olist_customers (
    customer_id VARCHAR(50),
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(100),
    customer_state CHAR(2)
);

LOAD DATA LOCAL INFILE 'C:\\Users\\shrav\\OneDrive\\Desktop\\olist_customers_dataset.csv'
INTO TABLE olist_customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE olist_sellers (
    seller_id VARCHAR(50),
    seller_zip_code_prefix INT,
    seller_city VARCHAR(100),
    seller_state CHAR(2)
);

LOAD DATA LOCAL INFILE 'C:\\Users\\shrav\\OneDrive\\Desktop\\olist_sellers_dataset.csv'
INTO TABLE olist_sellers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


CREATE TABLE olist_products (
    product_id VARCHAR(50),
    product_category_name VARCHAR(100),
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);

LOAD DATA LOCAL INFILE 'C:\\Users\\shrav\\OneDrive\\Desktop\\olist_products_dataset.csv'
INTO TABLE olist_products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE olist_order_items (
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date DATETIME,
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2)
);

LOAD DATA LOCAL INFILE 'C:\\Users\\shrav\\OneDrive\\Desktop\\olist_order_items_dataset.csv'
INTO TABLE olist_order_items
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE olist_order_payments (
    order_id VARCHAR(50),
    payment_sequential INT,
    payment_type VARCHAR(30),
    payment_installments INT,
    payment_value DECIMAL(10,2)
);

LOAD DATA LOCAL INFILE 'C:\\Users\\shrav\\OneDrive\\Desktop\\olist_order_payments_dataset.csv'
INTO TABLE olist_order_payments
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE olist_order_reviews (
    review_id VARCHAR(50),
    order_id VARCHAR(50),
    review_score INT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date DATETIME,
    review_answer_timestamp DATETIME
);

LOAD DATA LOCAL INFILE 'C:\\Users\\shrav\\OneDrive\\Desktop\\olist_order_reviews_dataset.csv'
INTO TABLE olist_order_reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE olist_geolocation (
    geolocation_zip_code_prefix INT,
    geolocation_lat DECIMAL(10,7),
    geolocation_lng DECIMAL(10,7),
    geolocation_city VARCHAR(100),
    geolocation_state CHAR(2)
);

LOAD DATA LOCAL INFILE 'C:\\Users\\shrav\\OneDrive\\Desktop\\olist_geolocation_dataset.csv'
INTO TABLE olist_geolocation
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


SELECT COUNT(*) FROM olist_orders;
SELECT COUNT(*) FROM olist_customers;
SELECT COUNT(*) FROM olist_sellers;
SELECT COUNT(*) FROM olist_products;
SELECT COUNT(*) FROM olist_order_items;
SELECT COUNT(*) FROM olist_order_payments;
SELECT COUNT(*) FROM olist_order_reviews;
SELECT COUNT(*) FROM olist_geolocation;

-- Q1. Find the total number of orders.
SELECT COUNT(*) AS total_orders
FROM olist_orders;

-- Q2. Display all delivered orders.
SELECT *
FROM olist_orders
WHERE order_status = 'delivered';

-- Q3. Find the total number of cancelled orders.
SELECT COUNT(*) AS cancelled_orders
FROM olist_orders
WHERE order_status = 'canceled';

-- Q4. Display all unique order statuses.
SELECT DISTINCT order_status
FROM olist_orders;

-- Q5. Find the earliest and latest order purchase dates.
SELECT
    MIN(order_purchase_timestamp) AS first_order,
    MAX(order_purchase_timestamp) AS last_order
FROM olist_orders;

-- Q6. Count the number of orders for each order status.
SELECT
    order_status,
    COUNT(*) AS total_orders
FROM olist_orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- Q7. Find the total revenue generated.
SELECT
    ROUND(SUM(payment_value),2) AS total_revenue
FROM olist_order_payments;

-- Q8. Find the average payment value.
SELECT
    ROUND(AVG(payment_value),2) AS average_payment
FROM olist_order_payments;

-- Q9. Show the top 10 highest payment values.
SELECT
    order_id,
    payment_value
FROM olist_order_payments
ORDER BY payment_value DESC
LIMIT 10;

-- Q10. Count how many orders were paid using each payment type.
SELECT
    payment_type,
    COUNT(*) AS total_orders
FROM olist_order_payments
GROUP BY payment_type
ORDER BY total_orders DESC;

-- Q11. Find the total revenue generated by each payment type.
SELECT
    payment_type,
    ROUND(SUM(payment_value),2) AS total_revenue
FROM olist_order_payments
GROUP BY payment_type
ORDER BY total_revenue DESC;

-- Q12. Find the highest payment made.
SELECT
    MAX(payment_value) AS highest_payment
FROM olist_order_payments;

-- Q13. Find the lowest payment made.
SELECT
    MIN(payment_value) AS lowest_payment
FROM olist_order_payments;

-- Q14. Find the average payment value for each payment type.
SELECT
    payment_type,
    ROUND(AVG(payment_value),2) AS average_payment
FROM olist_order_payments
GROUP BY payment_type
ORDER BY average_payment DESC;

-- Q15. Count the number of customers in each state.
SELECT
    customer_state,
    COUNT(*) AS total_customers
FROM olist_customers
GROUP BY customer_state
ORDER BY total_customers DESC;

-- Q16. Display the top 10 cities having the highest number of customers.
SELECT
    customer_city,
    COUNT(*) AS total_customers
FROM olist_customers
GROUP BY customer_city
ORDER BY total_customers DESC
LIMIT 10;

-- Q17. Count the number of sellers in each state.
SELECT
    seller_state,
    COUNT(*) AS total_sellers
FROM olist_sellers
GROUP BY seller_state
ORDER BY total_sellers DESC;

-- Q18. Find the top 10 cities having the highest number of sellers.
SELECT
    seller_city,
    COUNT(*) AS total_sellers
FROM olist_sellers
GROUP BY seller_city
ORDER BY total_sellers DESC
LIMIT 10;

-- Q19. Find the total number of products available in each category.
SELECT
    product_category_name,
    COUNT(*) AS total_products
FROM olist_products
GROUP BY product_category_name
ORDER BY total_products DESC;

-- Q20. Find the top 10 product categories having the highest number of products.
SELECT
    product_category_name,
    COUNT(*) AS total_products
FROM olist_products
GROUP BY product_category_name
ORDER BY total_products DESC
LIMIT 10;

-- Q21. Find the total number of orders placed by each customer.
SELECT
    customer_id,
    COUNT(order_id) AS total_orders
FROM olist_orders
GROUP BY customer_id
ORDER BY total_orders DESC;

-- Q22. Find the top 10 customers who placed the most orders.
SELECT
    customer_id,
    COUNT(order_id) AS total_orders
FROM olist_orders
GROUP BY customer_id
ORDER BY total_orders DESC
LIMIT 10;

-- Q23. Find the total payment received from each order.
SELECT
    order_id,
    SUM(payment_value) AS total_payment
FROM olist_order_payments
GROUP BY order_id
ORDER BY total_payment DESC;

-- Q24. Find the top 10 orders with the highest payment amount.
SELECT
    order_id,
    SUM(payment_value) AS total_payment
FROM olist_order_payments
GROUP BY order_id
ORDER BY total_payment DESC
LIMIT 10;

-- Q25. Display each order along with its payment value.
SELECT
    o.order_id,
    o.order_status,
    p.payment_value
FROM olist_orders o
JOIN olist_order_payments p
ON o.order_id = p.order_id;

-- Q26. Find the total revenue generated from delivered orders only.
SELECT
    ROUND(SUM(p.payment_value),2) AS total_revenue
FROM olist_orders o
JOIN olist_order_payments p
ON o.order_id = p.order_id
WHERE o.order_status = 'delivered';

-- Q27. Find the total number of delivered orders in each customer state.
SELECT
    c.customer_state,
    COUNT(o.order_id) AS delivered_orders
FROM olist_orders o
JOIN olist_customers c
ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY delivered_orders DESC;

-- Q28. Find the total revenue generated by each customer state.
SELECT
    c.customer_state,
    ROUND(SUM(p.payment_value),2) AS total_revenue
FROM olist_orders o
JOIN olist_customers c
ON o.customer_id = c.customer_id
JOIN olist_order_payments p
ON o.order_id = p.order_id
GROUP BY c.customer_state
ORDER BY total_revenue DESC;

-- Q29. Find the top 10 states with the highest revenue.
SELECT
    c.customer_state,
    ROUND(SUM(p.payment_value),2) AS total_revenue
FROM olist_orders o
JOIN olist_customers c
ON o.customer_id = c.customer_id
JOIN olist_order_payments p
ON o.order_id = p.order_id
GROUP BY c.customer_state
ORDER BY total_revenue DESC
LIMIT 10;

-- Q30. Find the average payment value for each customer state.
SELECT
    c.customer_state,
    ROUND(AVG(p.payment_value),2) AS average_payment
FROM olist_orders o
JOIN olist_customers c
ON o.customer_id = c.customer_id
JOIN olist_order_payments p
ON o.order_id = p.order_id
GROUP BY c.customer_state
ORDER BY average_payment DESC;

-- Q31. Find the total number of products sold in each product category.
SELECT
    p.product_category_name,
    COUNT(oi.product_id) AS total_products_sold
FROM olist_order_items oi
JOIN olist_products p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_products_sold DESC;

-- Q32. Find the top 10 best-selling product categories.
SELECT
    p.product_category_name,
    COUNT(oi.product_id) AS total_products_sold
FROM olist_order_items oi
JOIN olist_products p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_products_sold DESC
LIMIT 10;

-- Q33. Find the total revenue generated by each product category.
SELECT
    p.product_category_name,
    ROUND(SUM(oi.price),2) AS total_revenue
FROM olist_order_items oi
JOIN olist_products p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC;

-- Q34. Find the top 10 highest revenue-generating product categories.
SELECT
    p.product_category_name,
    ROUND(SUM(oi.price),2) AS total_revenue
FROM olist_order_items oi
JOIN olist_products p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC
LIMIT 10;

-- Q35. Find the average product price for each category.
SELECT
    p.product_category_name,
    ROUND(AVG(oi.price),2) AS average_price
FROM olist_order_items oi
JOIN olist_products p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY average_price DESC;

-- Q36. Find the top 10 most expensive products sold.
SELECT
    product_id,
    price
FROM olist_order_items
ORDER BY price DESC
LIMIT 10;

-- Q37. Find the total freight value collected by each seller.
SELECT
    seller_id,
    ROUND(SUM(freight_value),2) AS total_freight
FROM olist_order_items
GROUP BY seller_id
ORDER BY total_freight DESC;

-- Q38. Find the top 10 sellers with the highest sales revenue.
SELECT
    seller_id,
    ROUND(SUM(price),2) AS total_revenue
FROM olist_order_items
GROUP BY seller_id
ORDER BY total_revenue DESC
LIMIT 10;

-- Q39. Find the average freight charge for each seller.
SELECT
    seller_id,
    ROUND(AVG(freight_value),2) AS average_freight
FROM olist_order_items
GROUP BY seller_id
ORDER BY average_freight DESC;

-- Q40. Find the total number of products sold by each seller.
SELECT
    seller_id,
    COUNT(product_id) AS total_products_sold
FROM olist_order_items
GROUP BY seller_id
ORDER BY total_products_sold DESC;

-- Q41. Find the total number of reviews for each review score.
SELECT
    review_score,
    COUNT(*) AS total_reviews
FROM olist_order_reviews
GROUP BY review_score
ORDER BY review_score DESC;

-- Q42. Find the average review score.
SELECT
    ROUND(AVG(review_score),2) AS average_review_score
FROM olist_order_reviews;

-- Q43. Find the total number of 5-star reviews.
SELECT
    COUNT(*) AS five_star_reviews
FROM olist_order_reviews
WHERE review_score = 5;

-- Q44. Find the total number of 1-star reviews.
SELECT
    COUNT(*) AS one_star_reviews
FROM olist_order_reviews
WHERE review_score = 1;

-- Q45. Find the average review score for each product category.
SELECT
    p.product_category_name,
    ROUND(AVG(r.review_score),2) AS average_review_score
FROM olist_order_reviews r
JOIN olist_order_items oi
ON r.order_id = oi.order_id
JOIN olist_products p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY average_review_score DESC;

-- Q46. Find the top 10 highest-rated product categories.
SELECT
    p.product_category_name,
    ROUND(AVG(r.review_score),2) AS average_review_score
FROM olist_order_reviews r
JOIN olist_order_items oi
ON r.order_id = oi.order_id
JOIN olist_products p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY average_review_score DESC
LIMIT 10;

-- Q47. Find the bottom 10 lowest-rated product categories.
SELECT
    p.product_category_name,
    ROUND(AVG(r.review_score),2) AS average_review_score
FROM olist_order_reviews r
JOIN olist_order_items oi
ON r.order_id = oi.order_id
JOIN olist_products p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY average_review_score ASC
LIMIT 10;

-- Q48. Find the total number of orders handled by each seller.
SELECT
    seller_id,
    COUNT(DISTINCT order_id) AS total_orders
FROM olist_order_items
GROUP BY seller_id
ORDER BY total_orders DESC;

-- Q49. Find the top 10 sellers with the highest number of orders.
SELECT
    seller_id,
    COUNT(DISTINCT order_id) AS total_orders
FROM olist_order_items
GROUP BY seller_id
ORDER BY total_orders DESC
LIMIT 10;

-- Q50. Find the total revenue generated by each seller.
SELECT
    seller_id,
    ROUND(SUM(price),2) AS total_revenue
FROM olist_order_items
GROUP BY seller_id
ORDER BY total_revenue DESC;

-- Q51. Find the total revenue generated in each month.
SELECT
    YEAR(o.order_purchase_timestamp) AS year,
    MONTH(o.order_purchase_timestamp) AS month,
    ROUND(SUM(p.payment_value),2) AS total_revenue
FROM olist_orders o
JOIN olist_order_payments p
ON o.order_id = p.order_id
GROUP BY YEAR(o.order_purchase_timestamp), MONTH(o.order_purchase_timestamp)
ORDER BY year, month;

-- Q52. Find the total number of orders placed in each month.
SELECT
    YEAR(order_purchase_timestamp) AS year,
    MONTH(order_purchase_timestamp) AS month,
    COUNT(*) AS total_orders
FROM olist_orders
GROUP BY YEAR(order_purchase_timestamp), MONTH(order_purchase_timestamp)
ORDER BY year, month;

-- Q53. Find the average payment value for each month.
SELECT
    YEAR(o.order_purchase_timestamp) AS year,
    MONTH(o.order_purchase_timestamp) AS month,
    ROUND(AVG(p.payment_value),2) AS average_payment
FROM olist_orders o
JOIN olist_order_payments p
ON o.order_id = p.order_id
GROUP BY YEAR(o.order_purchase_timestamp), MONTH(o.order_purchase_timestamp)
ORDER BY year, month;

-- Q54. Find the total revenue generated in each year.
SELECT
    YEAR(o.order_purchase_timestamp) AS year,
    ROUND(SUM(p.payment_value),2) AS total_revenue
FROM olist_orders o
JOIN olist_order_payments p
ON o.order_id = p.order_id
GROUP BY YEAR(o.order_purchase_timestamp)
ORDER BY year;

-- Q55. Find the total number of orders placed in each year.
SELECT
    YEAR(order_purchase_timestamp) AS year,
    COUNT(*) AS total_orders
FROM olist_orders
GROUP BY YEAR(order_purchase_timestamp)
ORDER BY year;

-- Q56. Find the top 10 customers who spent the most money.
SELECT
    o.customer_id,
    ROUND(SUM(p.payment_value),2) AS total_spent
FROM olist_orders o
JOIN olist_order_payments p
ON o.order_id = p.order_id
GROUP BY o.customer_id
ORDER BY total_spent DESC
LIMIT 10;

-- Q57. Find the average amount spent by customers in each state.
SELECT
    c.customer_state,
    ROUND(AVG(p.payment_value),2) AS average_spent
FROM olist_customers c
JOIN olist_orders o
ON c.customer_id = o.customer_id
JOIN olist_order_payments p
ON o.order_id = p.order_id
GROUP BY c.customer_state
ORDER BY average_spent DESC;

-- Q58. Find the total revenue generated by each seller.
SELECT
    seller_id,
    ROUND(SUM(price),2) AS total_revenue
FROM olist_order_items
GROUP BY seller_id
ORDER BY total_revenue DESC;

-- Q59. Find the average product price for each seller.
SELECT
    seller_id,
    ROUND(AVG(price),2) AS average_price
FROM olist_order_items
GROUP BY seller_id
ORDER BY average_price DESC;

-- Q60. Find the top 10 orders having the highest number of products.
SELECT
    order_id,
    COUNT(product_id) AS total_products
FROM olist_order_items
GROUP BY order_id
ORDER BY total_products DESC
LIMIT 10;

-- Q61. Find the top 10 product categories generating the highest revenue.
SELECT
    p.product_category_name,
    ROUND(SUM(oi.price),2) AS total_revenue
FROM olist_order_items oi
JOIN olist_products p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC
LIMIT 10;

-- Q62. Find the top 10 cities generating the highest revenue.
SELECT
    c.customer_city,
    ROUND(SUM(op.payment_value),2) AS total_revenue
FROM olist_customers c
JOIN olist_orders o
ON c.customer_id = o.customer_id
JOIN olist_order_payments op
ON o.order_id = op.order_id
GROUP BY c.customer_city
ORDER BY total_revenue DESC
LIMIT 10;

-- Q63. Find the top 10 customers who purchased the highest number of products.
SELECT
    o.customer_id,
    COUNT(oi.product_id) AS total_products
FROM olist_orders o
JOIN olist_order_items oi
ON o.order_id = oi.order_id
GROUP BY o.customer_id
ORDER BY total_products DESC
LIMIT 10;

-- Q64. Find the total number of products sold by each product category.
SELECT
    p.product_category_name,
    COUNT(*) AS total_products_sold
FROM olist_order_items oi
JOIN olist_products p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_products_sold DESC;

-- Q65. Find the average freight charge for each product category.
SELECT
    p.product_category_name,
    ROUND(AVG(oi.freight_value),2) AS average_freight
FROM olist_order_items oi
JOIN olist_products p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY average_freight DESC;

-- Q66. Find the top 10 sellers who sold the highest number of products.
SELECT
    seller_id,
    COUNT(product_id) AS total_products_sold
FROM olist_order_items
GROUP BY seller_id
ORDER BY total_products_sold DESC
LIMIT 10;

-- Q67. Find the average number of payment installments for each payment type.
SELECT
    payment_type,
    ROUND(AVG(payment_installments),2) AS average_installments
FROM olist_order_payments
GROUP BY payment_type
ORDER BY average_installments DESC;

-- Q68. Find the total payment received through each payment type.
SELECT
    payment_type,
    ROUND(SUM(payment_value),2) AS total_payment
FROM olist_order_payments
GROUP BY payment_type
ORDER BY total_payment DESC;

-- Q69. Find the total number of orders for each review score.
SELECT
    review_score,
    COUNT(*) AS total_orders
FROM olist_order_reviews
GROUP BY review_score
ORDER BY review_score DESC;

-- Q70. Find the average payment value for each review score.
SELECT
    r.review_score,
    ROUND(AVG(p.payment_value),2) AS average_payment
FROM olist_order_reviews r
JOIN olist_order_payments p
ON r.order_id = p.order_id
GROUP BY r.review_score
ORDER BY r.review_score DESC;

-- Q71. Find the monthly revenue for delivered orders only.
SELECT
    YEAR(o.order_purchase_timestamp) AS year,
    MONTH(o.order_purchase_timestamp) AS month,
    ROUND(SUM(p.payment_value),2) AS total_revenue
FROM olist_orders o
JOIN olist_order_payments p
ON o.order_id = p.order_id
WHERE o.order_status = 'delivered'
GROUP BY YEAR(o.order_purchase_timestamp), MONTH(o.order_purchase_timestamp)
ORDER BY year, month;

-- Q72. Find the monthly order count for delivered orders only.
SELECT
    YEAR(order_purchase_timestamp) AS year,
    MONTH(order_purchase_timestamp) AS month,
    COUNT(*) AS total_orders
FROM olist_orders
WHERE order_status = 'delivered'
GROUP BY YEAR(order_purchase_timestamp), MONTH(order_purchase_timestamp)
ORDER BY year, month;

-- Q73. Find the top 10 customers who spent the most on delivered orders.
SELECT
    o.customer_id,
    ROUND(SUM(p.payment_value),2) AS total_spent
FROM olist_orders o
JOIN olist_order_payments p
ON o.order_id = p.order_id
WHERE o.order_status = 'delivered'
GROUP BY o.customer_id
ORDER BY total_spent DESC
LIMIT 10;

-- Q74. Find the revenue generated by each customer state from delivered orders.
SELECT
    c.customer_state,
    ROUND(SUM(p.payment_value),2) AS total_revenue
FROM olist_customers c
JOIN olist_orders o
ON c.customer_id = o.customer_id
JOIN olist_order_payments p
ON o.order_id = p.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY total_revenue DESC;

-- Q75. Find the top 10 product categories by revenue from delivered orders.
SELECT
    pr.product_category_name,
    ROUND(SUM(oi.price),2) AS total_revenue
FROM olist_orders o
JOIN olist_order_items oi
ON o.order_id = oi.order_id
JOIN olist_products pr
ON oi.product_id = pr.product_id
WHERE o.order_status = 'delivered'
GROUP BY pr.product_category_name
ORDER BY total_revenue DESC
LIMIT 10;

-- Q76. Find the average order value for each customer state.
SELECT
    c.customer_state,
    ROUND(AVG(p.payment_value),2) AS average_order_value
FROM olist_customers c
JOIN olist_orders o
ON c.customer_id = o.customer_id
JOIN olist_order_payments p
ON o.order_id = p.order_id
GROUP BY c.customer_state
ORDER BY average_order_value DESC;

-- Q77. Find the top 10 orders with the highest freight charges.
SELECT
    order_id,
    ROUND(SUM(freight_value),2) AS total_freight
FROM olist_order_items
GROUP BY order_id
ORDER BY total_freight DESC
LIMIT 10;

-- Q78. Find the average freight charge for each seller.
SELECT
    seller_id,
    ROUND(AVG(freight_value),2) AS average_freight
FROM olist_order_items
GROUP BY seller_id
ORDER BY average_freight DESC;

-- Q79. Find the top 10 customers who purchased the most distinct products.
SELECT
    o.customer_id,
    COUNT(DISTINCT oi.product_id) AS distinct_products
FROM olist_orders o
JOIN olist_order_items oi
ON o.order_id = oi.order_id
GROUP BY o.customer_id
ORDER BY distinct_products DESC
LIMIT 10;

-- Q80. Find the total revenue generated by each review score.
SELECT
    r.review_score,
    ROUND(SUM(p.payment_value),2) AS total_revenue
FROM olist_order_reviews r
JOIN olist_order_payments p
ON r.order_id = p.order_id
GROUP BY r.review_score
ORDER BY total_revenue DESC;

-- Q81. The CEO wants to know the top 10 states contributing the highest revenue.
SELECT
    c.customer_state,
    ROUND(SUM(p.payment_value),2) AS total_revenue
FROM olist_customers c
JOIN olist_orders o
ON c.customer_id = o.customer_id
JOIN olist_order_payments p
ON o.order_id = p.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY total_revenue DESC
LIMIT 10;

-- Q82. Which product categories generated the lowest revenue? (Bottom 10)
SELECT
    pr.product_category_name,
    ROUND(SUM(oi.price),2) AS total_revenue
FROM olist_products pr
JOIN olist_order_items oi
ON pr.product_id = oi.product_id
GROUP BY pr.product_category_name
ORDER BY total_revenue ASC
LIMIT 10;

-- Q83. Which sellers generated the highest revenue?
SELECT
    seller_id,
    ROUND(SUM(price),2) AS total_revenue
FROM olist_order_items
GROUP BY seller_id
ORDER BY total_revenue DESC
LIMIT 10;

-- Q84. Which cities placed the highest number of orders?
SELECT
    c.customer_city,
    COUNT(o.order_id) AS total_orders
FROM olist_customers c
JOIN olist_orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_city
ORDER BY total_orders DESC
LIMIT 10;

-- Q85. Which payment method generated the highest revenue?
SELECT
    payment_type,
    ROUND(SUM(payment_value),2) AS total_revenue
FROM olist_order_payments
GROUP BY payment_type
ORDER BY total_revenue DESC;

-- Q86. Which product categories have the highest average customer rating?
SELECT
    p.product_category_name,
    ROUND(AVG(r.review_score),2) AS avg_rating
FROM olist_products p
JOIN olist_order_items oi
ON p.product_id = oi.product_id
JOIN olist_order_reviews r
ON oi.order_id = r.order_id
GROUP BY p.product_category_name
HAVING COUNT(*) >= 30
ORDER BY avg_rating DESC
LIMIT 10;

-- Q87. Which product categories have the worst customer ratings?
SELECT
    p.product_category_name,
    ROUND(AVG(r.review_score),2) AS avg_rating
FROM olist_products p
JOIN olist_order_items oi
ON p.product_id = oi.product_id
JOIN olist_order_reviews r
ON oi.order_id = r.order_id
GROUP BY p.product_category_name
HAVING COUNT(*) >= 30
ORDER BY avg_rating ASC
LIMIT 10;

-- Q88. Which states have the highest number of cancelled orders?
SELECT
    c.customer_state,
    COUNT(*) AS cancelled_orders
FROM olist_customers c
JOIN olist_orders o
ON c.customer_id = o.customer_id
WHERE o.order_status='canceled'
GROUP BY c.customer_state
ORDER BY cancelled_orders DESC;

-- Q89. Which customers are our highest-value customers?
SELECT
    o.customer_id,
    ROUND(SUM(p.payment_value),2) AS lifetime_value
FROM olist_orders o
JOIN olist_order_payments p
ON o.order_id=p.order_id
GROUP BY o.customer_id
ORDER BY lifetime_value DESC
LIMIT 10;

-- Q90. Which months generated the highest revenue?
SELECT
    YEAR(o.order_purchase_timestamp) AS year,
    MONTHNAME(o.order_purchase_timestamp) AS month,
    ROUND(SUM(p.payment_value),2) AS revenue
FROM olist_orders o
JOIN olist_order_payments p
ON o.order_id=p.order_id
WHERE o.order_status='delivered'
GROUP BY YEAR(o.order_purchase_timestamp),
MONTH(o.order_purchase_timestamp),
MONTHNAME(o.order_purchase_timestamp)
ORDER BY revenue DESC;

-- Q91. The Sales Director wants to identify the Top 10 cities by Average Order Value (AOV).
SELECT
    c.customer_city,
    ROUND(AVG(p.payment_value),2) AS average_order_value
FROM olist_customers c
JOIN olist_orders o
ON c.customer_id = o.customer_id
JOIN olist_order_payments p
ON o.order_id = p.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_city
HAVING COUNT(DISTINCT o.order_id) >= 20
ORDER BY average_order_value DESC
LIMIT 10;

-- Q92. Which product categories generate the highest freight cost?
SELECT
    p.product_category_name,
    ROUND(SUM(oi.freight_value),2) AS total_freight_cost
FROM olist_products p
JOIN olist_order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_category_name
ORDER BY total_freight_cost DESC
LIMIT 10;

-- Q93. Which sellers charge the highest average freight?
SELECT
    seller_id,
    ROUND(AVG(freight_value),2) AS average_freight
FROM olist_order_items
GROUP BY seller_id
HAVING COUNT(order_id) >= 20
ORDER BY average_freight DESC
LIMIT 10;

-- Q94. Which months had the highest number of cancelled orders?
SELECT
    YEAR(order_purchase_timestamp) AS year,
    MONTHNAME(order_purchase_timestamp) AS month,
    COUNT(*) AS cancelled_orders
FROM olist_orders
WHERE order_status = 'canceled'
GROUP BY YEAR(order_purchase_timestamp),
MONTH(order_purchase_timestamp),
MONTHNAME(order_purchase_timestamp)
ORDER BY cancelled_orders DESC;

-- Q95. Which states have the highest average customer review score?
SELECT
    c.customer_state,
    ROUND(AVG(r.review_score),2) AS average_rating
FROM olist_customers c
JOIN olist_orders o
ON c.customer_id = o.customer_id
JOIN olist_order_reviews r
ON o.order_id = r.order_id
GROUP BY c.customer_state
HAVING COUNT(r.review_id) >= 30
ORDER BY average_rating DESC;

-- Q96. Which states have the lowest average customer review score?
SELECT
    c.customer_state,
    ROUND(AVG(r.review_score),2) AS average_rating
FROM olist_customers c
JOIN olist_orders o
ON c.customer_id = o.customer_id
JOIN olist_order_reviews r
ON o.order_id = r.order_id
GROUP BY c.customer_state
HAVING COUNT(r.review_id) >= 30
ORDER BY average_rating ASC;

-- Q97. Which product categories have the highest Average Order Value?
SELECT
    p.product_category_name,
    ROUND(AVG(oi.price),2) AS average_order_value
FROM olist_products p
JOIN olist_order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_category_name
HAVING COUNT(*) >= 20
ORDER BY average_order_value DESC
LIMIT 10;

-- Q98. Which sellers have sold products in the highest number of unique orders?
SELECT
    seller_id,
    COUNT(DISTINCT order_id) AS unique_orders
FROM olist_order_items
GROUP BY seller_id
ORDER BY unique_orders DESC
LIMIT 10;

-- Q99. Which customer states generated the highest number of delivered orders?
SELECT
    c.customer_state,
    COUNT(*) AS delivered_orders
FROM olist_customers c
JOIN olist_orders o
ON c.customer_id = o.customer_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY delivered_orders DESC;

-- Q100. Build an Executive KPI Dashboard showing Total Revenue, Total Orders, Total Customers, Average Order Value and Average Review Score.
SELECT
    ROUND(SUM(p.payment_value),2) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS total_customers,
    ROUND(SUM(p.payment_value)/COUNT(DISTINCT o.order_id),2) AS average_order_value,
    ROUND(AVG(r.review_score),2) AS average_review_score
FROM olist_orders o
JOIN olist_order_payments p
ON o.order_id = p.order_id
LEFT JOIN olist_order_reviews r
ON o.order_id = r.order_id
WHERE o.order_status = 'delivered';
#Case Study 1: Revenue Drop Analysis (10 queries)
-- Q101. Compare monthly revenue to identify whether revenue actually dropped.
SELECT
    YEAR(o.order_purchase_timestamp) AS year,
    MONTHNAME(o.order_purchase_timestamp) AS month,
    ROUND(SUM(p.payment_value),2) AS revenue
FROM olist_orders o
JOIN olist_order_payments p
ON o.order_id = p.order_id
WHERE o.order_status = 'delivered'
GROUP BY YEAR(o.order_purchase_timestamp),
MONTH(o.order_purchase_timestamp),
MONTHNAME(o.order_purchase_timestamp)
ORDER BY YEAR(o.order_purchase_timestamp),
MONTH(o.order_purchase_timestamp);

-- Q102. Compare monthly order volume.
SELECT
    YEAR(order_purchase_timestamp) AS year,
    MONTHNAME(order_purchase_timestamp) AS month,
    COUNT(*) AS total_orders
FROM olist_orders
WHERE order_status = 'delivered'
GROUP BY YEAR(order_purchase_timestamp),
MONTH(order_purchase_timestamp),
MONTHNAME(order_purchase_timestamp)
ORDER BY YEAR(order_purchase_timestamp),
MONTH(order_purchase_timestamp);

-- Q103. Compare Average Order Value (AOV) month by month.
SELECT
    YEAR(o.order_purchase_timestamp) AS year,
    MONTHNAME(o.order_purchase_timestamp) AS month,
    ROUND(SUM(p.payment_value)/COUNT(DISTINCT o.order_id),2) AS average_order_value
FROM olist_orders o
JOIN olist_order_payments p
ON o.order_id = p.order_id
WHERE o.order_status='delivered'
GROUP BY YEAR(o.order_purchase_timestamp),
MONTH(o.order_purchase_timestamp),
MONTHNAME(o.order_purchase_timestamp)
ORDER BY YEAR(o.order_purchase_timestamp),
MONTH(o.order_purchase_timestamp);

-- Q104. Find which product categories generated the most revenue.
SELECT
    pr.product_category_name,
    ROUND(SUM(oi.price),2) AS revenue
FROM olist_orders o
JOIN olist_order_items oi
ON o.order_id=oi.order_id
JOIN olist_products pr
ON oi.product_id=pr.product_id
WHERE o.order_status='delivered'
GROUP BY pr.product_category_name
ORDER BY revenue DESC;

-- Q105. Find which customer states generated the highest revenue.
SELECT
    c.customer_state,
    ROUND(SUM(p.payment_value),2) AS revenue
FROM olist_customers c
JOIN olist_orders o
ON c.customer_id=o.customer_id
JOIN olist_order_payments p
ON o.order_id=p.order_id
WHERE o.order_status='delivered'
GROUP BY c.customer_state
ORDER BY revenue DESC;

-- Q106. Find which payment methods contributed the most revenue.
SELECT
    payment_type,
    ROUND(SUM(payment_value),2) AS revenue
FROM olist_order_payments
GROUP BY payment_type
ORDER BY revenue DESC;

-- Q107. Find the Top 10 customers by lifetime revenue.
SELECT
    o.customer_id,
    ROUND(SUM(p.payment_value),2) AS total_spent
FROM olist_orders o
JOIN olist_order_payments p
ON o.order_id=p.order_id
WHERE o.order_status='delivered'
GROUP BY o.customer_id
ORDER BY total_spent DESC
LIMIT 10;

-- Q108. Find the Bottom 10 product categories by revenue.
SELECT
    pr.product_category_name,
    ROUND(SUM(oi.price),2) AS revenue
FROM olist_products pr
JOIN olist_order_items oi
ON pr.product_id=oi.product_id
GROUP BY pr.product_category_name
ORDER BY revenue ASC
LIMIT 10;

-- Q109. Compare delivered vs cancelled orders.
SELECT
    order_status,
    COUNT(*) AS total_orders
FROM olist_orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- Q110. Executive Summary Dashboard.
SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS total_customers,
    ROUND(SUM(p.payment_value),2) AS total_revenue,
    ROUND(AVG(p.payment_value),2) AS average_payment,
    ROUND(AVG(r.review_score),2) AS average_review
FROM olist_orders o
JOIN olist_order_payments p
ON o.order_id=p.order_id
LEFT JOIN olist_order_reviews r
ON o.order_id=r.order_id
WHERE o.order_status='delivered';

-- Q111. Find customers who placed only one order.

SELECT
    customer_id,
    COUNT(order_id) AS total_orders
FROM olist_orders
GROUP BY customer_id
HAVING COUNT(order_id) = 1;

-- Q112. Find customers who placed more than one order.

SELECT
    customer_id,
    COUNT(order_id) AS total_orders
FROM olist_orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1
ORDER BY total_orders DESC;

-- Q113. Find the Top 10 repeat customers.

SELECT
    customer_id,
    COUNT(order_id) AS total_orders
FROM olist_orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1
ORDER BY total_orders DESC
LIMIT 10;

-- Q114. Calculate the Repeat Customer Rate.

SELECT
ROUND(
(
COUNT(DISTINCT CASE WHEN total_orders > 1 THEN customer_id END)
/
COUNT(DISTINCT customer_id)
)*100,2) AS repeat_customer_rate
FROM
(
SELECT
customer_id,
COUNT(order_id) AS total_orders
FROM olist_orders
GROUP BY customer_id
) t;

-- Q115. Find the states having the highest number of repeat customers.

SELECT
    c.customer_state,
    COUNT(*) AS repeat_customers
FROM
(
SELECT customer_id
FROM olist_orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1
) rc
JOIN olist_customers c
ON rc.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY repeat_customers DESC;

-- Q116. Find revenue generated by repeat customers.

SELECT
    ROUND(SUM(p.payment_value),2) AS repeat_customer_revenue
FROM
(
SELECT customer_id
FROM olist_orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1
) rc
JOIN olist_orders o
ON rc.customer_id = o.customer_id
JOIN olist_order_payments p
ON o.order_id = p.order_id;

-- Q117. Find revenue generated by one-time customers.

SELECT
    ROUND(SUM(p.payment_value),2) AS one_time_customer_revenue
FROM
(
SELECT customer_id
FROM olist_orders
GROUP BY customer_id
HAVING COUNT(order_id) = 1
) oc
JOIN olist_orders o
ON oc.customer_id = o.customer_id
JOIN olist_order_payments p
ON o.order_id = p.order_id;

-- Q118. Find the average spending of repeat customers.

SELECT
    ROUND(AVG(customer_spending),2) AS average_spending
FROM
(
SELECT
o.customer_id,
SUM(p.payment_value) AS customer_spending
FROM olist_orders o
JOIN olist_order_payments p
ON o.order_id=p.order_id
GROUP BY o.customer_id
HAVING COUNT(o.order_id)>1
) t;

-- Q119. Find the Top 10 customers with the highest lifetime value.

SELECT
    o.customer_id,
    ROUND(SUM(p.payment_value),2) AS lifetime_value
FROM olist_orders o
JOIN olist_order_payments p
ON o.order_id=p.order_id
GROUP BY o.customer_id
ORDER BY lifetime_value DESC
LIMIT 10;

-- Q120. Identify the states with the highest customer churn

SELECT
    c.customer_state,
    COUNT(*) AS churned_customers
FROM
(
SELECT customer_id
FROM olist_orders
GROUP BY customer_id
HAVING COUNT(order_id)=1
) ch
JOIN olist_customers c
ON ch.customer_id=c.customer_id
GROUP BY c.customer_state
ORDER BY churned_customers DESC;


-- Q121. Calculate the average delivery time (in days) for delivered orders.

SELECT
ROUND(AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)),2) AS avg_delivery_days
FROM olist_orders
WHERE order_status='delivered';

-- Q122. Find the Top 10 orders with the longest delivery time.

SELECT
order_id,
DATEDIFF(order_delivered_customer_date, order_purchase_timestamp) AS delivery_days
FROM olist_orders
WHERE order_status='delivered'
ORDER BY delivery_days DESC
LIMIT 10;

-- Q123. Find the average delivery time for each customer state.

SELECT
c.customer_state,
ROUND(AVG(DATEDIFF(o.order_delivered_customer_date,o.order_purchase_timestamp)),2) AS avg_delivery_days
FROM olist_orders o
JOIN olist_customers c
ON o.customer_id=c.customer_id
WHERE o.order_status='delivered'
GROUP BY c.customer_state
ORDER BY avg_delivery_days DESC;

-- Q124. Find the Top 10 states with the slowest deliveries.

SELECT
c.customer_state,
ROUND(AVG(DATEDIFF(o.order_delivered_customer_date,o.order_purchase_timestamp)),2) AS avg_delivery_days
FROM olist_orders o
JOIN olist_customers c
ON o.customer_id=c.customer_id
WHERE o.order_status='delivered'
GROUP BY c.customer_state
ORDER BY avg_delivery_days DESC
LIMIT 10;

-- Q125. Find the Top 10 product categories with the longest average delivery time.

SELECT
p.product_category_name,
ROUND(AVG(DATEDIFF(o.order_delivered_customer_date,o.order_purchase_timestamp)),2) AS avg_delivery_days
FROM olist_orders o
JOIN olist_order_items oi
ON o.order_id=oi.order_id
JOIN olist_products p
ON oi.product_id=p.product_id
WHERE o.order_status='delivered'
GROUP BY p.product_category_name
ORDER BY avg_delivery_days DESC
LIMIT 10;

-- Q126. Count how many orders were delivered later than the estimated delivery date.

SELECT
COUNT(*) AS late_deliveries
FROM olist_orders
WHERE order_status='delivered'
AND order_delivered_customer_date > order_estimated_delivery_date;

-- Q127. Count how many orders were delivered on or before the estimated delivery date.

SELECT
COUNT(*) AS on_time_deliveries
FROM olist_orders
WHERE order_status='delivered'
AND order_delivered_customer_date <= order_estimated_delivery_date;

-- Q128. Calculate the on-time delivery percentage.

SELECT
ROUND(
SUM(CASE
WHEN order_delivered_customer_date<=order_estimated_delivery_date
THEN 1 ELSE 0 END)
*100.0/COUNT(*),2) AS on_time_percentage
FROM olist_orders
WHERE order_status='delivered';

-- Q129. Find the states with the highest number of late deliveries.

SELECT
c.customer_state,
COUNT(*) AS late_orders
FROM olist_orders o
JOIN olist_customers c
ON o.customer_id=c.customer_id
WHERE o.order_status='delivered'
AND o.order_delivered_customer_date>o.order_estimated_delivery_date
GROUP BY c.customer_state
ORDER BY late_orders DESC;

-- Q130. Find the average delay (in days) for late deliveries by state.

SELECT
c.customer_state,
ROUND(AVG(DATEDIFF(o.order_delivered_customer_date,o.order_estimated_delivery_date)),2) AS avg_delay_days
FROM olist_orders o
JOIN olist_customers c
ON o.customer_id=c.customer_id
WHERE o.order_status='delivered'
AND o.order_delivered_customer_date>o.order_estimated_delivery_date
GROUP BY c.customer_state
ORDER BY avg_delay_days DESC;

-- Q131. Find the average customer review score.

SELECT
ROUND(AVG(review_score),2) AS average_review_score
FROM olist_order_reviews;

-- Q132. Count the number of reviews for each review score.

SELECT
review_score,
COUNT(*) AS total_reviews
FROM olist_order_reviews
GROUP BY review_score
ORDER BY review_score DESC;

-- Q133. Find the Top 10 product categories with the highest average review score.

SELECT
p.product_category_name,
ROUND(AVG(r.review_score),2) AS average_rating
FROM olist_products p
JOIN olist_order_items oi
ON p.product_id = oi.product_id
JOIN olist_order_reviews r
ON oi.order_id = r.order_id
GROUP BY p.product_category_name
HAVING COUNT(*) >= 30
ORDER BY average_rating DESC
LIMIT 10;

-- Q134. Find the Bottom 10 product categories with the lowest average review score.

SELECT
p.product_category_name,
ROUND(AVG(r.review_score),2) AS average_rating
FROM olist_products p
JOIN olist_order_items oi
ON p.product_id = oi.product_id
JOIN olist_order_reviews r
ON oi.order_id = r.order_id
GROUP BY p.product_category_name
HAVING COUNT(*) >= 30
ORDER BY average_rating ASC
LIMIT 10;

-- Q135. Find the average review score for each customer state.

SELECT
c.customer_state,
ROUND(AVG(r.review_score),2) AS average_rating
FROM olist_customers c
JOIN olist_orders o
ON c.customer_id = o.customer_id
JOIN olist_order_reviews r
ON o.order_id = r.order_id
GROUP BY c.customer_state
ORDER BY average_rating DESC;

-- Q136. Find the Top 10 sellers with the highest average customer rating.

SELECT
oi.seller_id,
ROUND(AVG(r.review_score),2) AS average_rating
FROM olist_order_items oi
JOIN olist_order_reviews r
ON oi.order_id = r.order_id
GROUP BY oi.seller_id
HAVING COUNT(*) >= 20
ORDER BY average_rating DESC
LIMIT 10;

-- Q137. Find the Bottom 10 sellers with the lowest average customer rating.

SELECT
oi.seller_id,
ROUND(AVG(r.review_score),2) AS average_rating
FROM olist_order_items oi
JOIN olist_order_reviews r
ON oi.order_id = r.order_id
GROUP BY oi.seller_id
HAVING COUNT(*) >= 20
ORDER BY average_rating ASC
LIMIT 10;

-- Q138. Compare average delivery time for each review score.

SELECT
r.review_score,
ROUND(AVG(DATEDIFF(o.order_delivered_customer_date,o.order_purchase_timestamp)),2) AS average_delivery_days
FROM olist_orders o
JOIN olist_order_reviews r
ON o.order_id = r.order_id
WHERE o.order_status='delivered'
GROUP BY r.review_score
ORDER BY r.review_score DESC;

-- Q139. Count how many 1-star reviews each product category received.

SELECT
p.product_category_name,
COUNT(*) AS one_star_reviews
FROM olist_products p
JOIN olist_order_items oi
ON p.product_id = oi.product_id
JOIN olist_order_reviews r
ON oi.order_id = r.order_id
WHERE r.review_score = 1
GROUP BY p.product_category_name
ORDER BY one_star_reviews DESC
LIMIT 10;

-- Q140. Find product categories where the average review score is below 3.

SELECT
p.product_category_name,
ROUND(AVG(r.review_score),2) AS average_rating
FROM olist_products p
JOIN olist_order_items oi
ON p.product_id = oi.product_id
JOIN olist_order_reviews r
ON oi.order_id = r.order_id
GROUP BY p.product_category_name
HAVING AVG(r.review_score) < 3
ORDER BY average_rating ASC;

-- Q141. Find the Top 10 sellers by total revenue.

SELECT
seller_id,
ROUND(SUM(price),2) AS total_revenue
FROM olist_order_items
GROUP BY seller_id
ORDER BY total_revenue DESC
LIMIT 10;

-- Q142. Find the Top 10 sellers by total orders.

SELECT
seller_id,
COUNT(DISTINCT order_id) AS total_orders
FROM olist_order_items
GROUP BY seller_id
ORDER BY total_orders DESC
LIMIT 10;

-- Q143. Find the average order value for each seller.

SELECT
seller_id,
ROUND(AVG(price),2) AS average_order_value
FROM olist_order_items
GROUP BY seller_id
ORDER BY average_order_value DESC;

-- Q144. Find the Top 10 sellers by total products sold.

SELECT
seller_id,
COUNT(product_id) AS total_products_sold
FROM olist_order_items
GROUP BY seller_id
ORDER BY total_products_sold DESC
LIMIT 10;

-- Q145. Find the average freight charged by each seller.

SELECT
seller_id,
ROUND(AVG(freight_value),2) AS average_freight
FROM olist_order_items
GROUP BY seller_id
ORDER BY average_freight DESC;

-- Q146. Find the Top 10 sellers with the highest average review score.

SELECT
oi.seller_id,
ROUND(AVG(r.review_score),2) AS average_rating
FROM olist_order_items oi
JOIN olist_order_reviews r
ON oi.order_id = r.order_id
GROUP BY oi.seller_id
HAVING COUNT(*) >= 20
ORDER BY average_rating DESC
LIMIT 10;

-- Q147. Find the Bottom 10 sellers with the lowest average review score.

SELECT
oi.seller_id,
ROUND(AVG(r.review_score),2) AS average_rating
FROM olist_order_items oi
JOIN olist_order_reviews r
ON oi.order_id = r.order_id
GROUP BY oi.seller_id
HAVING COUNT(*) >= 20
ORDER BY average_rating ASC
LIMIT 10;

-- Q148. Find sellers who generated more than 100 orders.

SELECT
seller_id,
COUNT(DISTINCT order_id) AS total_orders
FROM olist_order_items
GROUP BY seller_id
HAVING COUNT(DISTINCT order_id) > 100
ORDER BY total_orders DESC;

-- Q149. Find the Top 10 sellers with the highest freight revenue.

SELECT
seller_id,
ROUND(SUM(freight_value),2) AS total_freight
FROM olist_order_items
GROUP BY seller_id
ORDER BY total_freight DESC
LIMIT 10;

-- Q150. Build a Seller Performance Dashboard.

SELECT
seller_id,
COUNT(DISTINCT order_id) AS total_orders,
COUNT(product_id) AS total_products,
ROUND(SUM(price),2) AS total_revenue,
ROUND(AVG(price),2) AS average_order_value,
ROUND(SUM(freight_value),2) AS freight_revenue
FROM olist_order_items
GROUP BY seller_id
ORDER BY total_revenue DESC;