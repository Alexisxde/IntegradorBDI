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

La sintaxis de la instrucción **`CREATE TRIGGER`**:

```SQL
CREATE TRIGGER nombre_trigger
ON nombre_tabla FOR (INSERT o UPDATE o DELETE) AS SET NOCOUNT ON
BEGIN
  /* SQL */
END;
```

## **Resumen y consejos para utilizar `TRIGGER`**:

En resumen un TRIGGER sirve para:

- Ejecutar un código SQL cuando ocurra un evento en concreto: **`INSERT`**, **`UPDATE`** o **`DELETE`**.
- Ayudar a mantener la integridad de la información
- Manipular la información de una consulta en concreto ANTES o DESPUES de su ejecución.

## **Crear la tabla de auditoría**

Esta tabla almacenará los valores antiguos antes de una actualización o eliminación. Además, se registrará la fecha, hora y el usuario de la base de datos.

```SQL
CREATE TABLE AUDITORIA_EMPLEADOS (
  ID_AUDITORIA_EMPLEADO INT IDENTITY(1, 1),
  NOMBRE_APELLIDO VARCHAR(50) NOT NULL,
  HORARIO VARCHAR(50) NOT NULL,
  ID_CARGO INT NOT NULL,
  FECHA DATETIME,
  USUARIOBD VARCHAR(128),
  OPERACION VARCHAR(10),
  CONSTRAINT PK_AUDITORIA_EMPLEADOS PRIMARY KEY(ID_AUDITORIA_EMPLEADO),
  CONSTRAINT FK_ID_CARGO_AUDITORIA_EMPLEADO FOREIGN KEY (ID_CARGO) REFERENCES CARGOS(ID_CARGO)
);
```

### **Crear el `TRIGGER` para `UPDATE`**

Este trigger registrará los valores antes de una actualización:

```SQL
CREATE TRIGGER TRG_AUDITORIA_UPDATE_EMPLEADOS
ON EMPLEADOS FOR UPDATE AS SET NOCOUNT ON
BEGIN
  INSERT INTO AUDITORIA_EMPLEADOS
    SELECT
      DELETED.ID_EMPLEADO,
      DELETED.NOMBRE_APELLIDO,
      DELETED.HORARIO,
      DELETED.ID_CARGO,
      GETDATE() AS FECHA,
      SUSER_SNAME() AS USUARIOBD,
      'UPDATE' AS OPERACION
    FROM DELETED;
END;
```

### **Crear el `TRIGGER` para `DELETE`**

Este trigger registrará los valores antes de una eliminación:

```SQL
CREATE TRIGGER TRG_AUDITORIA_DELETE_EMPLEADOS
ON EMPLEADOS FOR DELETE AS SET NOCOUNT ON
BEGIN
  INSERT INTO AUDITORIA_EMPLEADOS
    SELECT
      DELETED.ID_EMPLEADO,
      DELETED.NOMBRE_APELLIDO,
      DELETED.HORARIO,
      DELETED.ID_CARGO,
      GETDATE() AS FECHA,
      SUSER_SNAME() AS USUARIOBD,
      'DELETE' AS OPERACION
    FROM DELETED;
END;
```

```SQL
SELECT * FROM EMPLEADOS;
```

| ID_EMPLEADO |  NOMBRE_APELLIDO  |   HORARIOS    | ID_CARGO |
| :---------: | :---------------: | :-----------: | :------: |
|      1      |    Enzo Pérez     | 09:00 - 17:00 |    1     |
|      2      |   Alexis Gómez    | 10:00 - 18:00 |    1     |
|      3      | Facundo Fernández | 07:00 - 16:00 |    2     |
|      4      |   Carlos López    | 12:00 - 20:00 |    2     |
|      5      |    Jorge Ruiz     | 14:00 - 22:00 |    3     |

```SQL
DELETE FROM EMPLEADOS WHERE ID_EMPLEADO = 1;
DELETE FROM EMPLEADOS WHERE ID_EMPLEADO = 2;
UPDATE EMPLEADOS SET HORARIO = '7:00 - 16:00' WHERE ID_EMPLEADO = 3;

SELECT * FROM AUDITORIA_EMPLEADOS;
```

| ID  | ID_EMPLEADO |  NOMBRE_APELLIDO  |   HORARIOS    | ID_CARGO |        FECHA        | USUARIOBD | OPERACION |
| :-: | :---------: | :---------------: | :-----------: | :------: | :-----------------: | :-------: | :-------: |
|  1  |      1      |    Enzo Pérez     | 09:00 - 17:00 |    1     | 2024-10-30 21:13:16 |  ALEXIS   |  DELETE   |
|  2  |      2      |   Alexis Gómez    | 10:00 - 18:00 |    1     | 2024-10-30 21:18:49 |  ALEXIS   |  DELETE   |
|  3  |      3      | Facundo Fernández | 07:00 - 15:00 |    2     | 2024-10-30 21:20:23 |  ALEXIS   |  UPDATE   |

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
