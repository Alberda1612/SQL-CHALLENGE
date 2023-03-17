--- Q1. What is the total amount each customer spent at the restauraunt?
SELECT s.customer_id, SUM(price) Amt_Spent
FROM sales s
INNER JOIN menu u
	ON s.product_id = u.product_id
GROUP BY s.customer_id
ORDER BY Amt_Spent;


---Q2. How many days has each customer visited the restaurant?
SELECT customer_id, COUNT(DISTINCT order_date) days
FROM sales 
GROUP BY customer_id;


---Q3. What was the first item from the menu purchased by each customer?
SELECT s.customer_id, u.product_name AS first_purchase_date
FROM sales s
INNER JOIN menu u
	ON s.product_id = u.product_id
WHERE s.order_date = (
	SELECT MIN(order_date)
    FROM sales
);

/* Q4. What is the most purchased item on the menu and 
how many times was it purchased by all customers */

SELECT TOP 1 u.product_name, COUNT(s.product_id) Num_purchased
FROM sales s
INNER JOIN menu u
	ON s.product_id = u.product_id
GROUP BY u.product_name
ORDER BY Num_purchased DESC;

--- Q5. Which item was the most popular for each customer?
SELECT customer_id, 
       MAX(product_name) as most_popular_item, 
       MAX(num_orders) as num_orders
FROM (
  SELECT s.customer_id, u.product_name, COUNT(s.product_id) as num_orders
  FROM Sales s
  JOIN menu u ON s.product_id = u.product_id
  GROUP BY s.customer_id, u.product_name
) as temp
GROUP BY customer_id;

/* Q6. Which item was purchased first by the customer after
they became a member?*/
WITH purchase_table AS
(
	SELECT m.customer_id, u.product_name, m.join_date, s.order_date,
	RANK() OVER (PARTITION BY m.customer_id ORDER BY s.order_date) AS rank
	FROM members m
	JOIN sales s
		ON m.customer_id = s.customer_id
	JOIN menu u
		ON s.product_id = u.product_id
	WHERE s.order_date >= m.join_date
)
SELECT *
FROM purchase_table
 WHERE rank = 1;


--- Q7. Which item was purchased just before the person became a member?
WITH cte AS 
(
	SELECT m.customer_id, u.product_name, s.order_date, m.join_date,
	RANK() OVER (PARTITION BY m.customer_id ORDER BY s.order_date) AS rank
	FROM members m
	INNER JOIN sales s
		ON m.customer_id = s.customer_id
	INNER JOIN menu u
		ON s.product_id = u.product_id
	WHERE s.order_date < m.join_date
)
SELECT * 
FROM cte
WHERE rank = 1;



/* Q8. What is the total items and amount spent for 
each member before they became a member*/
SELECT m.customer_id, COUNT(u.product_name) AS Total_items, SUM(u.price) AS Amt_Spent
	FROM members m
	JOIN sales s
		ON m.customer_id = s.customer_id
	JOIN menu u
		ON s.product_id = u.product_id
	WHERE s.order_date < m.join_date
GROUP BY m.customer_id;


/* Q9. If each $1 spent equates to 10 points and sushi has 2x points multiplier- 
how many points would each customer have?*/
SELECT s.customer_id AS customer, 
	SUM(CASE WHEN u.product_name = 'sushi' THEN 2*10*u.price ELSE 10*u.price END) AS Tot_points
FROM sales s
JOIN menu u
	ON s.product_id =  u.product_id
GROUP BY s.customer_id
ORDER BY Tot_points DESC;


/* Q10. In the first week after a customer joins the program (including their join date) 
they earn 2x points on all items, not just sushi- 
how many points do customer A and B have at the end of January?*/
SELECT m.customer_id, SUM(u.price * CASE WHEN s.order_date <= DATEADD(week, 1, m.join_date) THEN 2 ELSE 1 END) AS total_points
FROM members m
JOIN sales s ON m.customer_id = s.customer_id
JOIN menu u ON s.product_id = u.product_id
WHERE MONTH(s.order_date) = 1
GROUP BY m.customer_id

