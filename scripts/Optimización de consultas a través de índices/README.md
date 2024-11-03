# Tema: Optimización de consultas a través de índices

## **¿Qué es un indice? Tipos de Indices y sus aplicaciones:**

Un índice es una estructura en disco asociada con una tabla o vista que acelera la recuperación de filas de la tabla o vista. Un índice contiene claves construidas a partir de una o más columnas en la tabla o vista. Estas claves se almacenan en una estructura (B-árbol) que permite a SQL Server encontrar la fila o filas asociadas con los valores de clave de forma rápida y eficiente.
Cuando se ejecuta esta consulta, el optimizador de consultas evalúa cada método disponible para recuperar los datos y selecciona el método más eficiente. El método puede ser un escaneo de tabla, o puede estar escaneando uno o más índices si existen.

### **Tipos de indices**

#### **Agrupado:**

Los índices agrupados ordenan y almacenan las filas de datos en la tabla o vista en función de sus valores clave. Estos valores clave son las columnas incluidas en la definición de índice. Solo puede haber un índice agrupado por tabla, porque las filas de datos en sí mismas se pueden almacenar en un solo orden.
La única vez que las filas de datos en una tabla se almacenan en orden ordenado es cuando la tabla contiene un índice agrupado. Cuando una tabla tiene un índice agrupado, la tabla se denomina tabla agrupada. Si una tabla no tiene un índice agrupado, sus filas de datos se almacenan en una estructura desordenada llamada montón.

##### **Crear un indice agrupado**

```SQL
CREATE CLUSTERED INDEX idx_fecha_nacimiento ON HUESPEDES(FECHA_NACIMIENTO);
```

##### **Borrar indice creado**

```SQL
DROP INDEX idx_fecha_nacimiento ON HUESPEDES;
```

#### **No agrupado:**

Los índices no agrupados tienen una estructura separada de las filas de datos. Un índice no agrupado contiene los valores de clave de índice no agrupados y cada entrada de valor de clave tiene un puntero a la fila de datos que contiene el valor de clave.
El puntero de una fila de índice en un índice no agrupado a una fila de datos se denomina localizador de filas. La estructura del localizador de filas depende de si las páginas de datos se almacenan en un montón o en una tabla agrupada. Para un montón, un localizador de filas es un puntero a la fila. Para una tabla agrupada, el localizador de filas es la clave de índice agrupada.
Ventajas:
Flexibilidad: Permite crear múltiples índices no agrupados sobre una tabla, lo que puede acelerar consultas que no se benefician del índice agrupado.
Mejora en Consultas: Es útil para acelerar consultas que filtran o buscan en columnas que no son la clave primaria.
Desventajas:
Rendimiento en Escrituras: Cada vez que se inserta, actualiza o elimina una fila, los índices no agrupados también deben actualizarse, lo que puede afectar el rendimiento de las operaciones de escritura.
Espacio: Requieren espacio adicional en disco debido a su estructura separada.

##### **Crear un indice no agrupado**

```SQL
CREATE NONCLUSTERED INDEX idx_fecha_nacimiento_dato ON HUESPEDES(FECHA_NACIMIENTO)
INCLUDE (NOMBRE_APELLIDO);
```

##### **Borrar indice creado**

```SQL
DROP INDEX idx_fecha_nacimiento_dato ON HUESPEDES;
```

## Conclusiones:

Estructura y Organización:
Índice Agrupado: Almacena las filas de datos en un orden específico basado en los valores de clave del índice. Solo puede existir uno por tabla, lo que garantiza que las filas se mantengan en un solo orden. Esto es eficiente para consultas que requieren acceso secuencial a los datos.
Índice No Agrupado: Mantiene una estructura separada, donde se almacena el valor de la clave y un puntero a la fila correspondiente. Esto permite múltiples índices no agrupados en una misma tabla, lo que mejora la flexibilidad para optimizar diferentes consultas.

Rendimiento de Consultas:
Índice Agrupado: Es ideal para consultas que requieren un acceso rápido a un rango de valores, ya que los datos están físicamente organizados en ese orden.
Índice No Agrupado: Mejora el rendimiento de consultas que buscan datos en columnas que no son la clave primaria, permitiendo que se acceda a los datos más rápidamente sin necesidad de escanear toda la tabla.

Impacto en el Rendimiento de Escritura:
Índice Agrupado: Al tener solo un índice agrupado, las inserciones, actualizaciones y eliminaciones pueden ser más eficientes, pero los cambios en los datos pueden causar reordenamientos si los nuevos datos no encajan en la secuencia existente.
Índice No Agrupado: Las operaciones de escritura pueden ser más costosas, ya que cada inserción o modificación requiere que se actualicen todos los índices no agrupados asociados, lo que puede impactar el rendimiento.

