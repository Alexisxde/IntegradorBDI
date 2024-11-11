# Tema: Procedimientos y funciones almacenadas

## INTRODUCCION

En SQL Server, los procedimientos almacenados y las funciones son herramientas clave que permiten optimizar y organizar las operaciones que se realizan en una base de datos.

Los procedimientos almacenados se utilizan principalmente para ejecutar tareas específicas, como operaciones de inserción, actualización, eliminación o cualquier acción que implique cambios en los datos o en su estructura. Sirven para encapsular múltiples pasos en un solo bloque de código que puede llamarse luego. Los procedimientos almacenados pueden incluir parámetros de entrada y salida, lo que permite manejar datos complejos y devolver resultados variables.

Las funciones están diseñadas para realizar cálculos o transformaciones que se pueden aplicar directamente en consultas SQL. Esto significa que una función puede ser llamada en un SELECT, WHERE o cualquier otra parte de una consulta, facilitando la manipulación de datos de manera dinámica. Sin embargo, a diferencia de los procedimientos restricciones: no pueden modificar datos en la base de datos y están limitadas a solo leer datos. Este diseño asegura que sean seguras de utilizar en consultas sin causar efectos secundarios no deseados en la base de datos.

## ¿QUE ES UN PROCEDIMIENTO ALMACENADO?

Los procedimientos almacenados son bloques de instrucciones T-SQL que se almacenan en el servidor de bases de datos y se ejecutan para realizar tareas específicas. Son una herramienta poderosa para encapsular lógica de negocio en la base de datos y reducir la duplicación de código en aplicaciones que interactúan con ella.

## TIPOS DE PROCEDIMIENTO ALMACENADOS

### `1. Definidos por el Usuario`

Estos procedimientos son creados por los usuarios para ejecutar tareas específicas en la base de datos. Pueden estar en cualquier base de datos de usuario o de sistema (salvo en la base interna Resource). Los procedimientos definidos por el usuario pueden ser desarrollados en Transact-SQL o en .NET CLR, lo que permite implementar lógica personalizada y compleja para la administración y manipulación de datos.

```SQL
CREATE PROCEDURE CrearReserva
    @id_cliente INT,
    @id_habitacion INT,
    @fecha_inicio DATE,
    @fecha_fin DATE,
    @monto_total DECIMAL(10, 2)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Reservas (id_cliente, id_habitacion, fecha_inicio, fecha_fin, monto_total)
    VALUES (@id_cliente, @id_habitacion, @fecha_inicio, @fecha_fin, @monto_total);
END;

```

### `2. Temporales`

Los procedimientos temporales son una variante de los procedimientos definidos por el usuario, pero están diseñados para usarse de forma temporal y se almacenan en tempdb. Existen procedimientos temporales locales, que son accesibles solo en la sesión actual, y procedimientos globales, visibles para cualquier usuario tras su creación. Son útiles para operaciones temporales o específicas de una sesión, sin necesidad de persistir en la base de datos.

- De manera local:

```SQL
CREATE PROCEDURE #VerificarDisponibilidad
    @id_habitacion INT,
    @fecha_inicio DATE,
    @fecha_fin DATE
AS
BEGIN
    SELECT CASE
        WHEN EXISTS (
            SELECT 1
            FROM Reservas
            WHERE id_habitacion = @id_habitacion
              AND (@fecha_inicio BETWEEN fecha_inicio AND fecha_fin
                   OR @fecha_fin BETWEEN fecha_inicio AND fecha_fin)
        )
        THEN 'Ocupada'
        ELSE 'Disponible'
    END AS Disponibilidad;
END;
```

- De manera global:

```SQL
CREATE PROCEDURE ##TotalReservasActivas
AS
BEGIN
    SELECT COUNT(*) AS TotalReservasActivas
    FROM Reservas
    WHERE fecha_fin >= GETDATE();
END;

```

### `3. Sistema`

Los procedimientos del sistema son parte del motor de SQL Server y están almacenados en la base Resource, aunque se muestran en el esquema sys de cada base de datos. Estos procedimientos incluyen funciones administrativas y de mantenimiento, como la gestión de trabajos y alertas en la base msdb. Al estar prefijados con sp\_, SQL Server recomienda evitar este prefijo en los procedimientos de usuario para evitar confusiones.

