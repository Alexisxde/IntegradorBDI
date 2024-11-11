--use ADMINISTRACION_HOTEL

--como primer paso agregamos mas columnas a nuestra tabla HUESPEDES para que tengamos mayor variedad de datos en el millon que tenemos que ingresar

INSERT INTO HUESPEDES (DNI, NOMBRE_APELLIDO, FECHA_NACIMIENTO) VALUES (25000111, 'Tomas Shneider', '2000-03-10');
INSERT INTO HUESPEDES (DNI, NOMBRE_APELLIDO, FECHA_NACIMIENTO) VALUES (26222333, 'Ana Cardozo', '2002-07-22');
INSERT INTO HUESPEDES (DNI, NOMBRE_APELLIDO, FECHA_NACIMIENTO) VALUES (27444555, 'Luis Catillo', '2005-11-20');
INSERT INTO HUESPEDES (DNI, NOMBRE_APELLIDO, FECHA_NACIMIENTO) VALUES (28666777, 'Martin Correa', '2006-02-09');
INSERT INTO HUESPEDES (DNI, NOMBRE_APELLIDO, FECHA_NACIMIENTO) VALUES (29888999, 'Mario Sosa', '2001-09-02');
INSERT INTO HUESPEDES (DNI, NOMBRE_APELLIDO, FECHA_NACIMIENTO) VALUES (31000111, 'Tomas Martines', '2010-03-10');
INSERT INTO HUESPEDES (DNI, NOMBRE_APELLIDO, FECHA_NACIMIENTO) VALUES (32222333, 'Ana Lopez', '2010-07-22');
INSERT INTO HUESPEDES (DNI, NOMBRE_APELLIDO, FECHA_NACIMIENTO) VALUES (36000111, 'Luis Castro', '2010-11-20');
INSERT INTO HUESPEDES (DNI, NOMBRE_APELLIDO, FECHA_NACIMIENTO) VALUES (37222333, 'Martin Silva', '2010-02-09');
INSERT INTO HUESPEDES (DNI, NOMBRE_APELLIDO, FECHA_NACIMIENTO) VALUES (38444555, 'Mario Correa', '2010-09-02');

--declaramos variables que nos ayudaran a calcular valores aleatorios para el ingreso de algunos datos
/*******INICIO DE EJECUCION******/
DECLARE @Counter INT = 1;
DECLARE @MaxRecords INT = 1000000;
DECLARE @BaseDNI INT;
DECLARE @BaseNombre NVARCHAR(50);
DECLARE @BaseFecha DATE;

-- Datos existentes // alamacenamos en una variable temporal @Datos para el ingreso masivo
DECLARE @Datos TABLE (DNI INT, NOMBRE_APELLIDO NVARCHAR(50), FECHA_NACIMIENTO DATE);

INSERT INTO @Datos (DNI, NOMBRE_APELLIDO, FECHA_NACIMIENTO)
VALUES 
(12345678, 'Juan Pérez', '1985-03-15'),(87654321, 'Ana Gómez', '1990-07-22'),
(23456789, 'Luis Fernández', '1978-11-05'),(34567890, 'María López', '1995-02-10'),
(45678901, 'Carlos Ruiz', '1982-09-30'),(25000111, 'Tomas Shneider', '1985-03-15'),
(26222333, 'Ana Cardozo', '1990-07-22'),(27444555, 'Luis Catillo', '1978-11-05'),
(28666777, 'Martin Correa', '1995-02-10'),(29888999, 'Mario Sosa', '1982-09-30'),
(31000111, 'Tomas Martines', '2010-03-10'),(32222333, 'Ana Lopez', '2010-07-22'),
(36000111, 'Luis Castro', '2010-11-20'),(37222333, 'Martin Silva', '2010-02-09'),
(38444555, 'Mario Correa', '2010-09-02');

WHILE @Counter <= (@MaxRecords - (SELECT COUNT(*) FROM @Datos))
BEGIN
    -- Selecciona un registro aleatorio de los datos existentes
    SELECT TOP 1 @BaseDNI = DNI, @BaseNombre = NOMBRE_APELLIDO, @BaseFecha = FECHA_NACIMIENTO
    FROM @Datos
    ORDER BY NEWID();  -- Aleatorio

    -- Modificar el DNI para que sea único
    SET @BaseDNI = @BaseDNI + @Counter;

    -- Insertar el nuevo registro con variaciones
    INSERT INTO HUESPEDES (DNI, NOMBRE_APELLIDO, FECHA_NACIMIENTO)
    VALUES (
        @BaseDNI,
        @BaseNombre,
        DATEADD(DAY, ROUND(RAND() * 365, 0), @BaseFecha)  -- Fecha variada
    );

    SET @Counter = @Counter + 1;
