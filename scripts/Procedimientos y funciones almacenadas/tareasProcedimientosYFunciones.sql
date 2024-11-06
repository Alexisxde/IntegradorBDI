-- 1. PROCEDIMIENTOS ALMACENADOS PARA INSERTAR, MODIFICAR Y BORRAR REGISTROS MEDIANTE PROCEDIMIENTO ALMACENADO.

CREATE PROCEDURE isertarHuesped
  @DNI INT,
  @NombreApellido VARCHAR(50),
  @FechaNacimiento DATE
AS
BEGIN
  INSERT INTO HUESPEDES (DNI, NOMBRE_APELLIDO, FECHA_NACIMIENTO)
  VALUES (@DNI, @NombreApellido, @FechaNacimiento);
END;

CREATE PROCEDURE modificarHuesped
  @DNI INT,
  @NuevoNombreApellido VARCHAR(50),
  @NuevaFechaNacimiento DATE
AS
BEGIN
  UPDATE HUESPEDES
  SET NOMBRE_APELLIDO = @NuevoNombreApellido,
      FECHA_NACIMIENTO = @NuevaFechaNacimiento
  WHERE DNI = @DNI;
END;

CREATE PROCEDURE borrarHuesped
  @DNI INT
AS
BEGIN
  DELETE FROM HUESPEDES
  WHERE DNI = @DNI;
END;


-- 2. INSERCIÓN DE DATOS (LOTE) USANDO SENTENCIAS INSERT Y PROCEDIMIENTOS

INSERT INTO HUESPEDES (DNI, NOMBRE_APELLIDO, FECHA_NACIMIENTO)
VALUES 
  (12345678, 'Enzo Lopez', '1980-05-15'),
  (87654321, 'Carlos Pineda', '1990-10-20'),
  (11223344, 'Alexis Olivarez', '1985-07-25');

-- Inserción usando procedimientos almacenados
EXEC insertarHuesped @DNI = 56789012, @NombreApellido = 'Walter Vallejos', @FechaNacimiento = '1982-09-17';
EXEC insertarHuesped @DNI = 23456789, @NombreApellido = 'Juan Cuzziol', @FechaNacimiento = '1995-12-03';
EXEC insertarHuesped @DNI = 34567890, @NombreApellido = 'Dario Villegas', @FechaNacimiento = '1987-03-22';


-- 3. ACTUALIZAR Y ELIMINAR REGISTROS USANDO PROCEDIMIENTOS

EXEC modificarHuesped @DNI = 12345678, @NuevoNombreApellido = 'Chenzo Lopez', @NuevaFechaNacimiento = '1980-05-16';
EXEC borrarHuesped @DNI = 87654321;


-- 4. FUNCIONES ALMACENADAS

-- Función para calcular la edad según la fecha de nacimiento
CREATE FUNCTION calcularEdad (@FechaNacimiento DATE)
RETURNS INT
AS
BEGIN
  DECLARE @Edad INT;
  SET @Edad = DATEDIFF(YEAR, @FechaNacimiento, GETDATE());
  IF (MONTH(@FechaNacimiento) > MONTH(GETDATE())) OR 
     (MONTH(@FechaNacimiento) = MONTH(GETDATE()) AND DAY(@FechaNacimiento) > DAY(GETDATE()))
  BEGIN
    SET @Edad = @Edad - 1;
  END;
  RETURN @Edad;
END;

-- Función para obtener el nombre completo de un huésped según su DNI
CREATE FUNCTION nombreCompletoHuesped (@DNI INT)
RETURNS VARCHAR(50)
AS
BEGIN
  DECLARE @NombreCompleto VARCHAR(50);
  SELECT @NombreCompleto = NOMBRE_APELLIDO FROM HUESPEDES WHERE DNI = @DNI;
  RETURN @NombreCompleto;
END;



-- Función para obtener el número de cargos y sus nombres 
CREATE FUNCTION obtenerCargos()
RETURNS TABLE
AS
RETURN
(
    SELECT 
        ID_CARGO,
        NOMBRE
    FROM CARGOS
);

-- 5. COMPARACIÓN DE EFICIENCIA ENTRE OPERACIONES DIRECTAS Y PROCEDIMIENTOS/FUNCIONES

-- Visualizar estadisticas de tiempo real
SET STATISTICS TIME ON;
SET STATISTICS IO ON;

-- CONSULTA
SELECT * FROM HUESPEDES WHERE DNI = 12345678;

SELECT dbo.nombreCompletoHuesped(12345678) AS NombreCompleto;

-- INSERSIONES
INSERT INTO HUESPEDES (DNI, NOMBRE_APELLIDO, FECHA_NACIMIENTO)
VALUES (65432109, 'Julia Navarro', '1991-04-30');

EXEC insertarHuesped @DNI = 65432109, @NombreApellido = 'Julia Navarro', @FechaNacimiento = '1991-04-30';

SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;





