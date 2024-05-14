USE sakila;
#1-Encuentra las películas de menor duración, muestra el título y calificación.

SELECT title,rating FROM film
WHERE `length` = (SELECT MIN(`length`)
FROM film);

#2-Escriba una consulta que devuelva el título de la película cuya duración es la más baja. Si hay más de una película con la duración más baja, la consulta devuelve un conjunto de resultados vacío.

SELECT title, rating FROM film
WHERE length = (SELECT DISTINCT length FROM film ORDER BY length ASC LIMIT 1);

#3-Genera un informe con un listado de clientes mostrando los pagos más bajos realizados por cada uno de ellos. Muestre la información del cliente, la dirección y el monto más bajo, proporcione ambas soluciones usando TODOS y/o ANY y MIN.

 ANY and MIN.
SELECT c.customer_id, c.first_name, c.last_name, a.address, MIN(p.amount) AS lowest_payment
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN payment p  ON c.customer_id = p.customer_id
GROUP BY  c.customer_id, c.first_name, c.last_name, a.address
HAVING MIN(p.amount) = ANY (SELECT amount FROM payment WHERE customer_id = c.customer_id);

#4-Genera un informe que muestre la información del cliente con el pago más alto y el pago más bajo en una misma fila.

SELECT c.customer_id, c.first_name, c.last_name, a.address, 
	MAX(p.amount) AS highest_payment, MIN(p.amount) AS lowest_payment
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, a.address;

