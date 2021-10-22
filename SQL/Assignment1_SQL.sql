/*Transaction Logs
Below, you see a transaction table where the logs of transactions between accounts are stored. Write a query to return the change in net worth for each user, ordered by decreasing net change.

Transactions:
Sender_ID	Receiver_ID	Amount	Transaction_Date
55	22	500	18.05.2021
11	33	350	19.05.2021
22	11	650	19.05.2021
22	33	900	20.05.2021
33	11	500	21.05.2021
33	22	750	21.05.2021
11	44	300	22.05.2021
Desired Output:
Account_ID	Net_Change
11	500
44	300
33	0
22	-300
55	-500

a.	Create above table (transactions) and insert values,

b.	Sum amounts for each sender (debits) and receiver (credits),

c.	Full (outer) join debits and credits tables on account id, taking net change as difference between credits and debits, coercing nulls to zeros with coalesce()*/



use SampleSales

create table Transactions
		(Sender_ID int,
		Receiver_ID int,
		Amount int,
		Transaction_Date text
		)


INSERT INTO Transactions (Sender_ID, Receiver_ID, Amount, Transaction_Date)
VALUES (55,22,500,'18.05.2021'),
		(11,33,350,'19.05.2021'),
		(22,11,650,'19.05.2021'),
		(22,33,900,'20.05.2021'),
		(33,11,500,'21.05.2021'),
		(33,22,750,'21.05.2021'),
		(11,44,300,'22.05.2021');

select *
from Transactions

select Receiver_ID-Sender_ID
from Transactions

select Receiver_ID, sum(amount)
from Transactions
group by Receiver_ID

select Sender_ID, sum(amount)
from Transactions
group by Sender_ID



select *
from	(select Receiver_ID, sum(amount) Recieved
		from Transactions
		group by Receiver_ID) AS A

full outer join (select Sender_ID, sum(amount) Send_
				from Transactions
				group by Sender_ID) AS B

on A.Receiver_ID = B.Sender_ID


select	coalesce(Receiver_ID, Sender_ID) as Account_ID
from	Transactions


select	*
from	Transactions

SELECT ISNULL(Recieved, 0) - ISNULL(Send_, 0)
from (select *
			from	(select Receiver_ID, sum(amount) Recieved
					from Transactions
					group by Receiver_ID) AS A

			full outer join (select Sender_ID, sum(amount) Send_
							from Transactions
							group by Sender_ID) AS B

			on A.Receiver_ID = B.Sender_ID ) as M



--------------------------------SOLUTION IS BELOW------------------------------


select		coalesce(Receiver_ID, Sender_ID) as Account_ID, ISNULL(Recieved, 0) - ISNULL(Send_, 0) as Net_Change
from		(select *
			from	(select Receiver_ID, sum(amount) Recieved
					from Transactions
					group by Receiver_ID) AS A

			full outer join (select Sender_ID, sum(amount) Send_
							from Transactions
							group by Sender_ID) AS B

			on A.Receiver_ID = B.Sender_ID ) as C