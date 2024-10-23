create database Project1;
use project1;
show tables;
select* from orders;
select * from order_details;
select* from pizza_types;
select* from pizzas;


#Retrieve the total number of orders placed.
SELECT 
    COUNT(order_details_id) AS Total_order
FROM
    order_details;

#Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS revenue
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id;    

#Identify the highest-priced pizza 
SELECT 
    pizzas.price AS Price,
    pizza_types.name AS Pizza_Name
FROM
    pizzas
        JOIN
    pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;


#Identify the Lowest-priced pizza 
SELECT 
    pizzas.price AS Price,
    pizza_types.name AS Pizza_Name
FROM
    pizzas
        JOIN
    pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price asc
LIMIT 1;

SELECT 
    order_details.quantity, COUNT(pizzas.size) as Size_of_Order
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
GROUP BY order_details.quantity;

#List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pizza_types.name, SUM(order_details.Quantity) AS count
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY count DESC
LIMIT 5;

#Join the necessary tables to find the total quantity of each pizza category ordered

SELECT 
    SUM(order_details.Quantity) AS Total_Quantity,
    pizza_types.category
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY Total_Quantity Desc;

#Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(orders.time) AS Hours, COUNT(order_details.order_id) As order_count
FROM
    orders
        JOIN
    order_details ON orders.order_id = order_details.order_id
GROUP BY Hours
ORDER BY Hours;

#Join relevant tables to find the category-wise distribution of pizzas.

select category,count(name) from pizza_types group by category;

#Group the orders by date and calculate the average number of pizzas ordered per day

SELECT 
   round( AVG(qua),0)
FROM
    (SELECT 
        orders.date, SUM(order_details.quantity) AS qua
    FROM
        Orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.date) as jk;
    
#Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    pizza_types.name AS Pizza_Name,
    SUM(order_details.quantity * pizzas.price) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 3;

#Calculate the percentage contribution of each pizza type to total revenue.
 select pizza_types.category ,   round(SUM(order_details.quantity * pizzas.price) / 
(SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),2) AS revenue
FROM
    order_details
     pizzas ON pizzas.pizza_id = order_details.pizza_id)*100,2) as cost from pizza_types join pizzas on pizza_types.pizza_type_id=pizzas.pizza_type_id  join order_details on order_details.pizza_id =pizzas.pizza_id group by  pizza_types.category order by cost;
	
 