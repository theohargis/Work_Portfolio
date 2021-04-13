
-- sakila database

/*
1. Select all columns from the film table for PG-rated films. (1 point)
*/
SELECT *
FROM film
WHERE rating = 'PG';

/*
2. Select the customer_id, first_name, and last_name for the active customers (0 means inactive). 
Sort the customers by their last name and restrict the results to 10 customers. (1 point)
*/
SELECT customer_id, first_name, last_name
FROM customer 
WHERE active = 1
ORDER BY last_name
LIMIT 10;

/*
3. Select customer_id, first_name, and last_name for all customers where the last name is Clark. (1 point)
*/
SELECT customer_id, first_name, last_name 
FROM customer
WHERE last_name = 'Clark';

/*
4. Select film_id, title, rental_duration, and description for films with a rental duration of 3 days. (1 point)
*/
SELECT film_id, title, rental_duration, description
FROM film
WHERE rental_duration = 3;

/*
5. Select film_id, title, rental_rate, and rental_duration for films that can be rented for more than 1 day 
and at a cost of $0.99 or more. Sort the results by rental_rate then rental_duration. (2 points)
*/
SELECT film_id, title, rental_rate, rental_duration 
FROM film
WHERE rental_duration > 1
	AND replacement_cost >= 0.99
ORDER BY rental_rate, rental_duration;

/*
6. Select film_id, title, replacement_cost, and length for films that cost 9.99 or 10.99 to replace 
and have a running time of 60 minutes or more. (2 points)
*/
SELECT film_id, title, replacement_cost, length
FROM film
WHERE (replacement_cost = 9.99
	OR replacement_cost = 10.99)
	AND length >= 60;

/*
7. Select film_id, title, replacement_cost, and rental_rate for films that cost $20 or more to replace 
and the cost to rent is less than a dollar. (2 points)
*/
SELECT film_id,title, replacement_cost, rental_rate
FROM film
WHERE replacement_cost >= 20
	AND rental_rate < 1;

/*
8. Select film_id, title, and rating for films that do not have a G, PG, and PG-13 rating.  
Do not use the OR logical operator. (2 points)
*/
SELECT film_id, title, rating 
FROM film 
WHERE rating NOT IN ('G', 'PG', 'PG-13');

/*
9. How many films can be rented for 5 to 7 days? Your query should only return 1 row. (2 points)
*/
SELECT COUNT(*) as 'NumOfFilms'
FROM film
WHERE rental_duration BETWEEN 5 
	AND 7;

/*
10. INSERT your favorite movie into the film table. You can arbitrarily set the column values as long as they are related to the column. Only assign values to columns that are not automatically handled by MySQL. (2 points)
*/
-- DESCRIBE film;
INSERT INTO film (
	title, 
	release_year, 
	language_id, 
	rental_duration, 
	rental_rate, 
	length, 
	replacement_cost, 
	last_update
	)
VALUES (
	'Motorcycle Diaries',
	2004,
	1,
	12,
	5.99,
	126,
	12.99,
	'2006-02-15 05:03:42'
	);
/*
SELECT *
FROM film
WHERE title = 'Motorcycle Diaries';
*/

/*
11. INSERT your two favorite actors/actresses into the actor table with a single SQL statement. (2 points)
*/
-- DESCRIBE actor;
INSERT INTO actor (
	first_name,
	last_name
	)
VALUES 
	('Pedro', 'Pascal'),
	('Daveed', 'Diggs');

/*
SELECT *
FROM actor
WHERE last_name = 'Pascal'
	OR last_name = 'Diggs';
*/

/*
12. The address2 column in the address table inconsistently defines what it means to not have an address2 associated 
with an address. UPDATE the address2 column to an empty string where the address2 value is currently null. (2 points)
*/
-- DESCRIBE address;
UPDATE address 
SET address2 = ''
WHERE address2 IS NULL;

/*
SELECT *
FROM address
WHERE address2 IS NULL;
-- returns 0 rows
*/

/*
13. For rated G films less than an hour long, update the special_features column to replace Commentaries with Audio Commentary. 
Be sure the other special features are not removed. (2 points)
*/
UPDATE film 
SET special_features = REPLACE(special_features, 'Commentaries', 'Audio Commentary')
WHERE rating = 'G';

/*
SELECT special_features
FROM film
WHERE special_features LIKE '%Commentaries%'
	AND rating = 'G';
-- returns 0 rows
*/

-- LinkedIn database

/*
14. Create a new database named LinkedIn. You will still need to use  LMU.build to create the database. (1 point)
*/
-- database created!

/*
15. Create a user table to store LinkedIn users. 
The table must include 5 columns minimum with the appropriate data type and a primary key. 
One of the columns should be Email and must be a unique value. (3 points)
*/
CREATE TABLE user (
    userID int NOT NULL PRIMARY KEY,
    LastName varchar(50) NOT NULL,
    FirstName varchar(50),
    phoneNum varchar(15),
    email varchar(100)
);

