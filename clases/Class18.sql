#Escribe una función que devuelva la cantidad de copias de una película en una tienda en sakila-db. 
#Pase el id de la película o el nombre de la película y el id de la tienda.
DELIMITER //
CREATE FUNCTION CopiasFilm(film VARCHAR(50), storeId INT) RETURNS INT
BEGIN
    DECLARE copies INT;
    SELECT COUNT(*) INTO copies FROM inventory i
    INNER JOIN film f ON i.film_id = f.film_id
    WHERE (f.film_id = film OR f.title = film) AND i.store_id = storeId;
    RETURN copies;
END //
DELIMITER ;

#Escriba un procedimiento almacenado con un parámetro de salida que contenga una lista de nombres 
#y apellidos de clientes separados por ";", que viven en un determinado país. Pasas el país, te da la
#lista de personas que viven allí. USA UN CURSOR, no utilice ninguna función de agregación (como CONTCAT_WS.

Select * from country;

DELIMITER //
DROP PROCEDURE IF EXISTS ObtenerClientesEnPais;
CREATE PROCEDURE ObtenerClientesEnPais(IN p_pais VARCHAR(50), OUT p_lista_clientes VARCHAR(1000))
BEGIN
    DECLARE hecho INT DEFAULT 0;
    DECLARE nombre VARCHAR(255);
    DECLARE clientes_pais CURSOR FOR
        SELECT CONCAT(c.first_name, ' ', c.last_name)
        FROM customer c
        INNER JOIN address a ON c.address_id = a.address_id
        INNER JOIN city ci ON a.city_id = ci.city_id
        INNER JOIN country co ON ci.country_id = co.country_id
        WHERE co.country = p_pais;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET hecho = 1;
    
    SET p_lista_clientes = '';

    OPEN clientes_pais;
    
    FETCH clientes_pais INTO nombre;
    
    WHILE NOT hecho DO
        IF p_lista_clientes = '' THEN
            SET p_lista_clientes = nombre;
        ELSE
            SET p_lista_clientes = CONCAT(p_lista_clientes, ';', nombre);
        END IF;
        
        FETCH clientes_pais INTO nombre;
    END WHILE;
    
    CLOSE clientes_pais;
END //
DELIMITER ;

CALL ObtenerClientesEnPais('Argentina', @lista_clientes);
SELECT @lista_clientes;

#Revise la función inventario_en_stock y el procedimiento película_en_stock explique el código, 
#escriba ejemplos de uso.

#Función inventory_in_stock
#Esta es una función SQL que toma dos parámetros, p_film_id (el ID de la película) y p_store_id (el ID de la tienda), 
#y devuelve un valor booleano que indica si una película está en stock en una tienda específica.
#Ejemplo:
SELECT inventory_in_stock(1, 1); #Verifica si la película con ID 1 está en stock en la tienda con ID 1
#Esta consulta devolverá TRUE si la película está en stock y FALSE si no lo está.

#Procedimiento film_in_stock:
#Este es el proceso mediante el cual se verifica si una película específica existe en el inventario de 
#una tienda, y si es así,se muestra la información de la película y del inventario.
#Ejemplo:
CALL film_in_stock(1, 1); -- Verifica y muestra información sobre la película con ID 1 en la tienda con ID 1
#Este llamado al procedimiento mostrará la información de la película y del inventario si está disponible, 
#o mostrará un mensaje indicando que la película no está disponible en esa tienda si no está en stock.