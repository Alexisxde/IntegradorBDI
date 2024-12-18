# PROYECTO DE ESTUDIO

## PRESENTACIÓN - ADMINISTRACIÓN DE HOTEL

**Asignatura**: Bases de Datos I (FaCENA-UNNE)

**Integrantes**:

- Ledesma, Facundo Manuel 44.542.162
- Lopez, Enzo 37.157.797
- Olivarez, Alexis 44.542.230
- Pineda, Carlos 95.963.784

**Año**: 2024

## CAPÍTULO I: INTRODUCCIÓN

### Caso de estudio

El desarrollo del caso de estudio sobre la administración de un hotel pretende mejorar la gestión operativa del mismo, que actualmente se realiza de manera manual o con herramientas poco eficientes, lo que genera demoras y dificultades en el control de las actividades diarias.

### Definición o planteamiento del problema

El problema que este caso de estudio pretende resolver es: ¿Cómo optimizar y centralizar la administración de un hotel mediante una base de datos relacional que facilite el acceso rápido a la información clave y automatice procesos críticos como la reserva de habitaciones, la gestión de servicios y el registro de huéspedes?

En este caso de estudio buscamos ofrecer una solución tecnológica que simplifique la gestión hotelera, mejorando la eficiencia y aumentando la satisfacción del cliente, al reducir los errores humanos y acelerar los procesos de reserva, asignación de habitaciones, servicios, entre otros aspectos.

### Alcances

1. El sistema permitirá dar de alta habitaciones, pisos, reservas, huéspedes, empleados, y servicios del hotel.
2. A través de la gestión de reservas se relacionarán las habitaciones con los huéspedes, es decir, un huésped podrá solicitar la reserva de una habitación disponible.
3. Para realizar una reserva, será necesario conocer la disponibilidad de las habitaciones.
4. Además, el sistema permitirá gestionar múltiples servicios adicionales (como desayuno, cena, entre otros) y asociarlos a las reservas.
5. El sistema también permitirá consultar habitaciones, reservas, huéspedes, empleados y servicios. Se gestionarán los pagos de las reservas y servicios.
6. Los empleados del hotel también serán gestionados dentro del sistema, permitiendo la asignación del cargo y control de sus actividades.

### Límites

1. No se almacenarán datos financieros sensibles (tarjetas de crédito, etc.).
2. No se incluirán datos de proveedores.
3. No se almacenarán archivos multimedia (imágenes, videos, etc.).
4. No se integrará con sistemas de seguridad o vigilancia.
5. No se almacenarán datos de eventos especiales o conferencias.
6. No se llevará un registro de preferencias personales de los huéspedes que permita personalizar la experiencia.
7. No se les entregará a los huéspedes la capacidad de aparcamiento.
8. No habrá libro de quejas.

## CAPITULO II: MARCO CONCEPTUAL O REFERENCIAL

En la actualidad, resulta impensable gestionar un hotel sin el uso de tecnologías. Estas han permitido a los hoteles automatizar procesos clave como la reserva de habitaciones, el control de inventarios, la facturación y la gestión de clientes, lo que mejora significativamente la eficiencia operativa, reduce costos y aumenta la satisfacción del cliente.

Aunque el factor humano sigue siendo esencial en áreas como la recepción, donde los empleados corroboran datos y supervisan que todo funcione correctamente, la tendencia hacia la automatización es cada vez más fuerte. En el futuro, es posible que la estructura organizativa de los hoteles cambie de manera drástica, reduciendo la intervención humana y adoptando sistemas automatizados en mayor medida.

En este contexto, el uso de SQL Server, un motor de bases de datos relacionales, juega un papel fundamental. SQL Server permite almacenar y procesar grandes volúmenes de datos relacionados con la operación hotelera, tales como la información de huéspedes, reservas, servicios y personal, de manera eficiente y organizada.

Nuestro caso de estudio utiliza SQL Server como motor de base de datos relacional que estructura la información en tablas interrelacionadas. Entre las principales tablas que forman parte del sistema se encuentran las de huéspedes, habitaciones, reservas, servicios y empleados. Cada tabla está diseñada para almacenar datos de manera eficiente, lo que facilita la gestión de las distintas operaciones del hotel.

Los sistemas al integrarse en la administración hotelera, no solo permiten una gestión más eficiente de los recursos, sino que también agilizan la toma de decisiones. En nuestro caso, SQL Server provee una infraestructura robusta que permite acceder y gestionar la información de forma ágil, segura y escalable, lo cual es crucial en la operación diaria de un hotel.

