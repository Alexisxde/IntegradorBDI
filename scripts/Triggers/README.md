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
ON nombre_tabla AFTER (INSERT o UPDATE o DELETE) AS SET NOCOUNT ON
BEGIN
  -- SQL
END;
```

> [!IMPORTANT]  
> Un `TRIGGER` no puede existir sin una tabla asociada.

> [!CAUTION]
> La sentencia `TRUNCATE` no ejecutará ningun `TRIGGER`

## **Tipos de `TRIGGER` en SQL Server**

### `AFTER`

- Se ejecutan después de que una operación INSERT, UPDATE o DELETE ha ocurrido.
- Útiles para realizar acciones una vez que los datos ya están modificados en la base de datos, como registros en una tabla de auditoría.

### `INSTEAD OF`

- Se ejecutan en lugar de la operación INSERT, UPDATE o DELETE.
- Útiles cuando quieres anular o modificar el comportamiento predeterminado de la operación, o cuando quieres controlar complejamente qué datos se insertan o actualizan.

## **Pseudotablas `INSERTED` y `DELETED`**

En SQL Server se pueden usar las pseudotablas `INSERTED` y `DELETED`. Estas pseudotablas se utilizan principalmente en triggers para manejar los datos antes y después de una operación.

`INSERTED:` Contiene las nuevas filas que están siendo insertadas o actualizadas.
`DELETED:` Contiene las filas antiguas que están siendo eliminadas o actualizadas.

## **Resumen y consejos para utilizar `TRIGGER`**:

En resumen un TRIGGER sirve para:

- Ejecutar un código SQL cuando ocurra un evento en concreto: **`INSERT`** o **`UPDATE`** o **`DELETE`**.
- Ayudar a mantener la integridad de la información
- Manipular la información de una consulta en concreto ANTES o DESPUES de su ejecución.

## **Ejemplos de usos de `TRIGGERS`**

### **Crear la tabla de auditoría**

Esta tabla almacenará los valores antiguos antes
de una actualización o eliminación. Además, se registrará
la fecha, hora y el usuario de la base de datos.

```SQL
CREATE TABLE EMPLEADOS (
  ID_EMPLEADO INT NOT NULL,
  NOMBRE_APELLIDO VARCHAR(50) NOT NULL,
  HORARIO VARCHAR(50) NOT NULL,
  ID_CARGO INT NOT NULL,
  CONSTRAINT PK_ID_EMPLEADO PRIMARY KEY (ID_EMPLEADO),
  CONSTRAINT FK_ID_CARGO_EMPLEADO FOREIGN KEY (ID_CARGO) REFERENCES CARGOS(ID_CARGO)
);

CREATE TABLE AUDITORIA_EMPLEADOS (
  ID_AUDITORIA_EMPLEADO INT IDENTITY(1, 1),
  ID_EMPLEADO INT NOT NULL,
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

#### **Ejemplo `AFTER`**

Este trigger registrará los valores después de una actualización:

```SQL
CREATE TRIGGER TRG_AUDITORIA_UPDATE_EMPLEADOS_AFTER
ON EMPLEADOS AFTER UPDATE AS SET NOCOUNT ON
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

En este ejemplo:

- Se registra en la tabla AUDITORIA_EMPLEADOS los valores antiguos de los empleados.
- `DELETED` contiene los valores antiguos.

#### **Ejemplo `INSTEAD OF`**

Se usa para controlar cómo se manejan las operaciones en la tabla. En este ejemplo, se evita que se borren las reservas que hayan sido aprobadas.

```SQL
CREATE TRIGGER TRG_DELETE_RESERVAS_INSTEAD_OF
ON RESERVAS INSTEAD OF DELETE AS SET NOCOUNT ON
BEGIN
  DELETE FROM RESERVAS
  WHERE ID_ESTADO_RESERVA IN (SELECT ID_ESTADO_RESERVA FROM DELETED) AND ID_ESTADO_RESERVA <> 1;
  IF EXISTS (SELECT * FROM DELETED WHERE ID_ESTADO_RESERVA = 1)
  BEGIN
    PRINT 'No se pueden eliminar las reservas que ya estan aprobadas.';
  END
END;
```

En este ejemplo:

Solo se eliminan las reservas que cuyo ID_ESTADO_RESERVA es distinto a 1. Si intentas eliminar una reserva con ID_ESTADO_RESERVA = 1, el trigger previene la eliminación e imprime un mensaje.

### **Eliminación de un `TRIGGER`**

Para eliminar un trigger en SQL Server:

```SQL
DROP TRIGGER nombre_del_trigger;
```

Puedes verificar los triggers existentes en la base de datos consultando la vista del sistema `sys.triggers`:

```SQL
SELECT name AS TRIGGERS FROM sys.triggers
```

### Evitar el mensaje duplicado al ejecutar un `TRIGGER`

```
(1 row affected)

(1 row affected)

Completion time: 2024-11-02T18:26:55.4199633-03:00
```

> [!TIP]  
> Para evitar el mensaje duplicado, puedes suprimirlo al inicio del trigger usando `SET NOCOUNT ON` para que SQL Server no muestre la cantidad de filas afectadas, esto sirve para que no se sepa que una tabla tiene un `TRIGGER` asociado.

```SQL
CREATE TRIGGER TRG_AUDITORIA_UPDATE_EMPLEADOS_AFTER
ON EMPLEADOS AFTER UPDATE AS SET NOCOUNT ON
BEGIN
  -- SQL
END;
```

Después del `SET NOCOUNT ON`

```
(1 row affected)

Completion time: 2024-11-02T18:26:55.4199633-03:00
```
