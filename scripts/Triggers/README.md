# Tema: Triggers

## **¿Qué es y cómo usar un trigger en SQL?**

Un trigger es un procedimiento almacenado en la base de datos que se ejecuta automáticamente cada vez que ocurre un evento especial en la base de datos. Por ejemplo, un desencadenante puede activarse cuando se inserta una fila en una tabla específica o cuando ciertas columnas de la tabla se actualizan.

Por lo general, estos eventos que desencadenan los triggers son cambios en las tablas mediante operaciones de inserción, eliminación y actualización de datos (insert, delete y update).

## **Hay dos clases de Triggers en SQL**

### **Triggers DDL (Data Definition Language)**

Esta clase de Triggers se activa en eventos que modifican la estructura de la base de datos (como crear, modificar o eliminar una tabla) o en ciertos eventos relacionados con el servidor, como cambios de seguridad o actualización de eventos estadísticos.

### **Triggers DML (Data Modification Language)**

Esta es la clase más común de Triggers. En este caso, el evento de disparo es una declaración de modificación de datos; podría ser una declaración de inserción, actualización o eliminación en una tabla o vista.

## **Cómo usar un Trigger en SQL**

La instrucción **CREATE TRIGGER** permite crear un nuevo trigger que se activa automáticamente cada vez que ocurre un evento, como **INSERT**, **DELETE** o **UPDATE**, en una tabla.

La sintaxis de la instrucción **CREATE TRIGGER**:

```SQL
CREATE TRIGGER nombre_trigger
ON nombre_tabla AFTER (INSERT, UPDATE o DELETE) AS (
  /* SQL */
);
```

## **Resumen y consejos para utilizar TRIGGER**:

En resumen un TRIGGER sirve para:

- Ejecutar un código SQL cuando ocurra un evento en concreto: **INSERT**, **UPDATE** o **DELETE**.
- Ayudar a mantener la integridad de la información
- Manipular la información de una consulta en concreto ANTES o DESPUES de su ejecución.

## Objetivos de Aprendizaje:

- Entender el concepto y tipos de triggers en bases de datos.

- Implementar triggers para auditoría y control de operaciones.

## Criterios de Evaluación:

- Funcionalidad de los triggers en los casos de prueba.

- Impacto en la integridad y seguridad de los datos.

- Claridad en la documentación y pruebas.

## Tareas:

- Definir triggers de auditorías por cada update o delete sobre alguna tabla del modelo que pueda registrar en tablas auxiliares los valores de los registros antes de un borrado o modificación de cualquier dato, más la fecha, hora y usuario de la base de datos que realizó la operación.

- Definir un trigger que al intentar realizar un delete sobre una tabla emita un mensaje y no permita realizar la operación.

- Expresar las conclusiones en base a las pruebas realizadas.
