#1- Crear un usuario data_analista

CREATE USER 'data_analyst'@'localhost' IDENTIFIED BY "FranMon1234";

#2- Otorgue permisos solo a SELECT, UPDATE y DELETE a todas las tablas de sakila.

GRANT SELECT, UPDATE, DELETE ON sakila.* TO 'data_analyst'@'localhost';

#3- Inicie sesión con este usuario e intente crear una tabla. Mostrar el resultado de esa operación.

#mysql -u data_analyst -pFranMon1234

CREATE TABLE tabla (
  id INT PRIMARY KEY,
  nombre VARCHAR(1)
);
#no tiene el permiso de CREATE

#4- Intenta actualizar el título de una película. Escribe el script de actualización.

UPDATE sakila.film
SET title = 'La razon de estar contigo'
WHERE film_id = 1;

#5- Con root o cualquier usuario administrador revoca el permiso UPDATE. Escribe el comando

REVOKE UPDATE ON sakila.* FROM 'data_analyst'@'localhost';

#6- Inicie sesión de nuevo con data_analista e intente nuevamente la actualización realizada en el paso 4. 
#Mostrar el resultado.

#mysql -u data_analyst -pFranMon1234

UPDATE sakila.film
SET title = 'La razon de estar contigo'
WHERE film_id = 1;

#ERROR 1142 (42000): UPDATE command denied to user 'data_analyst'@'localhost' for table 'film'

