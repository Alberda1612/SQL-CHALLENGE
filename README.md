# Danny Ma's SQL-CHALLENGE

![](Danny_Ma_1.JPG)

## Introduction
#### Danny's Dinner is a restraunt that is in need of a data analyst to help make informed business decisions to keep the new restraunt afloat.

## Problem Statement 
#### Danny wants to use the data to answer a few simple questions about his customers, especially about their visiting patterns, how much money they’ve spent and also which menu items are their favourite. Having this deeper connection with his customers will help him deliver a better and more personalised experience for his loyal customers.
He plans on using these insights to help him decide whether he should expand the existing customer loyalty program.
**_Note_** : _The datasets provided by client are;
1. sales
2. menu
3. members

![](ER_Diagram.JPG)


## Challenge Encountered
There was a ready-to-work query editor to use as part of the sql challenge. However, I encountered a lot of problems with using that online editor. I decided to use SQL Server Management Studio. The database wasn't readily available on SQL server so a Danny Ma database was created in SQL Server before proceeding with the case study questions. 
A snippet of it is shown in the diagram below; however, the script file is in this repository.

![](Dany's_db.JPG)

![]()
## Case Study Questions and Solutions
#### Q1. What is the total amount each customer spent at the restraunt?
To answer this question, I joined the sales and menu table since the information we need is found in these two tables.

![](Q1.JPG)

The query above selects customer_id from sales column aliased as s, it then looks for the product that was bought also from sales and gets the price of that product from the menu column aliased as u. It then groups all products bought by customer and gives the total sum. 

Q2. How many days has each customer visited the restraunt?
All data needed to answer this question is in the sales column. 

![](q2.JPG)

The query selects customer_id groups it, and then counts the distinct number of days each customer viisted.

Q3. What was the first item from the menu purchased by each customer?
The data needed to answer this question is in two tables; sales and menu hence, we join them.

![](Q3.JPG)

The above query selects customer_id and product name from the joined tables where the order date is the earliest(minimum) order date.

Q4. What is the most purchased item on the menu, how many times was it purchased by all customers?
Here, we join 2 tables; sales and menu using the product_id.

![](Q4.JPG)

The query above groups the product name and counts the number of times a customer has purchased the product. It then orders the products based on the number of times it has been purchased in descending order. The "top 1" at the beginning of the query selects only the first product on the list, in this case, the highest purchased.

Q5. Which item was the most popular for each customer?
Again, the data needed here is in two tables; sales and menu hence, we join them. We also used a subquery here.

![](Q5.JPG)

Lets's start with the inner query(subquery). It joins the two tables we will need our data from. It then selects customer_id, product name and counts the number of times that product has been purchased and stores it as the number of orders.  
The main query selects customer_id, product_name and the maximum number of orders from the results of the subquery. 

Q6. Which item was purchased first by the customer after they became a member?
Here, we created a temporary table called purchase table and joined the original 3 tables; sales, menu and members.

![](Q6.JPG)

In the purchase_table, we ranked the partition of customer_id which was ordered it by the order date. We then selected customer_id, product_name, the join_date and order date from the purchase_table where the rank was 1. The ranking was done in ascending order of date hence, rank 1 is the earliest item purchased by the customers.

Q7. Which item was purchased just before the person became a member?
Here, we used a similar query as used in question 6 above, However, we are looking at products purchased before the customers became a member of the loyalty program (that is; order_date < join_date).

![](Q7.JPG)

Q8. What is the total items and amount spent for each member before they became a member
All three tables were joined. 

![](Q8.JPG)

Here, customer_id was selected, counted the number of products as the total items purchased and found the sum of the products purchased. This was done on only orders that were made before the customers became members of the program (order_date < join_date). I then grouped by customers.

Q9. If each $1 spent equates to 10 points and sushi has 2x points multiplier-how many points would each customer have?
Here, we make use of the CASE statement and joined 2 tables; sales and menu.

![](Q9.JPG)

In the above query, a case statment was made to find points accumulated by customers based on their purchase. It made an exception for when a product is a 'sushi', here, the point is doubled. 

Q10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi- 
how many points do customer A and B have at the end of January?
Here, we join all three tables; sales, members and menu tables and made use of case statements as well. 

![](Q10.JPG)

In the above query, let's begin with the case statement. The CASE statement within the SUM function calculates the number of points earned by each sale, based on the order date and the customer's join date. If the order was placed within the first week of the customer's membership (join_date), then the points earned are multiplied by 2, otherwise the points are multiplied by 1.
The where clause limits us to only sales made in January. We then select all details needed from the tables.

##Some Insights Made 
1. Danny's restraunt has only 3 customers. 
2. Out of these three customers, 2 have joined the customer loyalty program proposed by Danny.
3. The tree customers have been consistent in their buying from the restraunt although they don't buy everyday.
4. The most purchased food is 'ramen'. 
5. The customer loyalty program will greatly benefit the restraunt. 
   Knowing customer data gives you a leverage over competitors who do not utilize their cutsomer data.
   For example; knowing that the customers love 'ramen' dish, more dishes similar to 'ramen' can be introduced to give variety yet same delicious taste.
   
# THANK YOU. 