END
/*******FIN DE EJECUCION******/

--TIEMPO ESTIMADO CERCA DE 3 MINUTOS

--.VERIFICAMOS QUE SE CARGARON 1 MILLON DE REGISTROS

select * from HUESPEDES

--La condición completa @Counter <= (@MaxRecords - (SELECT COUNT(*) FROM @Datos)) 
--significa que el bucle continuará ejecutándose mientras el contador (@Counter) 
--sea menor o igual a la cantidad de registros que aún se pueden insertar.


--BUSCAMOS UN RANGO DE FECHAS DE MAYOR A MENOR "NO TIENEN INDICE"

SELECT TOP 1 FECHA_NACIMIENTO from HUESPEDES
ORDER BY FECHA_NACIMIENTO ASC
SELECT TOP 1 FECHA_NACIMIENTO from HUESPEDES
ORDER BY FECHA_NACIMIENTO DESC

--Consulta Inicial sin Índice, ASIQUE ELIMINAMOS PRIMERO NUESTRA CLAVE PRIMARIA EN HUESPEDES

ALTER TABLE HUESPEDES
DROP CONSTRAINT PK_DNI_HUESPED

ALTER TABLE HUESPEDES
ADD CONSTRAINT PK_DNI_HUESPED PRIMARY KEY (DNI)


/****************************Realiza una consulta que filtre por un rango de fechas****************************/


                        /******************CONSULTA SIN INDICES*****************/

SET SHOWPLAN_ALL ON;-- Habilitar el plan de ejecución para la consulta sin índice
go
SELECT * 
FROM HUESPEDES 
WHERE FECHA_NACIMIENTO BETWEEN '1978-11-05' AND '2011-11-20'
ORDER BY FECHA_NACIMIENTO
go
SET SHOWPLAN_ALL OFF;-- Deshabilitar el plan de ejecución
go

SET STATISTICS TIME ON;
SET STATISTICS IO ON;

SELECT * 
FROM HUESPEDES 
WHERE FECHA_NACIMIENTO BETWEEN '1978-11-05' AND '2011-11-20'
ORDER BY FECHA_NACIMIENTO


SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;


                      /******************CONSULTA CON INDICE AGRUPADO******************/

----CREAR UN INDICE DE FECHA---
-- Crear un índice agrupado sobre la columna FECHA_NACIMIENTO
CREATE CLUSTERED INDEX idx_fecha_nacimiento ON HUESPEDES(FECHA_NACIMIENTO);

SET SHOWPLAN_ALL ON;-- Habilitar el plan de ejecución para la consulta sin índice
go
SELECT * 
FROM HUESPEDES 
WHERE FECHA_NACIMIENTO BETWEEN '1978-11-05' AND '2011-11-20'
ORDER BY FECHA_NACIMIENTO
go
SET SHOWPLAN_ALL OFF;-- Deshabilitar el plan de ejecución
go

--Ejecucion con indice agrupado
SET STATISTICS TIME ON;
SET STATISTICS IO ON;

SELECT * 
FROM HUESPEDES 
WHERE FECHA_NACIMIENTO BETWEEN '1978-11-05' AND '2011-11-20'
ORDER BY FECHA_NACIMIENTO

SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;

---BORRAR INDICE CREADO---
DROP INDEX idx_fecha_nacimiento ON HUESPEDES;



                        /******************CONSULTA CON INDICES NO AGRUPADOS**************/

-- Crear un índice no agrupado que incluya columnas
CREATE NONCLUSTERED INDEX idx_fecha_nacimiento_dato ON HUESPEDES(FECHA_NACIMIENTO)
INCLUDE (NOMBRE_APELLIDO);

SET SHOWPLAN_ALL ON;-- Habilitar el plan de ejecución para la consulta sin índice
go
SELECT * 
FROM HUESPEDES 
WHERE FECHA_NACIMIENTO BETWEEN '1978-11-05' AND '2011-11-20'
ORDER BY FECHA_NACIMIENTO
go
SET SHOWPLAN_ALL OFF;-- Deshabilitar el plan de ejecución
go

--Ejecucion con indices no agrupado
SET STATISTICS TIME ON;
SET STATISTICS IO ON;

SELECT * 
FROM HUESPEDES 
WHERE FECHA_NACIMIENTO BETWEEN '1978-11-05' AND '2011-11-20'
ORDER BY FECHA_NACIMIENTO

SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;

--BORRAR INDICE
DROP INDEX idx_fecha_nacimiento_dato ON HUESPEDES;