/*
16. Create a table to store a user's work experience. The table must include a primary key, 
a foreign key column to the user table, and have at least 5 columns with the appropriate data type. (3 points)
*/
CREATE TABLE experience (
    userID int NOT NULL,
    expID int NOT NULL,
    yearsWorked int,
    fieldOfWork varchar(100),
    city varchar(50),
    state char(2),
    PRIMARY KEY (expID),
    FOREIGN KEY (userID) REFERENCES user(userID)
);

/*
17. INSERT 1 user into the user table. (2 points)
*/
-- DESCRIBE user;
INSERT INTO user (
	userID,
	LastName,
	FirstName,
	phoneNum,
	email
)
VALUES (
	1,
	'Bundy',
	'Ted',
	'650-100-5432',
	'tbundy@gmail.com'
);

/*
18. INSERT 1 work experience entry for the user just inserted. (2 points)
*/
-- DESCRIBE experience;
INSERT INTO experience 
VALUES (
	1,
	1,
	3,
	'assassin',
	'Los Angeles',
	'CA'
);

-- SpecialtyFood Database

/*
19. The warehouse manager wants to know all of the products the company carries. 
Generate a list of all the products with all of the columns. (1 point)
*/
-- DESCRIBE Products;
SELECT *
FROM Products;

/*
20. The marketing department wants to run a direct mail marketing campaign to its American, Canadian, and Mexican customers. 
Write a query to gather the data needed for a mailing label. (2 points)
*/
-- DESCRIBE Customers;
SELECT ContactName, Address, City, Region, PostalCode, Country
FROM Customers
WHERE Country IN ('USA', 'Canada', 'Mexico');

/*
21. HR wants to celebrate hire date anniversaries for the sales representatives in the USA office. 
Develop a query that would give HR the information they need to coordinate hire date anniversary gifts. 
Sort the data as you see best fit. (2 points)
*/
-- DESCRIBE Employees;
SELECT EmployeeID, LastName, FirstName, Title, HireDate, Country
FROM Employees
WHERE Country = 'USA'
ORDER BY HireDate, LastName;

/*
22. What is the SQL command to show the structure for the Shippers table? (1 point)
*/
DESCRIBE Shippers;

/*
23. Customer service noticed an increase in shipping errors for orders handled by the employee, Janet Leverling. 
Return the OrderIDs handled by Janet so that the orders can be inspected for other errors. (2 points)
*/
-- DESCRIBE Orders;
-- Janet's EmployeeID is 3
SELECT OrderID
FROM Orders
WHERE EmployeeID = 3;

/*
24. The sales team wants to develop stronger supply chain relationships with its suppliers by reaching out 
to the managers who have the decision making power to create a just-in-time inventory arrangement. 
Display the supplier's company name, contact name, title, 
and phone number for suppliers who have manager or mgr in their title. (2 points)
*/
-- DESCRIBE Suppliers;
SELECT CompanyName, ContactName, ContactTitle, Phone 
FROM Suppliers
WHERE ContactTitle LIKE '%manager%' 
	OR ContactTitle LIKE '%mgr%';

/*
25. The warehouse packers want to label breakable products with a fragile sticker. 
Identify the products with glasses, jars, or bottles and are not discontinued (0 = not discontinued). (2 points)
*/
-- DESCRIBE Products;

SELECT *
FROM Products
WHERE (QuantityPerUnit LIKE ('%glass%')
	OR QuantityPerUnit LIKE ('%jar%')
	OR QuantityPerUnit LIKE ('%bottle%'))
	AND Discontinued = 0;
	

/*
26. How many customers are from Brazil and have a role in sales? Your query should only return 1 row. (2 points)
*/
SELECT COUNT(*)
FROM Customers
WHERE Country = 'Brazil'
	AND ContactTitle LIKE ('%sales%');

/*
27. Who is the oldest employee in terms of age? Your query should only return 1 row. (2 points)
*/
SELECT EmployeeID, LastName, FirstName, MIN(BirthDate)
FROM Employees;

/*
28. Calculate the total order price per order and product before and after the discount.
 The products listed should only be for those where a discount was applied. 
 Alias the before discount and after discount expressions. (3 points)
*/
SELECT OrderID, ProductID, (UnitPrice * Quantity) AS 'TotalPrice', (UnitPrice * Quantity - Discount) AS 'FinalDiscountedPrice'
FROM OrderDetails
WHERE Discount > 0
GROUP BY ProductID
ORDER BY OrderID;

/*
29. To assist in determining the company's assets, find the total dollar value for all products in stock. 
Your query should only return 1 row.  (2 points)
*/
SELECT (SUM(UnitPrice * UnitsInStock)) AS 'ValueInStock'
FROM Products;

/*
30. Supplier deliveries are confirmed via email and fax. 
Create a list of suppliers with a missing fax number to help the warehouse receiving team identify who to contact 
to fill in the missing information. (2 points)
*/
SELECT *
FROM Suppliers
WHERE Fax IS NULL;

