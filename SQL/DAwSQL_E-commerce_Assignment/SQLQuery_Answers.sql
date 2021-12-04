use [E-COMMERCE]



/*
1. Join all the tables and create a new table with all of the columns, called combined_table. (market_fact, cust_dimen, orders_dimen, prod_dimen, shipping_dimen)*/

SELECT				*									----After obtaining the result, it has been saved as a csv file and imported this csv file again to the database
FROM				market_fact A
FULL OUTER JOIN		cust_dimen B
					ON	A.cust_id = B.cust_id
FULL OUTER JOIN		orders_dimen C
					ON	A.ord_id = C.ord_id
FULL OUTER JOIN		shipping_dimen D
					ON	A.ship_id = D.ship_id
FULL OUTER JOIN		prod_dimen E
					ON	A.prod_id = E.prod_id



select *
from combined_tables

alter table combined_tables
drop column ord_id2

alter table combined_tables
drop column cust_id2

alter table combined_tables
drop column ship_id2

alter table combined_tables
drop column prod_id2



SELECT DISTINCT Ord_id, Prod_id, Ship_id, Cust_id, Sales, Discount, Order_Quantity, Product_Base_Margin,
				Customer_Name, Province, Region, Customer_Segment, Order_Date, Order_Priority, Order_ID, 
				Ship_Mode, Ship_Date, Product_Category, Product_Sub_Category	

INTO combined_table

FROM combined_tables



---second solution----------------
SELECT	*
INTO	combined_table2 
FROM	(SELECT				A.Ord_id, A.Prod_id, A.Ship_id, A.Cust_id, Sales, Discount, Order_Quantity, Product_Base_Margin,
							Customer_Name, Province, Region, Customer_Segment, Order_Date, Order_Priority, Order_ID, Ship_Mode,
							Ship_Date, Product_Category, Product_Sub_Category	
		FROM				market_fact A
		FULL OUTER JOIN		cust_dimen B
							ON	A.cust_id = B.cust_id
		FULL OUTER JOIN		orders_dimen C
							ON	A.ord_id = C.ord_id
		FULL OUTER JOIN		shipping_dimen D
							ON	A.ship_id = D.ship_id
		FULL OUTER JOIN		prod_dimen E
							ON	A.prod_id = E.prod_id) P;

-- WHERE 1 = 0     ---if only copy the table itself not the records



SELECT	*
INTO	combined_table3 
FROM	(SELECT				A.Ord_id, A.Prod_id, A.Ship_id, A.Cust_id, Sales, Discount, Order_Quantity, Product_Base_Margin,
							Customer_Name, Province, Region, Customer_Segment, Order_Date, Order_Priority, Order_ID, Ship_Mode,
							Ship_Date, Product_Category, Product_Sub_Category	
		FROM				market_fact A
		FULL OUTER JOIN		cust_dimen B
							ON	A.cust_id = B.cust_id
		FULL OUTER JOIN		orders_dimen C
							ON	A.ord_id = C.ord_id
		FULL OUTER JOIN		shipping_dimen D
							ON	A.ship_id = D.ship_id
		FULL OUTER JOIN		prod_dimen E
							ON	A.prod_id = E.prod_id) P
WHERE 1 = 0;	--- if only copy the table itself not the records

select	*
from combined_table3


--------------------------------



/* 
2. Find the top 3 customers who have the maximum count of orders.*/


with t1 as (
SELECT		distinct Cust_id, count( Order_Quantity) count_of_orders
FROM		combined_table 
GROUP BY	Cust_id
)
select distinct top 3 cust_id, count_of_orders
from t1
order by count_of_orders desc


select *
from market_fact
where ord_id = 'Ord_444'

select *
from market_fact
where ord_id = 'Ord_1329'

SELECT		Cust_id, Order_Quantity
FROM		market_fact 
where		Cust_id = 'Cust_444'
GROUP BY	Cust_id



/*
3. Create a new column at combined_table as DaysTakenForDelivery that contains the date difference of Order_Date and Ship_Date.*/


alter table combined_table
add DaysTakenForDelivery int

update combined_table
set DaysTakenForDelivery = datediff(day, Order_Date, Ship_Date)
		
select *
from combined_table
order by DaysTakenForDelivery desc


/*
4. Find the customer whose order took the maximum time to get delivered.*/


select top 1 Cust_id, Customer_Name, Order_Date, Ship_Date, DaysTakenForDelivery
from combined_table
order by DaysTakenForDelivery desc


/* 
5. Count the total number of unique customers in January and how many of them came back every month over the entire year in 2011*/



select *
from combined_table


select count(distinct Cust_id)
from combined_table
where month(Order_Date) = 1 and year(order_date) = 2011


select distinct Cust_id, order_date
from combined_table
where month(Order_Date) = 1


select month(order_date), count(distinct cust_id)
from combined_table
where cust_id in	(	select distinct Cust_id
						from combined_table
						where month(Order_Date) = 1 
						and year(order_date) = 2011  ) 
	and year(order_date) = 2011
group by month(order_date)



/*
6. Write a query to return for each user the time elapsed between the first purchasing and the third purchasing, in ascending order by Customer ID.*/

