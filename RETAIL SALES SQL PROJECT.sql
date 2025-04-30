--sql retail sales analytics
create database retail_sales_project

--create table
create table retail_sales
(
transactions_id int primary key,
	sale_date date,
	sale_time time,	
	customer_id	int,
	gender varchar(15),	
	age	int,
	category varchar (15),
	quantiy	int,
	price_per_unit float,
	cogs float,
	total_sale float
)
select * from retail_sales

-- data cleaning
select * from retail_sales
where transactions_id is NULL 
OR sale_date is null 
or sale_time is NULL 
or customer_id is NULL 
or gender is NULL  
or category is NULL 
or quantiy is NULL 
or price_per_unit is NULL 
or cogs is null
or total_sale is NULL 

--
delete from retail_sales
where transactions_id is NULL 
OR sale_date is null 
or sale_time is NULL 
or customer_id is NULL 
or gender is NULL   
or category is NULL 
or quantiy is NULL 
or price_per_unit is NULL 
or cogs is null
or total_sale is NULL 

--data exploration
-- How many sales we have?
select count(*) as total_sales from retail_sales
-- How many unique customers we have?
select count(distinct customer_id) as total_sales from retail_sales
-- How many unique category we have?
select count(distinct category) as total_sales from retail_sales
select distinct category from retail_sales

--Data analysis & buisness problems & answers
My Analysis & Findings

--Q.1 write a SQL query to retrieve all columns for sales made on 2022-11-05
--Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
--0.3 Write a SQL query to calculate the total sales (total sale) for each category.
--Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
--Q.5 Write a SQL query to find all transactions where the total sale is greater than 1000.
--Q.6 Write a SQL query to find the total number of transactions (transaction id) made by each gender in each category. 
--0.7 write a SQL query to calculate the average sale for each month. Find out best selling month in each year
--Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
--0.9 Write a SQL query to find the number of unique customers who purchased items from each category.
--0.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

--ANSWERS

--Q.1 write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT * FROM retail_sales 
where sale_date = '2022-11-05'

--Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
select category, sum(quantiy) from retail_sales
where category = 'Clothing'
group by 1
select * from retail_sales
where category = 'Clothing'
and to_char(sale_date, 'yyyy-mm') = '2022-11'
and quantiy >= 4

--0.3 Write a SQL query to calculate the total sales (total sale) for each category.
select category, sum(total_sale) as net_sale, count(*) as total_orders from retail_sales
group by 1

--Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select round(avg(age),0) as avg_age from retail_sales
where category = 'Beauty' 

--Q.5 Write a SQL query to find all transactions where the total sale is greater than 1000.
select transactions_id,total_sale from retail_sales
where total_sale >1000

--Q.6 Write a SQL query to find the total number of transactions (transaction id) made by each gender in each category. 
select category,gender, count(*) as total_transactions from retail_sales
group by category,gender
order by 1

--0.7 write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select * from(
select extract(year from sale_date) as year, extract(month from sale_date) as month,
avg(total_sale) as avg_sales,
Rank() over( partition by extract (year from sale_date)order by avg(total_sale) desc) as rank
 from retail_sales
 group by 1,2)
 as T1
 where rank=1

--Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
select customer_id,
sum(total_sale) as total_sales
from retail_sales
group by 1
order by 2 desc
limit 5

--0.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select category, count(distinct customer_id) as distict_customer
from retail_sales
group by 1

--0.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
with hourly_sale
as
(select *, case
when extract (hour from sale_time) <12 then 'morning'
when extract(hour from sale_time) between 12  and 17 then 'afternoon'
else 'evening'
end as shift
from retail_sales)
select shift, count(*) total_orders
from hourly_sale
group by shift

--END






 
 
 
 
 
 
 
 
 
 