```SQL
EXEC sp_help 'Reservas';

```

### `4. Extendidos Definidos por el Usuario`

Los procedimientos extendidos permiten ejecutar código externo, como bibliotecas DLL escritas en lenguajes como C, directamente desde SQL Server. Esta capacidad permite realizar tareas especializadas que pueden ser complejas o imposibles de implementar solo con T-SQL, aumentando la flexibilidad en el manejo de tareas avanzadas o específicas del sistema.
Para procedimientos extendidos, un ejemplo puede ser el uso de xp_cmdshell para listar los archivos de registro del sistema en los que se podría almacenar información de auditoría de reservas. Este tipo de procedimiento requiere habilitación y permisos específicos.

```SQL

EXEC xp_cmdshell 'dir C:\RegistrosReservas\';
```

## VENTAJAS DEL USO DE PROCEDIMIENTOS ALMACENADOS

1. **Reducción del tráfico de red**: Los procedimientos almacenados permiten ejecutar múltiples comandos en un solo envío desde el cliente al servidor, lo cual reduce el tráfico en la red y mejora el rendimiento, especialmente en aplicaciones con alta frecuencia de solicitudes.

2. **Mayor seguridad**: Los procedimientos almacenados controlan qué operaciones pueden realizar los usuarios sin necesidad de permisos directos sobre las tablas, aumentando la seguridad. Además, ayudan a prevenir inyecciones de SQL y pueden cifrarse para proteger la lógica interna.

3. **Reutilización del código**: Al encapsular operaciones repetitivas en un procedimiento, se evita duplicar código en diferentes partes de la aplicación. Esto facilita su reutilización y reduce inconsistencias, ya que cualquier cambio se realiza solo en el procedimiento.

4. **Facilidad de mantenimiento**: Los procedimientos almacenados centralizan la lógica de negocio en el servidor. Esto permite realizar cambios en la base de datos sin modificar el código de las aplicaciones cliente, facilitando actualizaciones.

5. **Mejora de rendimiento**: Los procedimientos se compilan en su primera ejecución y reutilizan un plan de ejecución, optimizando el tiempo de procesamiento en cada llamada.

## ¿QUE ES UNA FUNCION ALMACENADA?

Las funciones almacenadas (o funciones definidas por el usuario) son objetos de la base de datos que permiten encapsular lógica de negocio o cálculos en una función que puede ser reutilizada en diferentes consultas y procesos. A diferencia de los procedimientos almacenados, las funciones deben devolver un valor y pueden ser utilizadas en las consultas de SQL, como en las cláusulas `SELECT`, `WHERE`, y `JOIN`.

## TIPOS DE FUNCIONES ALMACENADAS

### `1. Funciones Escalares`

Las funciones escalares devuelven un solo valor de un tipo de datos específico, como un número, una cadena, una fecha, entre otros. Este tipo de función es útil para encapsular cálculos o transformaciones que devuelven un único resultado. Las funciones escalares pueden aceptarse dentro de cláusulas `SELECT`, `WHERE`, y otras de una consulta, lo que permite su uso en diferentes partes de una sentencia SQL.

```SQL

CREATE FUNCTION dbo.CalcularEdad(@FechaNacimiento DATETIME)
RETURNS INT
AS
BEGIN
    DECLARE @Edad INT;
    SET @Edad = DATEDIFF(YEAR, @FechaNacimiento, GETDATE());

    IF (MONTH(@FechaNacimiento) > MONTH(GETDATE()) OR
        (MONTH(@FechaNacimiento) = MONTH(GETDATE()) AND DAY(@FechaNacimiento) > DAY(GETDATE())))
    BEGIN
        SET @Edad = @Edad - 1;
    END

    RETURN @Edad;
END;
```

### `2. Funciones con Valores de Tabla en Línea`

Las funciones en línea que devuelven valores de tabla son funciones que devuelven una tabla (set de resultados) en función de una sola instrucción de consulta. Estas funciones son similares a las vistas pero ofrecen la ventaja de aceptar parámetros, lo que permite un mayor control sobre los datos devueltos.