---------

with t1 as
		(select distinct cust_id, order_date,
				DENSE_RANK() OVER (partition by cust_id order by order_date) dense_number
		from combined_table)
select	*
from	t1
where	t1.dense_number = 1

--------------

with t1 as
		(select distinct cust_id, order_date,
				DENSE_RANK() OVER (partition by cust_id order by order_date) dense_number
		from combined_table)
select	*
from	t1 B
where	dense_number = 3

------------

select	*
from (
select distinct cust_id, order_date,
				DENSE_RANK() OVER (partition by cust_id order by order_date) dense_number
		from combined_table
		) a
where dense_number = 1


--------------------
-----solution--------------------------------------


select	*,
		datediff(day,b.first_order_date, a.order_date) days_elapsed
from	(
		select	*
		from	(
				select distinct cust_id, order_date,
						DENSE_RANK() OVER (partition by cust_id order by order_date) dense_number
				from combined_table
				) a
		where dense_number = 3 
		) a

inner join 

		(select	*
		from	(
				select	*
				from	(
						select	distinct cust_id, order_date first_order_date,
								DENSE_RANK() OVER (partition by cust_id order by order_date) dense_number
						from combined_table) b 
				where dense_number = 1
				) b
		) b
on a.Cust_id = b.Cust_id 








--DAwSQL Session -8 

--E-Commerce Project Solution



--1. Join all the tables and create a new table called combined_table. (market_fact, cust_dimen, orders_dimen, prod_dimen, shipping_dimen)





--///////////////////////


--2. Find the top 3 customers who have the maximum count of orders.





--/////////////////////////////////



--3.Create a new column at combined_table as DaysTakenForDelivery that contains the date difference of Order_Date and Ship_Date.
--Use "ALTER TABLE", "UPDATE" etc.




--////////////////////////////////////


--4. Find the customer whose order took the maximum time to get delivered.
--Use "MAX" or "TOP"




--////////////////////////////////



--5. Count the total number of unique customers in January and how many of them came back every month over the entire year in 2011
--You can use such date functions and subqueries





--////////////////////////////////////////////


--6. write a query to return for each user the time elapsed between the first purchasing and the third purchasing, 
--in ascending order by Customer ID
--Use "MIN" with Window Functions





--//////////////////////////////////////

--7. Write a query that returns customers who purchased both product 11 and product 14, 
--as well as the ratio of these products to the total number of products purchased by the customer.
--Use CASE Expression, CTE, CAST AND such Aggregate Functions


select	cust_id, dense_rank() over(partition by cust_id order by prod_id)
from	combined_table
where	prod_id = 'Prod_11' 
---------------------
select	distinct Cust_id, Order_Quantity
from combined_table
where cust_id = 'Cust_1538'


(select	*
from	(
		select	cust_id, count(prod_id) P14
		from	combined_table
		where	prod_id = 'Prod_14'
		group by cust_id) B
) B
------------------

		(select	distinct A.cust_id, sum(distinct Order_Quantity) total_order
		from	combined_table A
		group by A.cust_id) C


		select 10*1.0/15*1.0





--------------------------solution-----------
-------------------------------------


select	A.*, B.P14, C.total_order, convert(decimal(2,2), A.P11*1.0 / C.total_order*1.0) ratio_P11, convert(decimal(2,2), B.P14*1.0/C.total_order*1.0) ratio_P14
from	(select	distinct A.cust_id, sum(distinct Order_Quantity) P11
		from	combined_table A
		where	prod_id = 'Prod_11' 
		group by A.cust_id) A

inner join 
			(select	*
			from	(
					select	distinct cust_id, sum(distinct Order_Quantity) P14
					from	combined_table
					where	prod_id = 'Prod_14'
					group by cust_id) B
			) B

on A.Cust_id = B.Cust_id 

inner join
			(select *
			from	(
					select	distinct A.cust_id, sum(distinct Order_Quantity) total_order
					from	combined_table A
					group by A.cust_id) C
			) C

on A.Cust_id = C.cust_id




--/////////////////



--CUSTOMER RETENTION ANALYSIS



--1. Create a view that keeps visit logs of customers on a monthly basis. (For each log, three field is kept: Cust_id, Year, Month)
--Use such date functions. Don't forget to call up columns you might need later.


CREATE VIEW visits as
SELECT	Cust_id,[YEAR],[MONTH]
FROM	(
		SELECT	distinct Cust_id, year(Order_Date) [YEAR], month(Order_Date) [MONTH], prod_id, sales
		FROM	combined_table) A


SELECT *
FROM Visits
---------------------------------------

select Cust_id, year(Order_Date)
from combined_tables
order by cust_id

drop view visits

select	*
from combined_tables
where Cust_id = 'Cust_100'

--//////////////////////////////////


--2. Create a view that keeps the number of monthly visits by users. (Separately for all months from the business beginning)
--Don't forget to call up columns you might need later.


SELECT	cust_id, [YEAR], [MONTH], count([MONTH]) NUM_OF_LOG
FROM	visits
GROUP BY cust_id, [YEAR], [MONTH]



