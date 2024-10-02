--Lote de datos DE ADMINISTRCION DE HOTELES

SELECT * FROM HUESPEDES

INSERT INTO HUESPEDES (DNI, NOMBRE_APELLIDO, FECHA_NACIMIENTO) VALUES (12345678, 'Juan P�rez', '1985-03-15');
INSERT INTO HUESPEDES (DNI, NOMBRE_APELLIDO, FECHA_NACIMIENTO) VALUES (87654321, 'Ana G�mez', '1990-07-22');
INSERT INTO HUESPEDES (DNI, NOMBRE_APELLIDO, FECHA_NACIMIENTO) VALUES (23456789, 'Luis Fern�ndez', '1978-11-05');
INSERT INTO HUESPEDES (DNI, NOMBRE_APELLIDO, FECHA_NACIMIENTO) VALUES (34567890, 'Mar�a L�pez', '1995-02-10');
INSERT INTO HUESPEDES (DNI, NOMBRE_APELLIDO, FECHA_NACIMIENTO) VALUES (45678901, 'Carlos Ruiz', '1982-09-30');

SELECT * FROM PISOS

INSERT INTO PISOS (ID_PISO, NUMERO_PISO) VALUES (1, 1);
INSERT INTO PISOS (ID_PISO, NUMERO_PISO) VALUES (2, 2);
INSERT INTO PISOS (ID_PISO, NUMERO_PISO) VALUES (3, 3);

SELECT * FROM ESTADO_HABITACION

INSERT INTO ESTADO_HABITACION (ID_ESTADO, NOMBRE) VALUES (1, 'Disponible');
INSERT INTO ESTADO_HABITACION (ID_ESTADO, NOMBRE) VALUES (2, 'Ocupada');
INSERT INTO ESTADO_HABITACION (ID_ESTADO, NOMBRE) VALUES (3, 'Reservada');
INSERT INTO ESTADO_HABITACION (ID_ESTADO, NOMBRE) VALUES (4, 'Mantenimiento');


SELECT * FROM TIPOS_HABITACIONES

INSERT INTO TIPOS_HABITACIONES (ID_TIPO_HABITACION, NOMBRE, PRECIO) VALUES (1, 'Individual', 50000.00);
INSERT INTO TIPOS_HABITACIONES (ID_TIPO_HABITACION, NOMBRE, PRECIO) VALUES (2, 'Doble', 100000.00);
INSERT INTO TIPOS_HABITACIONES (ID_TIPO_HABITACION, NOMBRE, PRECIO) VALUES (3, 'Suite', 150000.00);

SELECT * FROM ESTADOS_RESERVAS

INSERT INTO ESTADOS_RESERVAS (ID_ESTADO_RESERVA, NOMBRE) VALUES (1, 'Aprobada');
INSERT INTO ESTADOS_RESERVAS (ID_ESTADO_RESERVA, NOMBRE) VALUES (2, 'Reservada');
INSERT INTO ESTADOS_RESERVAS (ID_ESTADO_RESERVA, NOMBRE) VALUES (3, 'Cancelada');
INSERT INTO ESTADOS_RESERVAS (ID_ESTADO_RESERVA, NOMBRE) VALUES (4, 'Finalizada');

SELECT * FROM CARGOS

INSERT INTO CARGOS (ID_CARGO, NOMBRE) VALUES (1, 'Recepcionista');
INSERT INTO CARGOS (ID_CARGO, NOMBRE) VALUES (2, 'Gerente');
INSERT INTO CARGOS (ID_CARGO, NOMBRE) VALUES (3, 'Limpiador');
INSERT INTO CARGOS (ID_CARGO, NOMBRE) VALUES (4, 'Cocinero');
INSERT INTO CARGOS (ID_CARGO, NOMBRE) VALUES (5, 'Conserje');

SELECT * FROM EMPLEADOS

