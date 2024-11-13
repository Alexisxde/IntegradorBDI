USE ADMINISTRACION_HOTEL;
GO;
/*--------------------------------------------------------------------------------------*/
/*---------------------------Permisos a nivel de usuarios-------------------------------*/
/*--------------------------------------------------------------------------------------*/

/*1.Crear dos usuarios de base de datos.*/
--Para poder usar nuestros usuarios en SQLServer debemos crear inicios de sesiones para cada usuario
--1.1 Creamos los inicios de sesion para cada usuario
CREATE LOGIN GERENTE_CARLOS WITH PASSWORD = '95963784';
CREATE LOGIN SUPERVISOR_ALEXIS WITH PASSWORD = '44542230';
--1.2 Creamos los usuarios y los asignamos a sus inicios de sesiones
CREATE USER GERENTE_CARLOS FOR LOGIN GERENTE_CARLOS;
CREATE USER SUPERVISOR_ALEXIS FOR LOGIN SUPERVISOR_ALEXIS;

/*2.A un usuario darle el permiso de administrador y al otro usuario solo permiso de lectura.*/
--2.1 Otorgamos permisos de lectura al usuario supervisor
GRANT SELECT ON SCHEMA::dbo TO SUPERVISOR_ALEXIS;
--2.2 Otorgamos todos los permisos al usuario gerente
GRANT SELECT, INSERT,UPDATE, DELETE ON SCHEMA::dbo to GERENTE_CARLOS;

/*3.Utilizar los procedimientos almacenados creados anteriormente.*/
EXEC dbo.agregarCargo @IdCargo = N'10', @NombreCargo = N'Masajista';

/*4.Al usuario con permiso de solo lectura, darle permiso de ejecución sobre este procedimiento.*/
GRANT EXECUTE ON OBJECT::dbo.agregarCargo TO SUPERVISOR_ALEXIS;

/*5.Realizar INSERT con sentencia SQL sobre la tabla del procedimiento con ambos usuarios.*/
--5.1 Insercion con usuario admin.
EXECUTE AS USER = 'GERENTE_CARLOS';
GO
INSERT INTO CARGOS (ID_CARGO,NOMBRE) VALUES (11, 'Cocinero');
GO
REVERT;
--Ningun error
--5.2 Insercion con usuario con solo permiso de lectura
EXECUTE AS USER = 'SUPERVISOR_ALEXIS';
GO
INSERT INTO CARGOS(ID_CARGO,NOMBRE) VALUES (13, 'Limpieza salón');
GO
REVERT;
/*Error:The INSERT permission was denied on the object 'CARGOS', database 'ADMINISTRACION_HOTEL', 
schema 'dbo'.*/

/*6.Realizar un INSERT a través del procedimiento almacenado con el usuario 
con permiso de solo lectura.*/
EXECUTE AS USER = 'SUPERVISOR_ALEXIS';
GO
EXEC dbo.agregarCargo @IdCargo = N'15', @NombreCargo = N'Chef';
GO
REVERT;
--Ningún error
--Esto ocurre por que el usuario SI tiene permiso para ejecutar el procedimiento agregarCargo (Se le concedió permiso en la linea 26).
--Dicho de otra forma, puede utilizar el procedimiento para insertar en la tabla, pero NO puede insertarlo directamente.

/*--------------------------------------------------------------------------------------*/
/*----------------------Permisos a nivel de roles del DBMS------------------------------*/
/*--------------------------------------------------------------------------------------*/

/*1.Crear dos usuarios de base de datos.*/
--Para poder usar nuestros usuarios en SQLServer debemos crear inicios de sesiones para cada usuario
--1.1 Creamos los inicios de sesion para cada usuario
CREATE LOGIN SUPERVISOR_FACUNDO WITH PASSWORD = '44542162';
CREATE LOGIN SUPERVISOR_ENZO WITH PASSWORD = '37157979';
--1.2 Creamos los usuarios y los asignamos a sus inicios de sesiones
CREATE USER SUPERVISOR_FACUNDO FOR LOGIN SUPERVISOR_FACUNDO;
CREATE USER SUPERVISOR_ENZO FOR LOGIN SUPERVISOR_ENZO;
/*2.Crear un rol que solo permita la lectura de alguna de las tablas creadas.*/
--2.1 Creamos el rol para los supervisores
CREATE ROLE SUPERVISORES;
--2.2 Le asignamos los permisos de lectura en la tabla CARGOS
GRANT SELECT ON dbo.CARGOS TO SUPERVISORES;
/*3.Darle permiso a uno de los usuarios sobre el rol creado anteriormente.*/
ALTER ROLE SUPERVISORES ADD MEMBER SUPERVISOR_FACUNDO;
/*4.Verificar el comportamiento de ambos usuarios (el que tiene permiso sobre el rol y el que no tiene), 
cuando intentan leer el contenido de la tabla.*/
--4.1 Traemos los datos con el usuario sin el rol
EXECUTE AS USER = 'SUPERVISOR_ENZO';
GO
SELECT * FROM CARGOS;
GO
REVERT;
/*Error:
The SELECT permission was denied on the object 'CARGOS', 
database 'ADMINISTRACION_HOTEL', schema 'dbo'.*/

--4.2 Traemos los datos con el usuario con el rol
EXECUTE AS USER = 'SUPERVISOR_FACUNDO';
GO
SELECT * FROM CARGOS;
GO
REVERT;
--Ningun error, nos muestra todos los datos de la tabla
/*5.Expresar sus conclusiones.*/
/*El sistema de roles en SQLServer es un sistema de seguridad robusto, eficiente y muy optimo,
también es mucho más cómodo y organizado que otorgar permisos a usuarios individualmente, 
ya que con unos cuantos roles se pueden organizar un sistema grande 
(Como en nuestro caso de estudio, un hotel).
De igual forma, usando los roles predeterminados de SQLServer se facilita mucho más la
organización de los usuarios.
En conclusión, tanto los permisos como los roles son una excelente opción de seguridad para
utilizar en bases de datos.*/
