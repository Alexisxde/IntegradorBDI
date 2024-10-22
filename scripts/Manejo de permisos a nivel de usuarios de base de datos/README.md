# Tema: Manejo de permisos a nivel de usuarios de base de datos

## Objetivos de Aprendizaje:

- Entender el manejo de permisos y roles en bases de datos.

- Aplicar permisos de lectura, escritura y ejecución para diferentes roles y usuarios.

## Criterios de Evaluación:

- Precisión en la configuración de permisos y roles para usuarios de base de datos.

- Correcta implementación y prueba de restricciones de acceso.

- Documentación detallada del comportamiento de los usuarios según los permisos asignados.

## Tareas:

- Verificar que la base de datos esté configurada en modo mixto (autenticación integrada con windows y por usuario de base de datos).

- Manejo de permisos a nivel de roles y de usuarios. Implementar un caso práctico para cada uno.

## Permisos a nivel de usuarios:

- Crear dos usuarios de base de datos.

- A un usuario darle el permiso de administrador y al otro usuario solo permiso de lectura.

- Utilizar los procedimientos almacenados creados anteriormente.

- Al usuario con permiso de solo lectura, darle permiso de ejecución sobre este procedimiento.

- Realizar INSERT con sentencia SQL sobre la tabla del procedimiento con ambos usuarios.

- Realizar un INSERT a través del procedimiento almacenado con el usuario con permiso de solo lectura.

## Permisos a nivel de roles del DBMS:

- Crear dos usuarios de base de datos.

- Crear un rol que solo permita la lectura de alguna de las tablas creadas.

- Darle permiso a uno de los usuarios sobre el rol creado anteriormente.

- Verificar el comportamiento de ambos usuarios (el que tiene permiso sobre el rol y el que no tiene), cuando intentan leer el contenido de la tabla.

- Expresar sus conclusiones.