INSERT INTO EMPLEADOS (ID_EMPLEADO, NOMBRE_APELLIDO, HORARIO, ID_CARGO) VALUES (1, 'Enzo P�rez', '9:00 - 17:00', 1);
INSERT INTO EMPLEADOS (ID_EMPLEADO, NOMBRE_APELLIDO, HORARIO, ID_CARGO) VALUES (2, 'Alexis G�mez', '10:00 - 18:00', 1);
INSERT INTO EMPLEADOS (ID_EMPLEADO, NOMBRE_APELLIDO, HORARIO, ID_CARGO) VALUES (3, 'Facundo Fern�ndez', '7:00 - 15:00', 2);
INSERT INTO EMPLEADOS (ID_EMPLEADO, NOMBRE_APELLIDO, HORARIO, ID_CARGO) VALUES (4, 'Carlos L�pez', '12:00 - 20:00', 2);
INSERT INTO EMPLEADOS (ID_EMPLEADO, NOMBRE_APELLIDO, HORARIO, ID_CARGO) VALUES (5, 'Jorge Ruiz', '14:00 - 22:00', 3);
INSERT INTO EMPLEADOS (ID_EMPLEADO, NOMBRE_APELLIDO, HORARIO, ID_CARGO) VALUES (6, 'Juan P�rez', '9:00 - 17:00', 3);
INSERT INTO EMPLEADOS (ID_EMPLEADO, NOMBRE_APELLIDO, HORARIO, ID_CARGO) VALUES (7, 'Ana G�mez', '10:00 - 18:00', 4);
INSERT INTO EMPLEADOS (ID_EMPLEADO, NOMBRE_APELLIDO, HORARIO, ID_CARGO) VALUES (8, 'Luis Fern�ndez', '7:00 - 15:00', 4);
INSERT INTO EMPLEADOS (ID_EMPLEADO, NOMBRE_APELLIDO, HORARIO, ID_CARGO) VALUES (9, 'Mar�a L�pez', '12:00 - 20:00', 5);
INSERT INTO EMPLEADOS (ID_EMPLEADO, NOMBRE_APELLIDO, HORARIO, ID_CARGO) VALUES (10, 'Javier Ruiz', '14:00 - 22:00', 5);

SELECT * FROM HABITACIONES

INSERT INTO HABITACIONES (ID_HABITACION, NUMERO_HABITACION, ID_PISO, ID_ESTADO, ID_TIPO_HABITACION) VALUES (1, 101, 1, 1, 1);
INSERT INTO HABITACIONES (ID_HABITACION, NUMERO_HABITACION, ID_PISO, ID_ESTADO, ID_TIPO_HABITACION) VALUES (2, 102, 1, 2, 2);
INSERT INTO HABITACIONES (ID_HABITACION, NUMERO_HABITACION, ID_PISO, ID_ESTADO, ID_TIPO_HABITACION) VALUES (3, 201, 2, 1, 3);
INSERT INTO HABITACIONES (ID_HABITACION, NUMERO_HABITACION, ID_PISO, ID_ESTADO, ID_TIPO_HABITACION) VALUES (4, 202, 2, 3, 1);
INSERT INTO HABITACIONES (ID_HABITACION, NUMERO_HABITACION, ID_PISO, ID_ESTADO, ID_TIPO_HABITACION) VALUES (5, 301, 3, 4, 2);

SELECT * FROM RESERVAS

INSERT INTO RESERVAS (ID_RESERVA, NOMBRE_APELLIDO, FECHA_LLEGADA, FECHA_SALIDA, ID_ESTADO_RESERVA) VALUES (1, 'Juan Lopez',GETDATE(),'2024-10-10 12:00:00', 2);
INSERT INTO RESERVAS (ID_RESERVA, NOMBRE_APELLIDO, FECHA_LLEGADA, FECHA_SALIDA, ID_ESTADO_RESERVA) VALUES (2, 'Ana Zabala',GETDATE(),'2024-10-20 11:00:00', 1);
INSERT INTO RESERVAS (ID_RESERVA, NOMBRE_APELLIDO, FECHA_LLEGADA, FECHA_SALIDA, ID_ESTADO_RESERVA) VALUES (3, 'Luis Mendoza',GETDATE(),'2024-11-05 10:00:00', 3);
INSERT INTO RESERVAS (ID_RESERVA, NOMBRE_APELLIDO, FECHA_LLEGADA, FECHA_SALIDA, ID_ESTADO_RESERVA) VALUES (4, 'Mar�a Castillo',GETDATE(),'2024-10-28 09:00:00', 2);
INSERT INTO RESERVAS (ID_RESERVA, NOMBRE_APELLIDO, FECHA_LLEGADA, FECHA_SALIDA, ID_ESTADO_RESERVA) VALUES (5, 'Carlos Sanchez',GETDATE(),'2024-11-02 12:00:00', 1);