SELECT	cust_id, year(Order_Date) [YEAR],
		month(Order_Date) [MONTH], 
		DENSE_RANK() over(partition by month(Order_Date) order by cust_id) NUM_OF_LOG
FROM	combined_table
ORDER BY cust_id


select	*
from combined_table
where Cust_id = 'Cust_100'



--//////////////////////////////////


--3. For each visit of customers, create the next month of the visit as a separate column.
--You can number the months with "DENSE_RANK" function.
--then create a new column for each month showing the next month using the numbering you have made. (use "LEAD" function.)
--Don't forget to call up columns you might need later.



select	*, [year], [month],
				dense_rank() over (order by [year], [month]) current_month
		from	visits
order by cust_id, current_month


select	*,
		lead(current_month,1) over(partition by cust_id order by current_month) next_visit_month
from	(select	*,
				dense_rank() over (order by [year], [month]) current_month
		from	visits
		) A


-------------------------------------------

SELECT	cust_id, [YEAR], [MONTH],
		count([MONTH]) NUM_OF_LOG,
		lead([MONTH],1) over(partition by cust_id order by [YEAR], [MONTH]) next_visit_month,
		lead([YEAR],1) over(partition by cust_id order by [YEAR], [MONTH]) next_visit_month
FROM	visits
GROUP BY cust_id, [YEAR], [MONTH]
ORDER BY cust_id, [YEAR]




SELECT	cust_id, [YEAR], [MONTH],
		count([MONTH]) NUM_OF_LOG,
		lead([MONTH],1) over(order by [MONTH]) current_month,
		lead([MONTH],1) over(partition by cust_id order by cust_id, [YEAR]) next_visit_month
FROM	visits
GROUP BY cust_id, [YEAR], [MONTH]
ORDER BY cust_id, [YEAR]




select	cust_id, [YEAR], [MONTH], NUM_OF_LOG, 
		sum(current_month) over (order by cust_id, [YEAR], [MONTH]), 
		sum(next_visit_month) over(order by cust_id, [YEAR], [MONTH])
from	(SELECT	cust_id, [YEAR], [MONTH],
				count([MONTH]) NUM_OF_LOG,
				lead([MONTH],1) over(order by [MONTH]) current_month,
				lead([MONTH],1) over(partition by cust_id order by cust_id, [YEAR]) next_visit_month
		FROM	visits
		GROUP BY cust_id, [YEAR], [MONTH]
) A

ORDER BY cust_id, [YEAR]




--/////////////////////////////////



--4. Calculate the monthly time gap between two consecutive visits by each customer.
--Don't forget to call up columns you might need later.

create view visits2 as 
select	*,
		lead(current_month,1) over(partition by cust_id order by current_month) next_visit_month
from	(select	*,
				dense_rank() over (order by [year], [month]) current_month
		from	visits
		) A


create view visits_time_gap as
select	*,
		next_visit_month-current_month time_gap
from	visits2

drop view visits_time_gap

select *
from visits_time_gap





--/////////////////////////////////////////


--5.Categorise customers using time gaps. Choose the most fitted labeling model for you.
--  For example: 
--	Labeled as churn if the customer hasn't made another purchase in the months since they made their first purchase.
--	Labeled as regular if the customer has made a purchase every month.
--  Etc.

select *
from visits_time_gap


select	cust_id,
case	
		when time_gap >= 1 or time_gap = 0 then 'irregular'
		else 'churn'
end as	cust_labels
from	visits_time_gap




--/////////////////////////////////////




--MONTH-WÝSE RETENTÝON RATE


--Find month-by-month customer retention rate  since the start of the business.


--1. Find the number of customers retained month-wise. (You can use time gaps)
--Use Time Gaps
------------------------

select	*, count(cust_id) over(partition by current_month, next_visit_month)
from	visits_time_gap
where	time_gap is not null and time_gap <> 0 and time_gap = 1
order by cust_id, time_gap

---------------------------------

select	*
from	visits_time_gap
where	current_month = 17 and
		time_gap is not null and time_gap <> 0
order by time_gap

------------answer--------

create view retention_ as 
select	*
from (
select	*, count(cust_id) over(partition by current_month, next_visit_month) retention_month_wise
from	visits_time_gap
where	time_gap is not null and time_gap <> 0 and time_gap = 1) a


select	*
from retention_
order by cust_id, time_gap


-----------------



--//////////////////////


--2. Calculate the month-wise retention rate.

--Basic formula: o	Month-Wise Retention Rate = 1.0 * Total Number of Customers in The Previous Month / Number of Customers Retained in The Next Month

--It is easier to divide the operations into parts rather than in a single ad-hoc query. It is recommended to use View. 
--You can also use CTE or Subquery if you want.

--You should pay attention to the join type and join columns between your views or tables.


select	current_month, next_visit_month, avg(retention_month_wise)
from	retention_
group by current_month, next_visit_month



select *
from retention_ A
inner join retention_ B
on A.cust_id = B.cust_id and A.year = B.year and A.month = B.month
where 

----uncomplete

select *, DATEFROMPARTS([year], [month], 1)
from retention_

---///////////////////////////////////
--Good luck!
