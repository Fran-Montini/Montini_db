#1
CREATE OR REPLACE VIEW LIST_OF_CUSTOMERS AS 
	select
	    c.customer_id,
	    concat(c.first_name, ' ', c.last_name),
	    a.address,
	    a.postal_code,
	    a.phone,
	    ci.city,
	    ct.country,
	    CASE
	        WHEN c.active = 1 THEN 'active'
	        ELSE 'inactive'
	    END AS status,
	    c.store_id
	from customer c
	    inner join address a USING(address_id)
	    inner join city ci USING (city_id)
	    inner join country ct USING (country_id);
; 

select * from list_of_customers;

#2
CREATE or REPLACE VIEW FILM_DETAILS AS 
	SELECT
	    f.film_id,
	    f.title,
	    f.description,
	    c.name AS Categoria,
	    f.rental_rate AS Precio,
	    f.length AS Duracion,
	    f.rating,
	    GROUP_CONCAT(a.first_name, ' ', a.last_name) AS Actores
	FROM film f
	    INNER JOIN film_category fc using (film_id)
	    INNER JOIN category c USING (category_id)
	    INNER JOIN film_actor fa USING(film_id)
	    INNER JOIN actor a USING(actor_id)
	GROUP BY  f.film_id, f.title, f.description, c.name, f.rental_rate, f.length, f.rating;

SELECT * from `FILM_DETAILS`;

#3
CREATE OR REPLACE VIEW sales_by_film_category AS
SELECT
    c.name AS category,
    SUM(f.rental_rate) AS total
FROM film f
    JOIN film_category USING (film_id)
    JOIN category c USING (category_id)
    JOIN inventory i USING (film_id)
    JOIN rental r USING (inventory_id)
GROUP BY c.name;

SELECT * from sales_by_film_category;

#4
CREATE OR REPLACE VIEW actor_information AS
SELECT
    a.actor_id AS actor_id,
    a.first_name AS first_name,
    a.last_name AS last_name,
    COUNT(fa.film_id) AS "Peliculas actuadas"
FROM actor a
    INNER JOIN film_actor fa USING(actor_id)
GROUP BY
    a.actor_id, a.first_name, a.last_name;

select * from actor_information;


#La vista actor_information consiste en el primer nombre y el apellido del actor, así como el número de películas en las que ha actuado.
#Esta vista realizará un JOIN entre actor y film_actor con un INNER JOIN en actor_id y utiliza un COUNT para determinar cuántas películas tiene cada actor. 
#Un GROUP BY prepara los datos por un actor específico, 
#de modo que esta información pueda ser fácilmente y rápidamente accedida en el futuro.



#Las Materialized views son objetos de base de datos que almacenan de forma persistente el resultado de una consulta, 
#mejorando así el rendimiento al acceder a datos precomputados y reduciendo la carga en el servidor. 
#Son especialmente útiles para consultas complejas y facilitan el acceso a datos preagregados. 
#Entre sus alternativas se encuentran las vistas convencionales, que no almacenan datos y requieren cálculos en tiempo real, 
#así como las tablas temporales y el almacenamiento en caché. Estas vistas son compatibles con varios sistemas de gestión de bases de datos, 
#como Oracle, PostgreSQL, Microsoft SQL Server (con "Indexed Views") e IBM Db2, lo que las convierte en herramientas valiosas 
#para optimizar el rendimiento en bases de datos.
