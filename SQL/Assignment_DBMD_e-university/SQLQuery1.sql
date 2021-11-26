

--DBMD LECTURE
--UNIVERSITY DATABASE PROJECT 



--CREATE DATABASE

CREATE DATABASE University
drop database University


--//////////////////////////////


--CREATE TABLES 


--Make sure you add the necessary constraints.
--You can define some check constraints while creating the table, but some you must define later with the help of a scalar-valued function you'll write.
--Check whether the constraints you defined work or not.
--Import Values (Use the Data provided in the Github repo). 
--You must create the tables as they should be and define the constraints as they should be. 
--You will be expected to get errors in some points. If everything is not as it should be, you will not get the expected results or errors.
--Read the errors you will get and try to understand the cause of the errors.


SELECT	*
FROM	source





------------------------------------------------


CREATE TABLE students	(student_ID				int		IDENTITY(1,1),
						student_first_name		varchar(20),
						student_last_name		varchar(20),
						registration_date		date,
						region					varchar(20),
						student_credit			int,
						PRIMARY KEY (student_ID),
						CHECK (student_credit<=180)
						)

INSERT INTO students (student_first_name, student_last_name, registration_date, region)
VALUES	
			('Alec',		'Hunter',		'12.05.2020', 'Wales'		),
			('Bronwin',		'Blueberry',	'12.05.2020', 'Scotland'	),
			('Charlie',		'Apricot',		'12.05.2020', 'England'		),
			('Ursula',		'Douglas',		'12.05.2020', 'Scotland'	),
			('Zorro',		'Apple',		'12.05.2020', 'England'		),
			('Debbie',		'Orange',		'12.05.2020', 'Wales'		)
			

SELECT	*
FROM	students


-------------------------------------------------------


CREATE TABLE staffs		(staff_ID				int		IDENTITY(1,1),
						staff_first_name		varchar(20),
						staff_last_name			varchar(20),
						region					varchar(20),
						PRIMARY KEY (staff_ID)
						)


INSERT INTO staffs (staff_first_name, staff_last_name, region)
VALUES	
			('October',		'Lime',			'Wales'		),
			('Ross',		'Island',		'Scotland'	),
			('Harry',		'Smith',		'England'	),
			('Neil',		'Mango',		'Scotland'	),
			('Kellie',		'Pear',			'England'	),
			('Victor',		'Fig',			'Wales'		),
			('Margeret',	'Nolan',		'England'	),
			('Yavette',		'Berry',		'Northern Ireland'	),
			('Tom',			'Garden',		'Northern Ireland'	)

SELECT	*
FROM	staffs

--------------------------------------------------------


CREATE TABLE courses	(course_ID				int		IDENTITY(1,1),
						staff_ID				int,
						course_name				varchar(20),
						course_credit			int,
						PRIMARY KEY (course_ID),
						FOREIGN KEY (staff_ID) REFERENCES staffs (staff_ID)
						)


INSERT INTO courses
SELECT	distinct(course),courseTutorfirstname
FROM	source
WHERE	course is not null


SELECT	*
FROM	courses

---------------------------------------------
						

CREATE TABLE counselor	(staff_ID				int,
						student_ID				int,
						region					varchar(20),
						PRIMARY KEY (staff_ID),
						FOREIGN KEY (student_ID) REFERENCES students (student_ID),
						FOREIGN KEY (staff_ID) REFERENCES staffs (staff_ID)
						)

select distinct(staff_ID), student_ID, a.region
from students a
full outer join staffs b
on a.region = b.region

-----------------------------

CREATE TABLE region		(region_ID				int		IDENTITY(1,1),
						region					varchar(20)
						)


INSERT INTO region (region)
VALUES	
			('England'), 
			('Scotland'),
			('Wales'),
			('Northern Ireland')

--------------------------------------------------------------


CREATE TABLE student_course		(student_ID				int,
								course_ID				int,
								PRIMARY KEY (student_ID),
								FOREIGN KEY (course_ID) REFERENCES courses(course_ID)
								)	


------------------------------------------------------------








--////////////////////


--CONSTRAINTS

--1. Students are constrained in the number of courses they can be enrolled in at any one time. 
--	 They may not take courses simultaneously if their combined points total exceeds 180 points.









--------///////////////////


--2. The student's region and the counselor's region must be the same.









--///////////////////////////////



------ADDITIONALLY TASKS



--1. Test the credit limit constraint.






--//////////////////////////////////

--2. Test that you have correctly defined the constraint for the student counsel's region. 






--/////////////////////////


--3. Try to set the credits of the History course to 20. (You should get an error.)





--/////////////////////////////

--4. Try to set the credits of the Fine Arts course to 30.(You should get an error.)





--////////////////////////////////////

--5. Debbie Orange wants to enroll in Chemistry instead of German. (You should get an error.)








--//////////////////////////


--6. Try to set Tom Garden as counsel of Alec Hunter (You should get an error.)





--/////////////////////////

--7. Swap counselors of Ursula Douglas and Bronwin Blueberry.






--///////////////////


--8. Remove a staff member from the staff table.
--	 If you get an error, read the error and update the reference rules for the relevant foreign key.





 



















