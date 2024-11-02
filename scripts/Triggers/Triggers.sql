/*
 * Crear la tabla de auditoría
 *
 * Esta tabla almacenará los valores antiguos antes
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
 * Este trigger registrará los valores antes de una actualización:
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
      SUSER_SNAME() AS USUARIOBD,
      'UPDATE' AS OPERACION
    FROM DELETED;
END;

/* 
 * Crear el `TRIGGER` para `DELETE`
 *
 * Este trigger registrará los valores antes de una eliminación:
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
-- |      3      | Facundo Fernández | 07:00 - 16:00 |    2     |
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


-- - Definir un trigger que al intentar realizar un delete sobre una tabla emita un mensaje y no permita realizar la operación.
-- - Expresar las conclusiones en base a las pruebas realizadas.