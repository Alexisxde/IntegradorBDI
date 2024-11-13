/*
 * Definir triggers de auditorías por cada update o delete sobre alguna
 * tabla del modelo que pueda registrar en tablas auxiliares los valores
 * de los registros antes de un borrado o modificación de cualquier dato,
 * más la fecha, hora y usuario de la base de datos que realizó la operación.
*/

/*
 * Crear la tabla de auditoría
 *
 * Esta tabla almacenará los valores antiguos después
 * de una actualización o eliminación. Además, se registrará
 * la fecha, hora y el usuario de la base de datos. 
*/
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

/*
 * Crear el `TRIGGER` para `UPDATE`
 * 
 * Este trigger registrará los valores después de una actualización:
*/
CREATE TRIGGER TRG_AUDITORIA_UPDATE_EMPLEADOS
ON EMPLEADOS AFTER UPDATE AS SET NOCOUNT ON
BEGIN
  INSERT INTO AUDITORIA_EMPLEADOS
    SELECT
      DELETED.ID_EMPLEADO,
      DELETED.NOMBRE_APELLIDO,
      DELETED.HORARIO,
      DELETED.ID_CARGO,
      GETDATE() AS FECHA,
      SYSTEM_USER AS USUARIOBD,
      'UPDATE' AS OPERACION
    FROM DELETED;
END;

/* 
 * Crear el `TRIGGER` para `DELETE`
 *
 * Este trigger registrará los valores después de una eliminación:
*/
CREATE TRIGGER TRG_AUDITORIA_DELETE_EMPLEADOS
ON EMPLEADOS AFTER DELETE AS SET NOCOUNT ON
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

SELECT * FROM EMPLEADOS;
-- | ID_EMPLEADO |  NOMBRE_APELLIDO  |   HORARIOS    | ID_CARGO |
-- | :---------: | :---------------: | :-----------: | :------: |
-- |      1      |    Enzo Pérez     | 09:00 - 17:00 |    1     |
-- |      2      |   Alexis Gómez    | 10:00 - 18:00 |    1     |
-- |      3      | Facundo Fernández | 07:00 - 15:00 |    2     |
-- |      4      |   Carlos López    | 12:00 - 20:00 |    2     |
-- |      5      |    Jorge Ruiz     | 14:00 - 22:00 |    3     |

DELETE FROM EMPLEADOS WHERE ID_EMPLEADO = 1;
DELETE FROM EMPLEADOS WHERE ID_EMPLEADO = 2;
UPDATE EMPLEADOS SET HORARIO = '7:00 - 16:00' WHERE ID_EMPLEADO = 3;

SELECT * FROM AUDITORIA_EMPLEADOS;
-- | ID_AUDITORIA_EMPLEADO  | ID_EMPLEADO |  NOMBRE_APELLIDO  |   HORARIOS    | ID_CARGO |        FECHA        | USUARIOBD | OPERACION |
-- | :--------------------: | :---------: | :---------------: | :-----------: | :------: | :-----------------: | :-------: | :-------: |
-- |           1            |      1      |    Enzo Pérez     | 09:00 - 17:00 |    1     | 2024-10-30 21:13:16 |  ALEXIS   |  DELETE   |
-- |           2            |      2      |   Alexis Gómez    | 10:00 - 18:00 |    1     | 2024-10-30 21:18:49 |  ALEXIS   |  DELETE   |
-- |           3            |      3      | Facundo Fernández | 07:00 - 15:00 |    2     | 2024-10-30 21:20:23 |  ALEXIS   |  UPDATE   |

/*
 * Definir un trigger que al intentar realizar un delete sobre una tabla
 * emita un mensaje y no permita realizar la operación.
*/
CREATE TRIGGER TRG_DELETE_RESERVAS
ON RESERVAS INSTEAD OF DELETE AS SET NOCOUNT ON
BEGIN
  PRINT 'No se permite la eliminación de registros en esta tabla.';
END;

SELECT * FROM RESERVAS;
-- | ID_RESERVA | NOMBRE_APELLIDO |      FECHA_LLEGADA      |      FECHA_SALIDA       | ID_ESTADO_RESERVA |
-- | :--------: | :-------------: | :---------------------: | :---------------------: | :---------------: |
-- |     3      |  Luis Mendoza   | 2024-10-30 20:04:10.230 | 2024-11-05 10:00:00.000 |         3         |
-- |     5      | Carlos Sanchez  | 2024-10-30 20:04:10.260 | 2024-11-02 12:00:00.000 |         1         |

DELETE FROM RESERVAS WHERE ID_RESERVA = 3;
-- ! No se permite la eliminación de registros en esta tabla.
-- 
-- ? Completion time: 2024-11-11T19:01:31.2004397-03:00

/*
 * Expresar las conclusiones en base a las pruebas realizadas. 
*/
-- TODO: Triggers de Auditoría en la Tabla EMPLEADOS
-- * DELETE: Cada vez que se ejecuta una eliminación en la tabla EMPLEADOS,
-- * el trigger TRG_AUDITORIA_DELETE_EMPLEADOS almacena un registro en la tabla AUDITORIA_EMPLEADOS
-- * con los datos previos al borrado, junto con la fecha, el usuario de la base de datos
-- * y el tipo de operación (DELETE). Esto asegura que se mantenga un historial de los datos eliminados.

-- * UPDATE: El trigger TRG_AUDITORIA_UPDATE_EMPLEADOS realiza una función
-- * similar al anterior, guardando los datos previos a una actualización en la tabla de
-- * auditoría, permitiendo así registrar cualquier cambio realizado sobre los datos de la tabla EMPLEADOS.

-- * Estas pruebas confirman que ambos triggers de auditoría cumplen correctamente
-- * su función, manteniendo un historial de los datos antes de su modificación o eliminación,
-- * con un registro de la fecha, hora y usuario responsable.

-- TODO: Verificación de los Resultados en la Tabla de Auditoría AUDITORIA_EMPLEADOS:
-- * Al consultar la tabla AUDITORIA_EMPLEADOS, se puede observar que los registros
-- * de auditoría se han almacenado correctamente, con los datos antes de las operaciones
-- * de DELETE y UPDATE, incluyendo el nombre del usuario, la fecha y hora de la operación, y el tipo de operación realizada.

-- TODO: Restricción de Eliminación en la Tabla RESERVAS:
-- * Al intentar realizar una eliminación en la tabla RESERVAS, el trigger TRG_DELETE_RESERVAS
-- * bloquea la operación y emite el mensaje "No se permite la eliminación de registros en esta tabla."
-- * Esto impide cualquier intento de borrado.

-- * Este trigger ha demostrado ser eficaz para evitar eliminaciones no autorizadas
-- * en la tabla RESERVAS, manteniendo así la integridad de los datos en esta entidad.
