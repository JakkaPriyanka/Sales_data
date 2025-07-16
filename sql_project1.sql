-- sql retail sales analysis
create database sql_project_p2;
use sql_project_p2;
-- create table 
create table retail_sales
(
transactions_id	int PRIMARY KEY,
sale_date date,
sale_time time,	
customer_id	int,
gender varchar(15),
age int,
category varchar(20) ,
quantiy int,
price_per_unit int,
cogs float,
total_sale int
);
select count(*)
 from retail_sales;

SELECT * from retail_sales
where transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or age is null
or category is null
or price_per_unit is null
or cogs is null
or total_sale is null ;
-- data cleaning deleting the null values from the given data set( here when i imported 
-- data into the dataset through notepad then already some values are removed there i think null values are removed)

select * from retail_sales
where transactions_id=1223;

-- data exploration
-- how many sales we have/ how many records we have
select count(*) as total_sale from retail_sales;
-- how many customers we have?
select count(distinct customer_id) as total_customers from retail_sales;

-- how many category we have
 select distinct category from retail_sales;
 
 -- main data analysis or business key problems
 -- 1) write a sql query to retrive all colums for sale made on 2022- 11-05
 select * from retail_sales
 where sale_date='2022-11-05';
 
 -- 2) retrive all the trasactions where the category is clothing and the quantity sold is more than 10 on the month november 2022
 select * from retail_sales
 where category='clothing' and quantiy>=4 and date_format(sale_date,'%Y-%m')='2022-11';
 
 -- 3) calc the total sales of each category
 SELECT 
    category, SUM(total_sale) as sub_sales
FROM
    retail_sales
GROUP BY 1;
-- here when we use group by instead of names(category) we can also use numbers like 1

 -- 4) average age of the customers who purchased items from the beauty category
 select avg(age)
 from retail_sales
 where category='beauty';
 -- 5) find all the transactions where the total sale greater than 1000
 select *
 from retail_sales
 where total_sale>1000;
 -- 6) find total number of transactions made by each gender in each category
 -- here we use groupby for two columns also but the order is important for example inside the category we need each gender so fisrt we have to write 
 -- category and after that we have to write gender 
 select category,gender,count(*) as total_trans
 from retail_sales
 group by category,gender;
 
 -- 7) calc avg sale for each month.find out best selling month for each year 
 select * from
 (select  year(sale_date) as Year ,month(sale_date) as month ,avg(total_sale) as net_sale,
 Rank() over(partition by year(sale_date) order by avg(total_sale) desc) as ranks
 from retail_sales
 group by 1,2) as t1
 where ranks=1;
 
 -- here i learned about window functions like rank,over(parttion by),CTE stored procedures 
 
 -- 8) find the top 5 customers based on the highest total sales
 select customer_id,sum(total_sale) as sum_sales
 from retail_sales
 group by 1
 order by 2 desc
 limit 5;
 -- 9) find out the number of unique customers who purchased items from each category
 select category,count(distinct customer_id)
 from retail_sales
 group by category;
 -- 10) create each shift and number of orders (eg morning<=12,afternoon between 12 & 17 ,evening >17)
 
 with hourly_sale
 as
 (select *,
 case
    when hour(sale_time)<12 then 'morning'
    when hour(sale_time) between 12 and 17 then 'afternoon'
    else 'evening'
end shift
 from retail_sales)
 select shift,count(*) from hourly_sale
 group by shift;
 



