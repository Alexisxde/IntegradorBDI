# Tema: Procedimientos y funciones almacenadas
## INTRODUCCION

En SQL Server, los procedimientos almacenados y las funciones son herramientas clave que permiten optimizar y organizar las operaciones que se realizan en una base de datos.  

Los procedimientos almacenados se utilizan principalmente para ejecutar tareas específicas, como operaciones de inserción, actualización, eliminación o cualquier acción que implique cambios en los datos o en su estructura. Sirven para encapsular múltiples pasos en un solo bloque de código que puede llamarse luego. Los procedimientos almacenados pueden incluir parámetros de entrada y salida, lo que permite manejar datos complejos y devolver resultados variables. 

Las funciones están diseñadas para realizar cálculos o transformaciones que se pueden aplicar directamente en consultas SQL. Esto significa que una función puede ser llamada en un SELECT, WHERE o cualquier otra parte de una consulta, facilitando la manipulación de datos de manera dinámica. Sin embargo, a diferencia de los procedimientos restricciones: no pueden modificar datos en la base de datos y están limitadas a solo leer datos. Este diseño asegura que sean seguras de utilizar en consultas sin causar efectos secundarios no deseados en la base de datos. 

## Objetivos de Aprendizaje:

- Comprender la diferencia entre procedimientos y funciones almacenadas.

- Aplicar procedimientos y funciones en la implementación de operaciones CRUD.

## Criterios de Evaluación:

- Correcta implementación y funcionamiento de los procedimientos y funciones.

- Documentación clara y precisa de cada paso y concepto.

- Efectividad en la manipulación de datos usando las funciones y procedimientos.

## Tareas:

- Realizar al menos tres procedimientos almacenados que permitan: Insertar, Modificar y borrar registros de alguna de las tablas del proyecto.

- Insertar un lote de datos en las tablas mencionadas (guardar el script) con sentencias insert y otro lote invocando a los procedimientos creados.

- Realizar update y delete sobre algunos de los registros insertados en esas tablas invocando a los procedimientos.

- Desarrollar al menos tres funciones almacenadas. Por ej: calcular la edad.

- Comparar la eficiencia de las operaciones directas versus el uso de procedimientos y funciones.