/*
31. The PR team wants to promote the company's global presence on the website. 
Identify a unique and sorted list of countries where the company has customers. (2 points)
*/
SELECT DISTINCT(Country)
FROM Customers
ORDER BY Country;

/*
32. List the products that need to be reordered from the supplier. 
Know that you can use column names on the right-hand side of a comparison operator. 
Disregard the UnitsOnOrder column. (2 points)
*/
SELECT ProductID, ProductName, SupplierID, UnitsInStock 
FROM Products
WHERE UnitsInStock <= ReorderLevel
ORDER BY UnitsInStock;

/*
33. You're the newest hire. INSERT yourself as an employee with the INSERT … SET method. 
You can arbitrarily set the column values as long as they are related to the column. 
Only assign values to columns that are not automatically handled by MySQL. (2 points)
*/
-- DESCRIBE Employees;
INSERT INTO Employees 
SET
	LastName = 'Hargis',
	FirstName = 'Theo',
	Title = 'Intern',
	BirthDate = '2000-08-01 00:00:00',
	HireDate = CURRENT_TIMESTAMP(),
	City = 'Los Angeles',
	Region = 'CA',
	PostalCode = '90045',
	Country = 'USA'
;

/*
34. The supplier, Bigfoot Breweries, recently launched their website. UPDATE their website to bigfootbreweries.com. (2 points)
*/
-- DESCRIBE Suppliers;
UPDATE Suppliers
SET
	HomePage = 'bigfootbreweries.com'
WHERE CompanyName = 'Bigfoot Breweries';
	

/*
35. The images on the employee profiles are broken. 
The link to the employee headshot is missing the .com domain extension. 
Fix the PhotoPath link so that the domain properly resolves. 
Broken link example: http://accweb/emmployees/buchanan.bmp (2 points)
*/
UPDATE Employees 
SET
	PhotoPath = REPLACE(PhotoPath, 'bmp', 'com');



-- Custom Data Requests

/*
Data Request 1
Question: What country are most of the company's customers situated in? List the Country name 
and count of customers living there.

Business Justification
This is important information for the company to know as it can help them focus in their Marketing efforts to one region,
as well as give them insight into where they need the biggest/most secure supply chain,
*/
SELECT Country, COUNT(DISTINCT(CustomerID)) AS 'NumOfCustomers'
FROM Customers
GROUP By Country
ORDER BY NumOfCustomers DESC;

/*
Data Request 2
Question: Which country receives the most orders of the company's products? 
List the country name and the count of orders per country.

Business Justification
While knowing how many customers are located in every country is important, the quantity of orders per country
is a better indicator of sales volume in each geographic region.
*/
SELECT ShipCountry , COUNT(DISTINCT(OrderID)) AS 'NumOfOrders'
FROM Orders
GROUP BY ShipCountry  
ORDER BY NumOfOrders DESC;

/*
Data Request 3
Question: What are the company's top 5 best selling products? 
List the productID, product name, and the total quantity ordered ever.

Business Justification
Knowing the most successful products is vital information for the company as they
can use this information to further direct their marketing based on specific products and markets.
*/
SELECT od.ProductID, p.ProductName, SUM(Quantity) AS 'TotalUnitsSold'
FROM OrderDetails od 
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY ProductID
ORDER BY TotalUnitsSold DESC
LIMIT 5;

/*
Data Request 4
Question: Which product categories does the company have the most sales in?
List the category ID, category name, and total sales ever.

Business Justification
This information is useful for the company to understand the different segments of their business,
what they produce, and where they fall in terms of industry segment.
*/
SELECT 
	c.CategoryID, 
	c.CategoryName, 
	SUM(od.Quantity * od.UnitPrice) AS 'TotalSales'
FROM Categories c 
JOIN Products p 
	ON c.CategoryID = p.CategoryID
JOIN OrderDetails od 
	ON p.ProductID =od.ProductID
GROUP BY c.CategoryID
ORDER BY TotalSales DESC;


/*
Data Request 5
Question: What is the average discount per product?
List the productID, product name, and average discount of said product

Business Justification
This will help the business understand which products of theirs are they selling at a discounted rate the most
to their customers, which can potentially help them with other financial calculations like total gross revenue 
pertaining to the product
*/
SELECT 
	p.ProductID, 
	p.ProductName, 
	AVG(od.Discount) AS 'AvgDiscount'
FROM OrderDetails od 
JOIN Products p 
	ON od.ProductID = p.ProductID 
GROUP BY p.ProductID
ORDER BY AvgDiscount DESC;


/*
Data Request 6
Question: Which products have 10 or more units in stock and
have been discontinued? List the ProductID, productname, and stock level.

Business Justification
This is important for the company to know how much of their stock has been discontinued and
is using up vital inventory space.
*/
SELECT ProductID, ProductName, UnitsInStock 
FROM Products 
WHERE UnitsInStock >= 10
	AND discontinued = 1;

	