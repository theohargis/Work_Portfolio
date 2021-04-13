-- VIEW

-- Create a VIEW to hold the results for the order count and revenue per day, category, and product name for all dates
CREATE OR REPLACE VIEW DailyRevenue AS
	SELECT
		DATE(OrderDate) AS OrderDateDay,
		CategoryDescription AS Category,
		ProductName,
		p.ProductNumber,
		SUM(QuotedPrice * QuantityOrdered) AS Revenue,
		COUNT(DISTINCT(o.OrderNumber)) AS OrderCount -- Need distinct b/c multiple entries per order in Order_Details
	FROM Orders o
	JOIN Order_Details od
		ON o.OrderNumber = od.OrderNumber
	JOIN Products p
		ON od.ProductNumber = p.ProductNumber 
	JOIN Categories c 
		ON p.CategoryID = c.CategoryID 
	GROUP BY 
		OrderDateDay,
		ProductName;

-- Using the VIEW, return the days and order count where 
-- the order count for products in the bikes category was greater than 2
SELECT *
FROM DailyRevenue
WHERE OrderCount > 2
	AND Category = 'Bikes';


-- Common Table Expression (CTE)

-- 01 - Using a CTE instead of a VIEW, return the dates and order count 
-- where the order count for products in the bikes category was greater than 2
WITH DailyRevenueCTE AS (
SELECT
		DATE(OrderDate) AS OrderDateDay,
		CategoryDescription AS Category,
		ProductName,
		p.ProductNumber,
		SUM(QuotedPrice * QuantityOrdered) AS Revenue,
		COUNT(DISTINCT(o.OrderNumber)) AS OrderCount -- Need distinct b/c multiple entries per order in Order_Details
	FROM Orders o
	JOIN Order_Details od
		ON o.OrderNumber = od.OrderNumber
	JOIN Products p
		ON od.ProductNumber = p.ProductNumber 
	JOIN Categories c 
		ON p.CategoryID = c.CategoryID 
	GROUP BY 
		OrderDateDay,
		ProductName
)
SELECT *
FROM DailyRevenueCTE
WHERE OrderCount > 2
	AND Category = 'Bikes';

-- 02 - What is the average daily revenue per product?
-- Without a CTE, you can't combine aggregate queries, i.e. AVG(SUM(QuotedPrice * QuantityOrdered))
WITH DailyRevenueCTE AS (
SELECT
		DATE(OrderDate) AS OrderDateDay,
		CategoryDescription AS Category,
		ProductName,
		p.ProductNumber,
		SUM(QuotedPrice * QuantityOrdered) AS Revenue,
		COUNT(DISTINCT(o.OrderNumber)) AS OrderCount -- Need distinct b/c multiple entries per order in Order_Details
	FROM Orders o
	JOIN Order_Details od
		ON o.OrderNumber = od.OrderNumber
	JOIN Products p
		ON od.ProductNumber = p.ProductNumber 
	JOIN Categories c 
		ON p.CategoryID = c.CategoryID 
	GROUP BY 
		OrderDateDay,
		ProductName
)
SELECT 
	ProductName,
	AVG(Revenue) AS AvgDailyRevenue
FROM DailyRevenueCTE
GROUP BY ProductName
ORDER BY AvgDailyRevenue DESC;



