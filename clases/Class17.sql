#1
SELECT a.*, c.city, co.country
FROM address a
JOIN city c USING (city_id)
JOIN country co USING (country_id)
WHERE postal_code IN ('10000', '20000', '30000');  

SELECT a.*, c.city, co.country
FROM address a
JOIN city c USING (city_id)
JOIN country co USING (country_id)
WHERE postal_code NOT IN ('10000', '20000', '30000'); 

CREATE INDEX postal_code ON address (postal_code); 

SELECT a.*, c.city, co.country
FROM address a
JOIN city c USING (city_id)
JOIN country co USING (country_id)
WHERE postal_code IN ('10000', '20000', '30000');  

SELECT a.*, c.city, co.country
FROM address a
JOIN city c USING (city_id)
JOIN country co USING (country_id)
WHERE postal_code NOT IN ('10000', '20000', '30000');  

#Cuando generamos el indice, se acomodan los datos de manera eficiente permitiendo una busqueda mas rapida 
#por ende menor tiempo de ejecucion, funcionando de manera similar a un diccionario asignando una key y los datos para su busqueda.

#2
select * from actor;
SELECT * FROM actor WHERE first_name = 'THORA';

SELECT * FROM actor WHERE last_name = 'TEMPLE';

#La principal diferencia entre estas dos querys son los datos que traen, 
#ya que la estructura y eficiencia son practicamente iguales.

#3

ALTER TABLE film
    ADD FULLTEXT (title);

SELECT * FROM film WHERE title LIKE '%HARRY%'; 

SELECT * FROM film WHERE MATCH (title) AGAINST ('HARRY'); 
#Estas querys se diferencia por el metodo de busqueda que utilizan, por un lado like busca el texto indicado
#de manera estricta, mientras que por otro lado el metodo de busqueda usado en la segunda query buscara de manera mas flexible.
#Por otro lado se usa de manera eficiente en conjunto de datos pequeños y el match, como en este caso, para grandes volumenes de datos