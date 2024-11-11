# Tema: Manejo de permisos a nivel de usuarios de base de datos

## **¿Qué es un usuario?**

Un usuario es una entidad de seguridad que permite a una persona o aplicación acceder a una base de datos. En SQL Server, los usuarios están generalmente vinculados a un inicio de sesión, que es el mecanismo que autentica a la entidad en el servidor. Sin embargo, en una base de datos contenida, los usuarios se gestionan dentro de la propia base de datos, sin necesidad de depender de un inicio de sesión a nivel de servidor

## **¿Qué son los inicios de sesión?**

Un inicio de sesión es una entidad de seguridad que permite la autenticación a nivel de servidor. En SQL Server, puedes usar autenticación de Windows (basada en Active Directory) o autenticación de SQL Server (donde el login tiene una contraseña propia gestionada por el servidor de SQL).

## **¿Cómo se crean los usuarios e inicios de sesión en SQL Server?**

El inicio de sesión permite acceder al servidor SQL, mientras que el usuario de base de datos define qué acciones puede realizar esa entidad en una base de datos específica. Ambos están conectados, pero el usuario gestiona los permisos dentro de la base de datos.

Se puede usar la interfaz que brinda SQL Server o usando Transact SQL (T-SQL), el cual es una variante del SQL estandar, diseñada especificamente para SQL Server. Nosotros utilizamos lenguaje T-SQL. Se utilizan las siguientes clausulas:

```SQL
CREATE LOGIN NombreUsuario WITH PASSWORD = 'Contraseña'; -- Creamos un inicio de sesión.
CREATE USER NombreUsuario FOR LOGIN NombreUsuario; -- Creamos un usuario y lo vinculamos con el inicio de sesión creado.
```

## **¿Qué es una base de datos contenida?**

Es una base de datos que gestiona por sí misma a sus propios usuarios y autenticación, sin depender del inicio de sesión (login) a nivel de servidor. Esto permite que los usuarios se creen dentro de la base de datos (usuarios contenidos) y tengan su propia contraseña, lo que facilita la migración de bases de datos entre diferentes servidores.

## **¿Qué son y cómo se otorgan los permisos?**

Son derechos que se pueden otorgar a un usuario, estos determinan lo que tiene o no tiene permitido hacer en la base de datos. Alguno de los permisos más usados son los siguientes:

- `SELECT`: Permite ver o consultar datos (leer información de una tabla).
- `INSERT`: Permite agregar nuevos registros a una tabla.
- `UPDATE`: Permite modificar registros existentes.
- `DELETE`: Permite eliminar registros de una tabla.
- `EXECUTE`: Permite ejecutar procedimientos almacenados

Para otorgar algún permiso usando T-SQL, se usan las siguientes clausulas:

```SQL
-- Asignamos el permiso de insertar al usuario Gerente_Carlos.
GRANT INSERT -- Se puede otorgar más de un permiso, separandolos con coma.
ON dbo.CARGOS -- Se selecciona la tabla especifica.
TO GERENTE_CARLOS; -- Se escribe el usuario al que se le asigna el permiso, sin comillas simples.
```

## **¿Qué son y cómo se otorgan los roles?**

Los roles en SQL Server son conjuntos de permisos predefinidos que facilitan la administración. Los roles pueden aplicarse a nivel de base de datos o servidor. Esto permite una gestión más sencilla al asignar permisos a grupos de usuarios.

SQL Server brinda de forma predeterminada una amplia lista de roles, entre los más comunes encontramos los siguientes:

- db_owner: Tiene todos los permisos sobre la base de datos.
- db_securityadmin: Gestiona roles y permisos dentro de la base de datos.
- db_datawriter: Puede escribir datos en todas las tablas de la base de datos.
- db_ddladmin: Puede ejecutar comandos DDL (crear, modificar tablas,procedimientos, etc.).

Para otorgar estos permisos usamos las siguientes clausulas:

```SQL
USE ADMINISTRACION_HOTEL; -- Seleccionamos la base de datos donde queremos que se cree el rol.
CREATE ROLE SUPERVISORES; -- Creamos el rol.
GRANT SELECT ON dbo.CARGOS TO SUPERVISORES; -- Le asignamos los permisos de lectura en la tabla CARGOS.
ALTER ROLE SUPERVISORES ADD MEMBER SUPERVISOR_FACUNDO; -- Agregamos un usuario al rol creado.
```

## Tareas

> Ver el script para entender más [script.sql](script.sql)

## **Conclusión**

El manejo de permisos a nivel de usuarios en bases de datos es un componente crítico para garantizar la seguridad y control sobre la información. SQL Server proporciona un sistema robusto que permite tanto la autenticación (a través de inicios de sesión y usuarios) como la autorización (mediante permisos y roles) para gestionar el acceso a los datos.

El uso de roles y permisos bien estructurados no solo asegura que cada usuario tenga acceso únicamente a la información que necesita, sino que también facilita la administración de grandes sistemas con múltiples usuarios y bases de datos.

En este caso de estudio, pudimos descubrir que un buen manejo de los permisos a nivel de usuarios es esencial para proteger los datos y optimizar la gestión de los recursos dentro de cualquier base de datos en SQL Server.
