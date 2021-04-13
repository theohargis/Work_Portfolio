/*
Aggregate Function + Subquery

01 - Return a film's title, length, the average length for 
all films with a subquery, and if the film's length is less 
than the average
*/
SELECT 
	title,
	length,
	(
		SELECT 
			AVG(length)
		FROM film
	) AS avg_film_length,
	length < 
	(
		SELECT 
			AVG(length)
		FROM film
	) AS length_less_than_avg
FROM film;

SELECT 
	AVG(length)
FROM film;



-- AGGREGATE FUNCTIONS

/*
Aggregate Function + Window Function

02 - Return a film's title, length, the average length for 
all films with a window function, and if the film's length 
is less than the average
*/
SELECT 
	title,
	length,
	AVG(length) OVER () AS avg_length_for_all_films,
	length  < AVG(length) OVER () AS length_less_than_avg_for_all_films,
	COUNT(length) OVER () AS count_film_length,
	MIN(length) OVER () AS minimum_film_length,
	MAX(length) OVER () AS maximum_film_length,
	SUM(length) OVER () AS total_film_length
FROM film;

/*
Aggregate Function + Window Function + PARTITION BY

03 - Return the film title, length, and the average length per rating
*/
SELECT 
	title,
	length,
	rating,
	AVG(length) OVER (
		PARTITION BY rating
	) AS avg_length_per_rating
FROM film;

/*
PARTITION BY Multiple Columns

04 - Return the film title, length, rating, rental_duration, 
and the average length per rating and rental_duration
*/
SELECT 
	title,
	length,
	rating,
	rental_duration,
	AVG(length) OVER (
		PARTITION BY 
			rating,
			rental_duration
	) AS avg_length_per_rating_and_rental_duration
FROM film;

-- RANKING FUNCTIONS

/*
ROW_NUMBER() - Number of current row within its partition

05 - Return the row number, title, rating, length for all films sorted by length within a rating partition
	 Window: all rows
*/
SELECT 
	ROW_NUMBER() OVER (
		PARTITION BY
			rating
		ORDER BY 
			`length`
	) AS row_num,
	title,
	rating,
	`length`
FROM film;

/*
06 - Rank G-rated Films Based on Length

ROW_NUMBER() doesn't have duplicates
1,2,3,4,5

RANK() has duplicates and sequence gaps
1,2,2,4,5

DENSE_RANK() has duplicates but NO sequence gaps
1,2,2,3,4

PERCENT_RANK() - row's percentile
- percentage of values < the current row
- values range from 0 to 1 

CUME_DIST() - cumulative distribution
- percentage of values <= to the current row
*/
SELECT
	title,
	length,
	ROW_NUMBER() OVER (
		ORDER BY length
	) AS length_row_num,
	RANK() OVER (
		ORDER BY length
	) AS length_rank,
	DENSE_RANK() OVER (
		ORDER BY length 
	) AS length_dense_rank,
	PERCENT_RANK() OVER (
		ORDER BY length 
	) AS length_percent_rank, -- less than current row
	CUME_DIST() OVER (
		ORDER BY length
	) AS length_cume_dist -- less than or equal to current row
FROM film
WHERE rating = 'G';
/*
PARTITION BY + ORDER BY

07 - Return the row number, title, rating, and length for all films
	 Reset the row number when the rating changes (each rating will have its own set of row numbers)
	 Sort results within the window by the film's length
	 Window: by rating
*/
SELECT 
	ROW_NUMBER() OVER (
		PARTITION BY rating
		ORDER BY `length`
	) AS row_num,
	title,
	rating,
	`length`
FROM film;

/*
Filter by window function output with a CTE

08 - Return the title, rating, and length for the films shortest in length per rating

	 1. Create a CTE to hold the ranked results
	 2. Query the CTE based on the rank number
*/
WITH length_ranked_films AS (
	SELECT
		RANK() OVER (
			PARTITION BY rating
			ORDER BY length 
		) AS length_rank,
		title,
		rating,
		length 
	FROM film
)
SELECT *
FROM length_ranked_films 
WHERE length_rank = 1;

/*
09 - Select a film's title, rating, length, and the following per rating
	 Order matters
	 	FIRST_VALUE()
	 	LAST_VALUE()
	 Order does NOT matter
		MIN()
		MAX()
 */
