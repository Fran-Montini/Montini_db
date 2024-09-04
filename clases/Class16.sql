
#1
CREATE TABLE
    `employees` (
        `employeeNumber` int(11) NOT NULL,
        `lastName` varchar(50) NOT NULL,
        `firstName` varchar(50) NOT NULL,
        `extension` varchar(10) NOT NULL,
        `email` varchar(100) NOT NULL,
        `officeCode` varchar(10) NOT NULL,
        `reportsTo` int(11) DEFAULT NULL,
        `jobTitle` varchar(50) NOT NULL,
        PRIMARY KEY (`employeeNumber`)
    );

INSERT INTO
    employees (employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle)
VALUES (100,'Montini','Francisco','x1234',NULL,'1','ADMIN');
# si email da error


#2
INSERT INTO employees (employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle)
VALUES (100, 'Smith', 'sr', 'x321', 'srsmith@mail.com', '---', 11, 'ADMIN');
UPDATE employees SET employeeNumber = employeeNumber - 20;
#Cambia el numero de employeeNumber por el valor anterior menos 20
select * from employees;
UPDATE employees SET employeeNumber = employeeNumber + 20;
#Cambia el numero de employeeNumber por el valor anterior mas 20

#3
ALTER TABLE employees
ADD COLUMN age INT CHECK (age >= 16 AND age <= 70);


#4
-- Tabla "film" (película):
--     La tabla "film" contiene información sobre las películas (título, etc.).
-- Tabla "actor":
--     La tabla "actor" guarda datos sobre los actores (nombre, apellido, etc.).
-- Tabla "film_actor":
--         Es una tabla de búsqueda o tabla de índices.
--         Tiene dos columnas: "film_id" (ID de la película) y "actor_id" (ID del actor).
--         Esta tabla hace una relación de muchos a muchos entre películas y actores.
--         La columna "film_id" en "film_actor" es igual a "film_id" en la tabla "film", por lo tanto, se puede hacer una relación de clave externa.
--         La columna "actor_id" en "film_actor" hace referencia a la columna "actor_id" en "actor" y, por lo tanto, establece una relación de clave externa.

-- La integridad referencial en este escenario asegura que:
--     Los registros de las películas en la tabla "film_actor" (a través de "film_id") deben existir como registros de película en la tabla "film".
--     Los actores correspondientes en la tabla "film_actor" (a través de la columna "actor_id") deben ser válidos según los registros de actores en la tabla "actor".

-- Esta integridad asegura la coherencia en la base de datos y establece que solo se permitan relaciones válidas entre actores y películas. No permite que se creen relaciones o registros huérfanos que puedan apuntar a un registro inexistente en la base de datos, lo que es crucial para evitar la corrupción de datos y para asegurar la exactitud y consistencia de los datos.


#5
ALTER TABLE employees
ADD COLUMN lastUpdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE employees
ADD COLUMN lastUpdateUser VARCHAR(50);

DELIMITER //
CREATE TRIGGER update_lastUpdate
BEFORE UPDATE ON employees FOR EACH ROW
BEGIN
    SET NEW.lastUpdate = CURRENT_TIMESTAMP;
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER update_lastUpdateUser
BEFORE UPDATE ON employees FOR EACH ROW
BEGIN
    SET NEW.lastUpdate = CURRENT_TIMESTAMP;
END;
//
DELIMITER ;

show TRIGGERS;


#6
SHOW TRIGGERS ;
--create trigger customer_create_date
--    before insert
--    on customer
--    for each row
--    SET NEW.create_date = NOW();

--   Este trigger setea el valor NOW() a el campo create_date. Y corre al  insertar un nuevo customer

--create trigger del_film
--    after delete
--    on film
--    for each row
--BEGIN
--    DELETE FROM film_text WHERE film_id = old.film_id;
--END;

--   Este trigger  corre despues de la eliminacion de una pelicula. Borra de film_text
--   las filas que contengan el id de la pelicula eliminada.



--create trigger ins_film
--    after insert
--    on film
--    for each row
--BEGIN
--    INSERT INTO film_text (film_id, title, description)
--        VALUES (new.film_id, new.title, new.description);
--END;

--   Este trigger corre despues de insertar algo en la tabla film. Inserta en la tabla fil_text
--   el nuevo valor del id, titulo y descripcion de la pelicula insertada.



--create trigger upd_film
--    after update
--    on film
--    for each row
--BEGIN
--    IF (old.title != new.title) OR (old.description != new.description) OR (old.film_id != new.film_id)
--    THEN
--        UPDATE film_text
--            SET title=new.title,
--                description=new.description,
--               film_id=new.film_id
--        WHERE film_id=old.film_id;
--    END IF;
--  END;

--  Este trigger funciona después de una actualización en la tabla film. Comprueba si el valor anterior en la columna título, descripción, o ID es diferente a los valores anteriores. Si la condición dada es verdadera, entonces los campos se actualizan con los nuevos valores.

--create trigger payment_date
--    before insert
--    on payment
--    for each row
--   SET NEW.payment_date = NOW();

-- Este trigger corre antes de una insercion a la tabla payment.
-- Setea el valor que devuelva la funcion NOW() al campo payment_date

