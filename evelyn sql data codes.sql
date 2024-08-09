select * from "SalesData"

--Combine first_name and last_name from the customer table to become full_name	

select "FirstName", "LastName", concat("FirstName", '  ', "LastName") as full_name
from "SalesData";

--Extract the username from email address and alias it UserName

select "Email", upper(split_part("Email",'@',1)) as username
from "SalesData";

--Extract the Domain name from email address and alias it DomainName

select "Email", upper(split_part("Email",'@',2)) as DomainName
from "SalesData";

--Find the age of each customer from DOB

select "DOB", Age(Cast("DOB" as DATE)) as AGE
from "SalesData";

--Implement the following price structure in Amount column. If the amount is <=20 decrease
--by 20% , if the amount is between 21 and 50 increase by 5%, if amount is between 51 and 80 
--reduce by £20 for other leave the amount as they are

select "FirstName", "Amount", 
	case when "Amount" <= 20 then "Amount" * 0.8
		when "Amount" <= 50 then  "Amount" * 1.05
		when "Amount" <= 80 then  "Amount" -20
		else "Amount" end as No_change
from "SalesData";


--Concatenate Firstname and lastNames Initial eg Mark K

select "FirstName", "LastName", concat("FirstName", '  ', left ("LastName", 1))
from "SalesData";

--Concatenate ID and Last Name

select "ID", "LastName", concat("ID", '  ', "LastName")
from "SalesData";

--Using Color and Amount Column to Implement the following price structure

SELECT 
CASE WHEN "Color" = 'Black' THEN "Amount" + 1
	 WHEN "Color" = 'Silver' THEN "Amount" * 0.8
	 WHEN "Color" = 'Multi' THEN "Amount" + 2
	 WHEN "Color" = 'White' THEN "Amount" + 21
	ELSE "Amount" END AS No_change
from "SalesData";

--Show all data where colour is BLUE or Multi and ID between 10 and 60	

SELECT *
FROM "SalesData"
WHERE ("Color" ='blue' OR "Color" = 'multi')
AND "ID" BETWEEN 10 and 60;

--write a query to return the sum of the amount

select sum("Amount") as sum_amt
from "SalesData"; 

--Find total amount by  Product_Subcategory

SELECT "Product_Subcategory",
SUM("Amount") AS Subcategory_Total_Amount
FROM "SalesData"
group by "Product_Subcategory";


--Find total amount by  Product_Subcategory, colour and Product_Subcategory	

SELECT "Color", "Product_Subcategory",
SUM("Amount") AS Subcategory_Total_Amount
FROM "SalesData"
GROUP BY 
"Color", "Product_Subcategory";


CREATE TABLE IF NOT EXISTS Employees
(
 EmployeeID integer,
 FirstName character varying (50),
 LastName character varying (50),
 DepartmentID integer
 );
INSERT INTO Employees(
EmployeeID, FirstName, LastName, DepartmentID)
VALUES (1, 'John', 'Doe',1),
	(2, 'Jane', 'Smith', 2),
	(3, 'Mark', 'Johnson', 3),
	(4, 'Emily', 'Brown', 2),
	(5, 'Michael', 'Clark', 1),
	(6, 'Susan', 'Lee', 3);

CREATE TABLE IF NOT EXISTS Departments
(
 DepartmentID integer,
 DepartmentName character varying (50)
 );
INSERT INTO departments(
departmentid, departmentname)
VALUES (1, 'Sales'),
	(2, 'Marketing'),
	(3, 'Engineering'),
	(4, 'Finance'),
	(5, 'Operations');

CREATE TABLE IF NOT EXISTS Salaries
(
 EmployeeID integer,
 Salary Decimal(10,2),
EffectiveDate Date
 );
INSERT INTO Salaries(
EmployeeID, Salary, EffectiveDate)
VALUES (1, 40000.00, '01/01/2013'),
	(2, 50000.00, '02/01/2014'),
	(3, 35000.00, '03/01/2015'),
	(4, 45000.00, '05/12/2018'),
	(5, 42000.00, '06/11/2019'),
	(6, 38000.00, '07/07/2017');

--Write a query to retrieve all the employees along with their corresponding department names and salaries in GBP (£)

SELECT E.employeeid, E.firstname, E.lastname, E.departmentid, D.departmentname, S.salary, S.effectivedate
FROM
employees AS E
JOIN
Departments AS D
ON
D.DepartmentID =E.DepartmentID
JOIN
Salaries AS S
ON
S.EmployeeID = E.EmployeeID;


--Write a query to calculate the average salary of all employees in GBP (£).

SELECT AVG(S.Salary) AS Average_Salary
FROM Employees AS E
JOIN
Departments AS D
ON
D.DepartmentID =E.DepartmentID
JOIN
Salaries AS S
ON
S.Employeeid = E.Employeeid;

--Write a query to retrieve the employee with the highest salary in GBP (£).


SELECT *
FROM
Employees AS E
JOIN
Departments AS D
ON
D.Departmentid =E.Departmentid
JOIN
Salaries AS S
ON
S.EmployeeID = E.EmployeeID
ORDER BY S.Salary DESC
limit 1