```SQL

CREATE FUNCTION dbo.ObtenerReservasCliente(@NombreCliente VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT ID_RESERVA, FECHA_LLEGADA, FECHA_SALIDA, ID_ESTADO
    FROM RESERVAS
    WHERE NOMBRE_APELLIDO = @NombreCliente
);
```

### `3. Funciones con Valores de Tabla Multidefinidas`

A diferencia de las funciones en línea, las funciones multidefinidas con valores de tabla permiten utilizar varias sentencias de control de flujo (como IF, WHILE, y DECLARE). Este tipo de función devuelve una tabla como resultado, pero su lógica es más compleja, ya que permite múltiples pasos antes de devolver los datos.

```SQL

CREATE FUNCTION dbo.ObtenerReservasActivas(@FechaInicio DATETIME, @FechaFin DATETIME)
RETURNS @Reservas TABLE
(
    ID_RESERVA INT,
    NOMBRE_APELLIDO VARCHAR(50),
    FECHA_LLEGADA DATETIME,
    FECHA_SALIDA DATETIME
)
AS
BEGIN
    INSERT INTO @Reservas
    SELECT ID_RESERVA, NOMBRE_APELLIDO, FECHA_LLEGADA, FECHA_SALIDA
    FROM RESERVAS
    WHERE FECHA_LLEGADA >= @FechaInicio
      AND FECHA_SALIDA <= @FechaFin
      AND ID_ESTADO = 1;

    RETURN;
END;
```

### `4. Funciones de Agregación`

Las funciones de agregación son funciones predefinidas que realizan cálculos sobre un conjunto de valores. Son muy utilizadas en consultas para obtener resúmenes.

- SUM(): Suma los valores de una columna.

- AVG(): Calcula el promedio.

- COUNT(): Cuenta el número de filas.

### `5. Funciones de Sistema`

Las funciones de sistema son funciones predefinidas que permiten acceder a información del sistema o de la base de datos. Se utilizan comúnmente para obtener información sobre la fecha, hora, y otros aspectos del entorno de SQL Server.

- GETDATE(): Devuelve la fecha y hora actual del sistema.

- NEWID(): Genera un nuevo identificador único.

- SYSDATETIME(): Devuelve la fecha y hora actual con más precisión.

## VENTAJAS DEL USO DE FUNCIONES ALMACENADAS

- Reutilización de Código: Las funciones encapsulan lógica que se puede reutilizar en múltiples consultas, permitiendo su invocación en diferentes partes de la aplicación y en expresiones SQL.

- Devolución de Valores: Las funciones almacenadas pueden devolver un único valor (funciones escalares) o un conjunto de resultados (funciones de tabla), permitiendo su uso directo en consultas, lo cual no es posible con los procedimientos.

- Integración en Consultas: Las funciones pueden ser integradas en diversas partes de una consulta SQL, como en SELECT, WHERE, o ORDER BY, otorgando flexibilidad. Los procedimientos almacenados, en cambio, requieren llamadas separadas.

- Abstracción de Complejidad: Las funciones almacenadas permiten ocultar la complejidad de la lógica de negocio, proporcionando una interfaz sencilla para operaciones complejas.

- Mejor Rendimiento en Consultas: Las funciones de tabla en línea pueden ser optimizadas por SQL Server en ciertas situaciones, mejorando el rendimiento en comparación con subconsultas.

- Mantenimiento Simplificado: Actualizar la lógica de negocio solo requiere modificar la función en un solo lugar, lo que mejora la consistencia y simplifica el mantenimiento en el código de la aplicación.

## Tareas

> Ver el script para entender más [script.sql](script.sql)

## CONCLUSION

Una función puede ser llamada en un SELECT, WHERE, o cualquier otra parte de una consulta, lo que facilita la manipulación de datos de manera dinámica. Mientras que en un procedimineto almacenado se utilizan para ejecutar operaciones como inserciones, actualizaciones, eliminaciones, o cualquier acción que implique cambios en los datos o en su estructura.