El uso de tecnologías como SQL Server no solo optimiza la gestión interna, sino que también facilita la expansión de las cadenas hoteleras en un entorno globalizado. Un sistema bien estructurado, con bases de datos relacionales y acceso remoto, permite la centralización de la gestión de múltiples hoteles en diferentes regiones. Además, la capacidad de acceder a datos en tiempo real facilita la toma de decisiones informadas, lo que impulsa el desarrollo regional y mejora la competitividad, adaptándose a las necesidades locales de manera eficiente.

## CAPÍTULO III: METODOLOGÍA SEGUIDA
Nuestro caso de estudio se dividió en 7 fases, las cuales se detallan a continuación:
### Fases del desarrollo
* **Fase de elección de caso de estudio:** Para escoger el tema que usaríamos en el caso de estudio, cada integrante proporcionó un tema de su interés, luego tuvimos una votación para quedarnos con un solo tema, la votación terminó en empate con dos temas: **Gestión de una universidad** y **Administración de un hotel**. Como no podíamos decidirnos, consultamos con nuestros profesores sobre cual tema sería más atractivo, donde la mayoría eligió el tema del hotel, decidiéndonos finalmente por este.
* **Fase del diseño conceptual:** Durante esta fase tuvimos multiples reuniones virtuales y presenciales para poder elaborar el diagrama conceptual de la futura base de datos, mediante una lluvia de ideas fuimos agregando las entidades al diagrama, luego, entre todos los integrantes discutimos si tenía sentido lo que agregábamos y como poder relacionarlo con las demás entidades, quedándonos con las más importantes.
* **Fase del diseño Modelo Entidad-Relacion (ER):** Una vez que tuvimos listo el concepto de nuestra base de datos, procedimos a diseñar un diagrama entidad-relación en el que detallamos cada entidad y sus relaciones. En este proceso participamos todo el grupo para poder tomar en cuenta todas las opiniones y perspectivas posibles, para hacerlo lo más realista posible y acorde a nuestros objetivos.
* **Fase de desarrollo:** En esta fase están reunidas todas las fases de desarrollo individual de cada integrante respecto a su tema, cada fase a su vez se dividió en dos: **desarrollo de script** y **creación de documentación**. A continuación, enumeramos las fases de desarrollo:
1. **Manejo de permisos a nivel de usuarios de base de datos.**
2. **Procedimientos y funciones almacenadas.**
3. **Optimización de consultas a través de índices.**
4. **Triggers.**
* **Fase de explicación de temas:** Luego de tener todo los scripts ya terminados, tuvimos una reunión para que cada integrante diera una "exposición" sobre su tema, sobre cómo realizó el script, lo más importante de su tema, y cualquier cosa relevante que quiera compartir a los demás integrantes. Esto se hizo con el propósito de que todo el grupo estuviera informado sobre los temas abordados en el caso de estudio.
* **Fase de pruebas:** Cuando ya se encontraba todo finalizado, realizamos un conjunto de pruebas a todo el sistema completo para corroborar que no hubiera ninguna falla o error, ingresando valores esperados y no esperados, para contemplar todos los posibles resultados.
* **Fase final** Para esta fase nos reunimos todos los integrantes y verificamos punto por punto todo el repositorio, documentación y código. Para corregir cualquier falla o error que pudiera haberse pasado por alto.

### Herramientas (Instrumentos y procedimientos)