Uso de Espacio:
Índice Agrupado: Al estar directamente ligado a las filas de datos, el índice agrupado no requiere espacio adicional más allá de los datos en sí.
Índice No Agrupado: Requiere espacio adicional en disco, ya que los datos del índice y los datos de la tabla están separados.

> [!CAUTION]
> La tarea va en el script.sql Enzo.

## Tareas:

- Realizar una carga masiva de por lo menos un millón de registro sobre alguna tabla que contenga un campo fecha (sin índice). Hacerlo con un script para poder automatizarlo.

(ver script para entender mejor los pasos)

- Realizar una búsqueda por periodo y registrar el plan de ejecución utilizado por el motor y los tiempos de respuesta.

```plan de ejecucion del motor en un intervalo de fecha
SET SHOWPLAN_ALL ON;-- Habilitar el plan de ejecución para la consulta sin índice
go
SELECT *
FROM HUESPEDES
WHERE FECHA_NACIMIENTO BETWEEN '1978-11-05' AND '2011-11-20';
go
SET SHOWPLAN_ALL OFF;-- Deshabilitar el plan de ejecución
go
```

```tiempos de ejecucion en un intervalo de fecha
SET STATISTICS TIME ON;
SET STATISTICS IO ON;

SELECT *
FROM HUESPEDES
WHERE FECHA_NACIMIENTO BETWEEN '1978-11-05' AND '2011-11-20';
ORDER BY FECHA_NACIMIENTO

SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;
```

- Definir un índice agrupado sobre la columna fecha y repetir la consulta anterior. Registrar el plan de ejecución utilizado por el motor y los tiempos de respuesta.

CREATE CLUSTERED INDEX idx_fecha_nacimiento ON HUESPEDES(FECHA_NACIMIENTO);

- Borrar el índice creado.

```
DROP INDEX idx_fecha_nacimiento ON HUESPEDES;
```

- Definir otro índice agrupado sobre la columna fecha pero que además incluya las columnas seleccionadas y repetir la consulta anterior. Registrar el plan de ejecución utilizado por el motor y los tiempos de respuesta.

```
CREATE NONCLUSTERED INDEX idx_fecha_nacimiento_dato ON HUESPEDES(FECHA_NACIMIENTO)
```

- Expresar las conclusiones en base a las pruebas realizadas.

--- Resultados de la consulta sin índice ---
Tiempo total de ejecución: [4733 ms]
Tiempo de CPU: [640 ms]
Lecturas lógicas: [4646]
Lecturas físicas: [0]

--- Resultados de la consulta con índice agrupado ---
Tiempo total de ejecución: [4406 ms]
Tiempo de CPU: [219 ms]
Lecturas lógicas: [4660]
Lecturas físicas: [0]

--- Resultados de la consulta con índice no agrupado ---
Tiempo total de ejecución: [4735 ms]
Tiempo de CPU: [547 ms]
Lecturas lógicas: [4646]
Lecturas físicas: [0]

## Análisis de Resultados

## Consulta sin Índice:

Tiempo total de ejecución: 4733 ms
Tiempo de CPU: 640 ms
Lecturas lógicas: 4646
Lecturas físicas: 0
Esta consulta tiene un rendimiento moderado en términos de tiempo de ejecución y un tiempo de CPU relativamente alto. La ausencia de índices significa que el motor de la base de datos tuvo que realizar un escaneo completo de la tabla para obtener los resultados.

## Consulta con Índice Agrupado:

Tiempo total de ejecución: 4406 ms
Tiempo de CPU: 219 ms
Lecturas lógicas: 4660
Lecturas físicas: 0
Aquí, aunque el tiempo total de ejecución es ligeramente mejor que sin índice (4406 ms frente a 4733 ms), lo más notable es la reducción significativa en el tiempo de CPU (219 ms frente a 640 ms). Esto indica que el índice agrupado ha permitido al motor de la base de datos ejecutar la consulta de manera más eficiente, utilizando el índice para evitar cálculos innecesarios.

## Consulta con Índice No Agrupado:

Tiempo total de ejecución: 4735 ms
Tiempo de CPU: 547 ms
Lecturas lógicas: 4646
Lecturas físicas: 0
Esta consulta tiene un rendimiento similar al de la consulta sin índice, tanto en tiempo de ejecución como en lecturas lógicas. Aunque el índice no agrupado fue creado para incluir columnas adicionales,no ofreció una mejora significativa en el rendimiento para esta consulta en particular.
