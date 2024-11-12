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

- Borrar indice creado

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

- Borrar indice creado

```SQL
DROP INDEX idx_fecha_nacimiento_dato ON HUESPEDES;
```

### Plan de ejecución del motor de base de datos STATICS PROFILE, STATICS TIME Y SHOWPLAN.

La sentencia SET STATISTICS TIME ON; en SQL Server permite ver los tiempos de ejecución de las consultas, tanto el tiempo de CPU como el tiempo total requerido para completar la consulta. Cuando está activada, cada vez que se ejecuta una consulta, SQL Server muestra:
Tiempo de CPU usado por la consulta.
Tiempo total de ejecución, que incluye tiempo de espera y procesamiento en el servidor.

```SQL
SET STATISTICS TIME ON;
SELECT * FROM [NombreTabla] WHERE [Condiciones];--consulta
SET STATISTICS OFF;-- Deshabilitar el plan de ejecución
```

Tiempo de CPU usado por la consulta.
Tiempo total de ejecución, que incluye tiempo de espera y procesamiento en el servidor.

SHOWPLAN_ALL – no ejecuta la consulta, muestra el texto del plan de consultas estimado junto con el costo de la estimación.

```SQL
SET SHOWPLAN_ALL ON;-- Habilitar el plan de ejecución para la consulta
SELECT * FROM [NombreTabla] WHERE [Condiciones];--consulta
SET SHOWPLAN_ALL OFF;-- Deshabilitar el plan de ejecución

```

STATISTICS PROFILE – ejecuta la consulta, muestra los resultados y texto del plan de consultas real.

```SQL
SET STATISTICS PROFILE ON;
SELECT * FROM [NombreTabla] WHERE [Condiciones];--consulta
SET STATISTICS PROFILE OFF;
```


## **Tareas**

> Ver el script para entender más [script.sql](script.sql)

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