En la elaboración de nuestro caso de estudio, utilizamos las siguientes herramientas:
- *[ERD Plus](https://erdplus.com/):* Una sencilla pero potente herramienta para modelado de bases de datos, teniendo herramientas para crear diagramas relacionales,conceptuales, y          código SQL. ERD Plus nos permitió modelar el esquema conceptual.
- *[ChartDB](https://chartdb.io/):* Una herramienta gratis y de código abierto para diseñar bases de datos,entre sus caracteristicas está importar,expotar,editar y crear diagramas relacionales. ChartDB nos permitió modelar el esquema relacional de nuestra base de datos y exportar el modelo a SQL.
- *[SQL Server Management Studio 20](https://www.microsoft.com/es-ar/sql-server/sql-server-downloads):* Una herramienta de gestión y administración de bases de datos desarrollada por Microsoft, específicamente diseñada para trabajar con SQL Server, entre otros lenguajes.
- *[Sintaxis de escritura y formato basicos de Github](https://docs.github.com/es/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax):* Documentación oficial de Github para crear formatos sofisticados con sintaxis simple. La utilizamos en la creación de documentación.
  
## CAPÍTULO IV: DESARROLLO DEL TEMA / PRESENTACIÓN DE RESULTADOS

### Diagrama conceptual

![diagrama_conceptual](/docs/image_conceptual.png)

### Diagrama relacional

![diagrama_relacional](/docs/image_relational.png)

### Diccionario de datos

Acceso al documento [PDF](docs/diccionario_datos.pdf) del diccionario de datos.

### Manejo de permisos a nivel de usuarios de base de datos

En este tema, exploraremos cómo definir, asignar y gestionar permisos de usuarios, desde los permisos básicos de lectura y escritura hasta configuraciones más avanzadas como la administración de roles e inicios de sesión. 

> Acceder a la siguiente carpeta para la descripción completa del tema [Manejo de permisos a nivel de usuarios de base de datos](https://github.com/Alexisxde/IntegradorBDI/tree/main/scripts/Manejo%20de%20permisos%20a%20nivel%20de%20usuarios%20de%20base%20de%20datos).

### Optimización de consultas a través de índices

En este tema, aprenderás cómo los índices pueden acelerar las búsquedas, reducir el tiempo de respuesta en operaciones de lectura y mejorar el rendimiento general del sistema. Exploraremos los diferentes tipos de índices, cómo y cuándo aplicarlos, y una comparación real de qué tan eficientes son.

> Acceder a la siguiente carpeta para la descripción completa del tema [Optimización de consultas a través de índices](https://github.com/Alexisxde/IntegradorBDI/tree/main/scripts/Optimizaci%C3%B3n%20de%20consultas%20a%20trav%C3%A9s%20de%20%C3%ADndices)

### Procedimientos y funciones almacenadas

En este tema, descubrirás cómo los procedimientos almacenados pueden automatizar tareas repetitivas, gestionar transacciones y mejorar el control de los datos, mientras que las funciones almacenadas facilitan cálculos y transformaciones en tiempo real.

> Acceder a la siguiente carpeta para la descripción completa del tema [Procedimientos y funciones almacenadas](https://github.com/Alexisxde/IntegradorBDI/tree/main/scripts/Procedimientos%20y%20funciones%20almacenadas)

### Triggers

En este tema, exploraremos cómo los triggers pueden ayudarte a automatizar auditorías, mantener reglas de negocio y reaccionar a cambios en tiempo real.

> Acceder a la siguiente carpeta para la descripción completa del tema [Triggers](https://github.com/Alexisxde/IntegradorBDI/tree/main/scripts/Triggers)

## CAPÍTULO V: CONCLUSIONES

El desarrollo de este trabajo práctico ha permitido demostrar la importancia y el impacto de una buena estructura y diseño de bases de datos en la gestión de información crítica en un caso de estudio real. A lo largo de las diferentes fases del proyecto, se lograron cumplir los objetivos planteados, destacando la eficiencia en la administración de datos clave como la gestión de usuarios, optimización de consultas, automatización de procesos y ejecución de reglas de negocio a través de triggers.

El manejo de permisos a nivel de usuarios fue una pieza fundamental para garantizar la seguridad de la información, permitiendo un control personalizado sobre qué acciones pueden realizar los usuarios en la base de datos.

En cuanto a la optimización de consultas mediante índices, se logró mejorar el rendimiento de las operaciones de búsqueda y acceso a los datos, demostrando que los índices bien implementados no solo reducen el tiempo de respuesta, sino que también optimizan el uso de los recursos del sistema.

Por otro lado, los procedimientos y funciones almacenadas permitieron una mayor modularidad y eficiencia en la ejecución de tareas repetitivas y complejas, lo que se tradujo en un sistema más robusto y fácil de mantener. Los triggers, por su parte, jugaron un papel esencial en la automatización de procesos, ayudando a mantener la integridad de los datos y aplicar reglas de negocio sin intervención manual, evitando posibles errores humanos.

La correcta implementación de estos conceptos permitió alcanzar una solución eficiente y segura, alineada con los objetivos propuestos. Este proyecto no solo nos ayudó a entender los conocimientos adquiridos y a tener nuevos conocimientos, sino que también nos mostró la relevancia de una administración cuidadosa y planificada de las bases de datos en entornos reales.

## BIBLIOGRAFÍA DE CONSULTA

1. [Documentación oficial de SQL Server de Microsoft](https://learn.microsoft.com/es-mx/sql/sql-server/?view=sql-server-ver16)
2. [¿Qué son y cómo funcionan los triggers? de CódigoFacilito](https://youtu.be/-fukpY1OTNw?si=TAIrty03_rn5pUpI)
3. [¿Procedimientos Almacenados: ¿Qué son? ¿Para qué sirven? ¿Cómo se usan? de The Coder Cave esp](https://youtu.be/XQUPbNFLJn4?si=h7heR32004x5Lr04)
4. [Como usar Index en la Base de Datos SQL Server con Management Studio de Aguilar Systems MX](https://youtu.be/jnox-qm4F5Y?si=Glf2MocKcJAwTf1X)
