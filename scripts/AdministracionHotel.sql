--CREATE DATABASE ADMINISTRACION_HOTEL;

--USE ADMINISTRACION_HOTEL;

CREATE TABLE HUESPEDES (
  DNI INT NOT NULL,
  NOMBRE_APELLIDO VARCHAR(50) NOT NULL,
  FECHA_NACIMIENTO DATE NOT NULL,
  CONSTRAINT PK_DNI_HUESPED PRIMARY KEY (DNI)
);

CREATE TABLE PISOS (
  ID_PISO INT NOT NULL,
  NUMERO_PISO INT NOT NULL,
  CONSTRAINT PK_ID_PISO PRIMARY KEY (ID_PISO)
);



CREATE TABLE ESTADO_HABITACION (
  ID_ESTADO INT NOT NULL,
  NOMBRE VARCHAR(25) NOT NULL,
  CONSTRAINT PK_ID_ESTADO_HABITACION PRIMARY KEY (ID_ESTADO)
);

CREATE TABLE TIPOS_HABITACIONES (
  ID_TIPO_HABITACION INT NOT NULL,
  NOMBRE VARCHAR(25) NOT NULL,
  PRECIO FLOAT NOT NULL,
  CONSTRAINT PK_ID_TIPO_HABITACION PRIMARY KEY (ID_TIPO_HABITACION)
);

CREATE TABLE ESTADOS_RESERVAS (
  ID_ESTADO_RESERVA INT NOT NULL,
  NOMBRE VARCHAR(25) NOT NULL,
  CONSTRAINT PK_ID_ESTADO_RESERVA PRIMARY KEY (ID_ESTADO_RESERVA)
);

CREATE TABLE CARGOS (
  ID_CARGO INT NOT NULL,
  NOMBRE VARCHAR(25) NOT NULL,
  CONSTRAINT PK_ID_CARGO PRIMARY KEY (ID_CARGO)
);

CREATE TABLE EMPLEADOS (
  ID_EMPLEADO INT NOT NULL,
  NOMBRE_APELLIDO VARCHAR(50) NOT NULL,
  HORARIO VARCHAR(50) NOT NULL,
  ID_CARGO INT NOT NULL,
  CONSTRAINT PK_ID_EMPLEADO PRIMARY KEY (ID_EMPLEADO),
  CONSTRAINT FK_ID_CARGO_EMPLEADO FOREIGN KEY (ID_CARGO) REFERENCES CARGOS(ID_CARGO)
);

CREATE TABLE HABITACIONES (
  ID_HABITACION INT NOT NULL,
  NUMERO_HABITACION INT NOT NULL,
  ID_PISO INT NOT NULL,
  ID_ESTADO INT NOT NULL,
  ID_TIPO_HABITACION INT NOT NULL,
  CONSTRAINT PK_ID_HABITACION PRIMARY KEY (ID_HABITACION),
  CONSTRAINT FK_ID_PISO FOREIGN KEY (ID_PISO) REFERENCES PISOS(ID_PISO),
  CONSTRAINT FK_ID_ESTADO_HABITACION FOREIGN KEY (ID_ESTADO) REFERENCES ESTADO_HABITACION(ID_ESTADO),
  CONSTRAINT FK_ID_TIPO_HABITACION FOREIGN KEY (ID_TIPO_HABITACION) REFERENCES TIPOS_HABITACIONES(ID_TIPO_HABITACION)
);

CREATE TABLE RESERVAS (
  ID_RESERVA INT NOT NULL,
  NOMBRE_APELLIDO VARCHAR(50) NOT NULL,
  FECHA_LLEGADA DATETIME NOT NULL CONSTRAINT DF_FECHA_LLEGADA DEFAULT GETDATE(),
  FECHA_SALIDA DATETIME NOT NULL,
  ID_ESTADO_RESERVA INT NOT NULL,
  CONSTRAINT PK_ID_RESERVA PRIMARY KEY (ID_RESERVA),
  CONSTRAINT FK_ID_ESTADO_RESERVA FOREIGN KEY (ID_ESTADO_RESERVA) REFERENCES ESTADOS_RESERVAS(ID_ESTADO_RESERVA),
  CONSTRAINT CK_FECHA CHECK (FECHA_LLEGADA < FECHA_SALIDA)
);

CREATE TABLE SERVICIOS (
  ID_SERVICIO INT NOT NULL,
  NOMBRE VARCHAR(25) NOT NULL,
  PRECIO FLOAT NOT NULL,
  ID_CARGO INT NOT NULL,
  CONSTRAINT PK_ID_SERVICIO PRIMARY KEY (ID_SERVICIO),
  CONSTRAINT FK_ID_CARGO_SERVICIO FOREIGN KEY (ID_CARGO) REFERENCES CARGOS(ID_CARGO)
);

CREATE TABLE RECIBOS (
  ID_RECIBO INT NOT NULL,
  FECHA_PAGO DATETIME NOT NULL CONSTRAINT DF_FECHA_PAGO DEFAULT GETDATE(),
  TOTAL_PAGO FLOAT NOT NULL,
  ID_RESERVA INT NOT NULL,
  CONSTRAINT PK_ID_RECIBO PRIMARY KEY (ID_RECIBO),
  CONSTRAINT FK_ID_RESERVA_RECIBO FOREIGN KEY (ID_RESERVA) REFERENCES RESERVAS(ID_RESERVA)
);

CREATE TABLE RESERVAS_HUESPEDES (
  ID_RESERVA INT NOT NULL,
  DNI INT NOT NULL,
  ID_HABITACION INT NOT NULL,
  CONSTRAINT PK_RESERVAS_HUESPEDES PRIMARY KEY (ID_RESERVA, DNI, ID_HABITACION),
  CONSTRAINT FK_ID_RESERVA_RESERVAS_HUESPEDES FOREIGN KEY (ID_RESERVA) REFERENCES RESERVAS(ID_RESERVA),
  CONSTRAINT FK_DNI_RESERVAS_HUESPEDES FOREIGN KEY (DNI) REFERENCES HUESPEDES(DNI),
  CONSTRAINT FK_ID_HABITACION_RESERVAS_HUESPEDES FOREIGN KEY (ID_HABITACION) REFERENCES HABITACIONES(ID_HABITACION)
);

CREATE TABLE RESERVAS_SERVICIOS (
  ID_RESERVA_SERVICIO INT NOT NULL,
  ID_RESERVA INT NOT NULL,
  ID_SERVICIO INT NOT NULL,
  CONSTRAINT PK_RESERVAS_SERVICIOS PRIMARY KEY (ID_RESERVA_SERVICIO),
  CONSTRAINT FK_ID_SERVICO_RESERVAS_SERVICIOS FOREIGN KEY (ID_SERVICIO) REFERENCES SERVICIOS(ID_SERVICIO),
  CONSTRAINT FK_ID_RESERVA_RESERVAS_SERVICIOS FOREIGN KEY (ID_RESERVA) REFERENCES RESERVAS(ID_RESERVA)
);