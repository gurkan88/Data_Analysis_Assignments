/*1. Conversion Rate
Below you see a table of the actions of customers visiting the website by clicking on two different types of advertisements given by an E-Commerce company. Write a query to return the conversion and cancellation rates for each Advertisement type.
Actions:

Visitor_ID	Adv_Type	Action
1	A	Left
2	A	Order
3	B	Left
4	A	Order
5	A	Review
6	A	Left
7	B	Left
8	B	Order
9	B	Review
10	A	Review

Desired_Output:

Adv_Type	Conversion_Rate
A	0.33
B	0.25

a.	Create above table (Actions) and insert values,

b.	Retrieve count of total Actions, and Orders for each Advertisement Type,

c.	Calculate Orders (Conversion) rates for each Advertisement Type by dividing by total count of actions casting as float by multiplying by 1.0.
*/


USE test


drop table Actions


CREATE TABLE Actions (
						Visitor_ID TINYINT,
						Adv_Type CHAR,
						[Action] CHAR(10)
						)


INSERT INTO Actions (Visitor_ID, Adv_Type, [Action])
VALUES	(1,	'A', 'Left'),
		(2,	'A', 'Order'),
		(3,	'B', 'Left'),
		(4,	'A', 'Order'),
		(5,	'A', 'Review'),
		(6,	'A', 'Left'),
		(7,	'B', 'Left'),
		(8,	'B', 'Order'),
		(9,	'B', 'Review'),
		(10, 'A', 'Review');


SELECT *
FROM Actions


SELECT		Adv_Type, [Action], count([Action]) Quantity
FROM		Actions
GROUP BY	[Action], Adv_Type


SELECT		Adv_Type, COUNT([Action]) Total
FROM		Actions
GROUP BY	Adv_Type


SELECT		Adv_Type, COUNT([Action]) Number_of_order
FROM		Actions 
WHERE		[Action] = 'Order'
GROUP BY	Adv_Type

---------------
--2

select	A.Adv_Type, A.Total, Number_of_order
from	(SELECT		Adv_Type, COUNT([Action]) Total
		FROM		Actions
		GROUP BY	Adv_Type) A
join	(SELECT		Adv_Type, COUNT([Action]) Number_of_order
		FROM		Actions 
		WHERE		[Action] = 'Order'
		GROUP BY	Adv_Type
		) B
on A.Adv_Type = B.Adv_Type

--Alternative - 2
SELECT Adv_Type, Count([Action]) As Num_Action, (SELECT Count([Action]) FROM Actions WHERE [Action] = 'Order' AND Adv_Type = 'A' ) As Num_order
FROM Actions
WHERE Adv_Type = 'A'
GROUP BY Adv_Type
UNION
SELECT Adv_Type, Count([Action]) As Num_Action, (SELECT Count([Action]) FROM Actions WHERE [Action] = 'Order' AND Adv_Type = 'B' ) As Num_order
FROM Actions
WHERE Adv_Type = 'B'
GROUP BY Adv_Type


---test---------------------------------
DECLARE @test DECIMAL(18,6) = 123.456789
SELECT FORMAT(@test, '##.##')
--or
SELECT CAST(12 AS DECIMAL(16,2))
----------------------------------------------


-----------------SOLUTION---------------

SELECT		X.Adv_Type, cast((Y.Number_of_order*1.0) / (X.Total*1.0) as decimal(16,2)) Conversion_Rate
FROM		(
			SELECT		Adv_Type, COUNT([Action]) Total
			FROM		Actions
			GROUP BY	Adv_Type) X
JOIN		(SELECT		Adv_Type, COUNT([Action]) Number_of_order
			FROM		Actions 
			WHERE		[Action] = 'Order'
			GROUP BY	Adv_Type) Y
			ON	X.Adv_Type = Y.Adv_Type



