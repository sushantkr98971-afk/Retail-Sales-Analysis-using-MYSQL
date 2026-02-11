create database freelance;
use freelance;
create table sales_details(
                 transactions_id int primary key,
                 sale_date	date,
                 sale_time	time,
                 customer_id int,
                 gender	varchar(15),
                 age	int,
                 category	varchar(15),
                 quantiy	int,
                 price_per_unit	float,
                 cogs	float,
                 total_sale float
                 );

## DATA CLEANING
select  distinct *,count(*) 
from sales_details
group by  transactions_id;

select count(*) from sales_details;

select * from sales_details
where 
     transactions_id is null
      or
	sale_date is null
    or
	sale_time is null
    or
	customer_id is null
    or
	gender is null
    or
	age is null
    or
	category is null
    or
	quantiy is null
    or
	price_per_unit is null
    or
	cogs is null
    or
	total_sale is null;

select distinct (customer_id) from sales_details
order by customer_id asc;

select * from sales_details;
select distinct category from sales_details;

alter table sales_details
rename column quantiy to quantity;

## PRACTICAL QUESTIONS

#Q.1 Write a SQL query to retrieve all columns for sales made on 2022-11-05
#Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
#Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
#Q.4 Write a SQL query to find the average age of customers who purchased items from the Beauty category.
#Q.5 Write a SQL query to find all transactions where the total sale is greater than 1000.
#Q.6 Write a SQL query to find the total number of transactions (transaction id) made by each gender in each category.
#Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
#Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
#Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
#Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


#Q.1 Write a SQL query to retrieve all columns for sales made on 2022-11-05?

select * from sales_details
where sale_date = '2022-11-05';

#Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

select * from sales_details
where  category = "clothing" 
       and quantity > 10
       and sale_date between '2022-11-01' and '2022-11-30';

#Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
       
select  category, sum(total_sale) from sales_details
group by category;

#Q.4 Write a SQL query to find the average age of customers who purchased items from the Beauty category.

select category, avg(age) from sales_details
where category = "beauty"
group by category;

#Q.5 Write a SQL query to find all transactions where the total sale is greater than 1000.

select transactions_id, total_sale from sales_details
where total_sale > 1000;

#Q.6 Write a SQL query to find the total number of transactions (transaction id) made by each gender in each category.

select gender, count(transactions_id) from sales_details
group by gender;

#Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select  year(sale_date) as year, month(sale_date) as month, avg(total_sale) from sales_details as sd
group by month(sale_date), year(sale_date)
order by month, year;

select year, month, avg_sale
from (
   select year(sale_date) as year,
           month(sale_date) as month,
           avg(total_sale) as avg_sale,
           rank() over (partition by year(sale_date) order by avg(total_sale) desc) as rank_in_year
    from sales_details
    group by year(sale_date), month(sale_date)
) ranked
where rank_in_year = 1;

#Q.8 Write a SQL query to find the top 5 customers based on the highest total sales

select customer_id, total_sale from sales_details
order by total_sale desc
limit 5;

#Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select   category , count(distinct customer_id)from sales_details
group by category;

#Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

select transactions_id, sale_time ,
case 
    when extract(hour from sale_time) < 12 then "morning"
    when extract(hour from sale_time) between 12 and 17 then " afternoon"
    else "evening"
end as shifts
from sales_details;

# PROJECT ENDS!