SELECT 
	title,
	rating,
	length,
	FIRST_VALUE(length) OVER (
		PARTITION BY rating
		ORDER BY length
	) AS first_film_length,
	LAST_VALUE(length) OVER (
		PARTITION BY rating
		ORDER BY length
		RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING 
	) AS last_film_length,
	MIN(length) OVER (
		PARTITION BY rating
	) AS min_film_length,
	MAX(length) OVER (
		PARTITION BY rating
	) AS max_film_length
FROM film;

/*
Period-Over-Period Analysis with LAG()

10 - Calculate the month-over-month rental revenue % growth for 2005
	 1. Create GROUP BY to get per month revenue
	 2. Get previous month's revenue with the LAG() window function
	    LAG() accesses a previous row
	 3. Calculate revenue % growth
	    ((current revenue - previous month's revenue) / previous month's revenue) * 100
*/
SELECT 
	LEFT(payment_date, 7) AS payment_month,
	SUM(amount) AS revenue,
	LAG(SUM(amount), 1) OVER (
		ORDER BY LEFT(payment_date, 7)
	) AS previous_month_revenue,
		(SUM(amount) - LAG(SUM(amount), 1) OVER (ORDER BY LEFT(payment_date, 7))) 
	/ 
		LAG(SUM(amount), 1) OVER (ORDER BY LEFT(payment_date, 7)) * 100 AS monthly_revenue_increase
FROM payment 
WHERE payment_date BETWEEN '2005-01-01' AND '2005-12-31 23:59:59'
GROUP BY payment_month;

/*
Calculating Running Totals

11 - Calculate the running revenue total when selecting the payment_id, payment_date, amount for 2005-05-24

	 Order matters when calculating running totals
*/
SELECT 
	payment_id,
	payment_date,
	amount,
	SUM(amount) OVER (
		ORDER BY payment_date
	) AS running_total
FROM payment
WHERE payment_date BETWEEN '2005-05-24' AND '2005-05-24 23:59:59';

/*
Calculating Running Totals for GROUPed Data

12 - Calculate the running revenue total for revenue GROUPed BY the payment date day for 2005
	 Return the day, revenue for the day, and the running total up until the current day in the result
	
	 1. Create a CTE to hold the GROUPed BY payment date day results
	 2. Query the CTE and do a SUM() window function on the revenue to get the running total
	
	 Remember, order matters
*/
WITH rental_revenue_by_day AS (
	SELECT 
		DATE(payment_date) AS payment_date_day,
		SUM(amount) AS revenue
	FROM payment 
	WHERE payment_date BETWEEN '2005-01-01' 
		AND '2005-12-31 23:59:59'
	GROUP BY payment_date_day
	ORDER BY payment_date_day
)
SELECT 
	payment_date_day,
	revenue,
	SUM(revenue) OVER (
		ORDER BY payment_date_day
	) AS running_revenue_total
FROM rental_revenue_by_day;
	

/*
Per Group Ranking

13 - Rank films within their genre based on their rental count
	 Use DENSE_RANK()

	 The rank should reset when moving onto the next genre
	 
	 film
	 	film_id
	 film_category
	 	category_id
	 category
	 	film_id
	 inventory
	 	inventory_id
	 rental
*/
SELECT 
	f.title,
	c.name AS genre,
	COUNT(r.rental_id) AS rental_count,
	DENSE_RANK() OVER (
		PARTITION BY c.name
		ORDER BY COUNT(r.rental_id) DESC
	) AS rental_rank
FROM film f
JOIN film_category fc 
	ON f.film_id = fc.film_id
JOIN category c 
	ON fc.category_id = c.category_id
JOIN inventory i 
	ON f.film_id = i.film_id
JOIN rental r 
	ON i.inventory_id = r.inventory_id
GROUP BY f.title;
	
	

/*
Get the Top # Per Group

14 - Get the top 3 rented films per genre

	 1. Create a CTE with the previous query
	 2. Query the CTE and filter based on the rental rank
*/
WITH rentals_rank AS (
	SELECT 
		f.title,
		c.name AS genre,
		COUNT(r.rental_id) AS rental_count,
		DENSE_RANK() OVER (
			PARTITION BY c.name
			ORDER BY COUNT(r.rental_id) DESC
		) AS rental_rank
	FROM film f
	JOIN film_category fc 
		ON f.film_id = fc.film_id
	JOIN category c 
		ON fc.category_id = c.category_id
	JOIN inventory i 
		ON f.film_id = i.film_id
	JOIN rental r 
		ON i.inventory_id = r.inventory_id
	GROUP BY f.title
)
SELECT *
FROM rentals_rank
WHERE rental_rank <= 3;





