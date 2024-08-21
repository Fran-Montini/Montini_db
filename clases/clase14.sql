#1
SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS 'Name',
    ad.address,
    ci.city
FROM customer c
    INNER JOIN store sto USING(store_id)
    INNER JOIN address ad ON sto.address_id = ad.address_id
    INNER JOIN city ci USING(city_id)
    INNER JOIN country co USING(country_id)
WHERE co.country = 'Argentina';

#2  
SELECT
    f.title,
    l.name,
    f.rating,
    CASE
        WHEN f.rating LIKE 'G' THEN 'All ages admitted'
        WHEN f.rating LIKE 'PG' THEN 'Some material may not be suitable for children'
        WHEN f.rating LIKE 'PG-13' THEN 'Some material may be inappropriate for children under 13'
        WHEN f.rating LIKE 'R' THEN 'Under 17 requires accompanying parent or adult guardian'
        WHEN f.rating LIKE 'NC-17' THEN 'No one 17 and under admitted'
    END 'Rating Text'
FROM film f
INNER JOIN language l USING(language_id);

#3 
SELECT  CONCAT(ac.first_name, ' ', ac.last_name) AS 'actor',
        f.title AS 'film',
        f.release_year AS 'release_year'
FROM film f
INNER JOIN film_actor USING(film_id)
INNER JOIN actor ac USING(actor_id)
WHERE CONCAT(first_name, ' ', last_name) LIKE TRIM(UPPER('AUDREY BAILEY'));

#4
SELECT  f.title,
        r.rental_date,
        c.first_name AS 'customer_name',
        CASE
            WHEN r.return_date IS NOT NULL THEN 'Yes'
            ELSE 'No'
        END 'Returned'
FROM rental r
INNER JOIN inventory i USING(inventory_id)
INNER JOIN film f USING(film_id)
INNER JOIN customer c USING(customer_id)
WHERE MONTH(r.rental_date) = '05' OR MONTH(r.rental_date) = '06'
ORDER BY r.rental_date;



SELECT title, CAST(length AS CHAR(10)) AS length_text
FROM film
LIMIT 10;

SELECT CONVERT(title USING utf8) AS title_utf8, rental_rate
FROM film
LIMIT 10;