create table pizza_sales_stagging
(pizza_id	int, 
order_id	int,
pizza_name_id	varchar(20),
quantity	int,
order_date	text,
order_time	time without time zone,
unit_price	decimal,
total_price	decimal,
pizza_size	varchar(20),
pizza_category	varchar(20),
pizza_ingredients varchar(200),
pizza_name varchar(100)
);

select * from pizza_sales

create table pizza_sales
(pizza_id	int, 
order_id	int,
pizza_name_id	varchar(20),
quantity	int,
order_date	date,
order_time	time without time zone,
unit_price	decimal,
total_price	decimal,
pizza_size	varchar(20),
pizza_category	varchar(20),
pizza_ingredients varchar(200),
pizza_name varchar(100)
);

insert into pizza_sales
(pizza_id,order_id,pizza_name_id,quantity,order_date,order_time,unit_price,total_price	,pizza_size	,pizza_category	,pizza_ingredients	,pizza_name
)
select 
pizza_id	,
order_id	,
pizza_name_id	,
quantity	,
to_date (order_date	,'DD-MM-YYYY'),
order_time	,
unit_price	,
total_price	,
pizza_size	,
pizza_category,	
pizza_ingredients,	
pizza_name
from pizza_sales_stagging;


select * from pizza_sales 
drop table IF EXISTS pizza_sales_stagging 

-- 1. Total Revenue:

SELECT sum(total_price) as total_revenue
from pizza_sales

-- 2. Average Order Value
select round(sum(total_price)/count(distinct order_id),2) as average_order_value
from pizza_sales 

-- 3. Total Pizzas Sold

select sum(quantity) as total_pizza_sold
from pizza_sales

-- 4. Total Orders

select count( distinct order_id) as total_orders 
from pizza_sales

-- 5. Average Pizzas Per Order

select round(sum(quantity)::decimal/ count(distinct order_id)::decimal,2)as avg_pizza_per_order
from pizza_sales

-- B. Daily Trend for Total Orders

select  to_char(order_date,'Day') as order_day, 
		count(distinct order_id) as total_orders 
from pizza_sales
group by 1

-- C. Monthly Trend for Orders

select to_char(order_date,'Month') as order_month,
count(distinct order_id) as total_orders
from pizza_sales
group by 1

-- D. % of Sales by Pizza Category
select pizza_category, sum(total_price) as total_revenue,
round(sum(total_price)/(select sum(total_price) from pizza_sales)*100,2) as percent_of_sales
from pizza_sales
group by 1;

-- E. % of Sales by Pizza Size

select pizza_size, sum(total_price) as total_revenue,
round(sum(total_price)/(select sum(total_price)from pizza_sales )*100,2) as percent_sales
from pizza_sales
group by 1
order by 1;

-- F. Total Pizzas Sold by Pizza Category

select pizza_category, sum(quantity) as total_sales
from pizza_sales
group by 1
order by 2 desc

-- G. Top 5 Pizzas by Revenue

select pizza_name , sum(total_price) as total_revenue
from pizza_sales
group  by 1
order by 2 desc
limit 5

-- H. Bottom 5 Pizzas by Revenue
select pizza_name , sum(total_price) as total_revenue
from pizza_sales
group  by 1
order by 2 asc
limit 5

-- I. Top 5 Pizzas by Quantity
select pizza_name , sum(quantity) as total_sales
from pizza_sales
group  by 1
order by 2 desc
limit 5

-- J. Bottom 5 Pizzas by Quantity
select pizza_name , sum(quantity) as total_sales
from pizza_sales
group  by 1
order by 2 asc
limit 5

-- K. Top 5 Pizzas by Total Orders

select pizza_name, count(distinct order_id) as total_orders 
from pizza_sales 
group by 1 
order by 2 desc
limit 5

-- L. Borrom 5 Pizzas by Total Orders
select pizza_name, count(distinct order_id) as total_orders 
from pizza_sales 
group by 1 
order by 2 asc
limit 5