SELECT * FROM SERVICIOS

INSERT INTO SERVICIOS (ID_SERVICIO, NOMBRE, PRECIO, ID_CARGO) VALUES (1, 'Desayuno',20000, 4);
INSERT INTO SERVICIOS (ID_SERVICIO, NOMBRE, PRECIO, ID_CARGO) VALUES (2, 'Servicio de Habitaci�n', 30000.00, 1);
INSERT INTO SERVICIOS (ID_SERVICIO, NOMBRE, PRECIO, ID_CARGO) VALUES (3, 'Limpieza Estra', 10000, 3);
INSERT INTO SERVICIOS (ID_SERVICIO, NOMBRE, PRECIO, ID_CARGO) VALUES (4, 'Plan de Cena', 20000, 4);

SELECT * FROM RECIBOS

INSERT INTO RECIBOS (ID_RECIBO, FECHA_PAGO, TOTAL_PAGO, ID_RESERVA) VALUES (1, '2024-10-05 14:30:00', 50000.00, 1);
INSERT INTO RECIBOS (ID_RECIBO, FECHA_PAGO, TOTAL_PAGO, ID_RESERVA) VALUES (2, '2024-10-15 16:45:00', 30000.00, 2);
INSERT INTO RECIBOS (ID_RECIBO, FECHA_PAGO, TOTAL_PAGO, ID_RESERVA) VALUES (3, '2024-11-01 10:15:00', 40000.00, 3);
INSERT INTO RECIBOS (ID_RECIBO, FECHA_PAGO, TOTAL_PAGO, ID_RESERVA) VALUES (4, '2024-10-25 12:00:00', 20000.00, 4);
INSERT INTO RECIBOS (ID_RECIBO, FECHA_PAGO, TOTAL_PAGO, ID_RESERVA) VALUES (5, '2024-10-30 17:30:00', 35000.00, 5);

SELECT * FROM RESERVAS_HUESPEDES

INSERT INTO RESERVAS_HUESPEDES (ID_RESERVA, DNI, ID_HABITACION) VALUES (1, 12345678, 1);
INSERT INTO RESERVAS_HUESPEDES (ID_RESERVA, DNI, ID_HABITACION) VALUES (2, 87654321, 2);
INSERT INTO RESERVAS_HUESPEDES (ID_RESERVA, DNI, ID_HABITACION) VALUES (3, 23456789, 3);
INSERT INTO RESERVAS_HUESPEDES (ID_RESERVA, DNI, ID_HABITACION) VALUES (4, 34567890, 4);
INSERT INTO RESERVAS_HUESPEDES (ID_RESERVA, DNI, ID_HABITACION) VALUES (5, 45678901, 5);

SELECT * FROM RESERVAS_SERVICIOS

INSERT INTO RESERVAS_SERVICIOS (ID_SERVICIO, ID_RESERVA) VALUES (1, 1);
INSERT INTO RESERVAS_SERVICIOS (ID_SERVICIO, ID_RESERVA) VALUES (2, 1);
INSERT INTO RESERVAS_SERVICIOS (ID_SERVICIO, ID_RESERVA) VALUES (3, 2);
INSERT INTO RESERVAS_SERVICIOS (ID_SERVICIO, ID_RESERVA) VALUES (4, 3);
INSERT INTO RESERVAS_SERVICIOS (ID_SERVICIO, ID_RESERVA) VALUES (5, 4);










