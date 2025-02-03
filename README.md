
Aplicación de posts hecha en lenjugaje de programación Dart con SDK de flutter 3.27.3    (Flutter SDK (un SDK que incluye el framework Flutter, herramientas de compilación, y otros recursos para desarrollar aplicaciones multiplataforma)). Con una Arquitetura por capas con separación clara entre la interfaz y la lógica lo que permite ser escalable y mantenible en el tiempo, además cuenta con Provider para la gestión de estados de la aplicación.

Estructura

lib/
├── models/
│   └── user.dart
│   └── posts.dart
├── providers/
│   └── user_provider.dart
├── repositories/
│   └── user_repository.dart
├── services/
│   └── user_service.dart
├── screens/
│   └── user_list_screen.dart
│   └── user_detail_screen.dart
└── main.dart


models/ => Modelos user y post. Que tienen clases inmutables por sus atributos con constructores para convertir los datos de Json a Dart y viceversa.

providers/ => es la parte del código que maneja el estado de la aplicación con Provider, para que la interfáz se encargue de mostrar los datos que se obtienen de los services y almacena en los respositories.

repositories/ => Se encarga de almacenar y tomar los datos de Shared preferences. Cuenta con SharedPreferences ya que los tipos de datos que se usan son muy sencillos en caso tal se requiera una base de datos más robusta, es fácil tomar la decisión de cambiar por Sqlite o Hive para un almacenamiento con más caracterisicas.

services/ => Se encarga de convertir en objetos Dart los datos de las solicitudes HTTP que llegan en formato Json de User y Post.
para ser consultada y almacenada por los repositorios.

widgets/ => Carpeta que almacena los elementos visuales que sirven para crear las screens (pantallas).

screens/ => Son las pantallas que representan cada vista de la aplicación.

*Por fuera de la raíz lib se encuentran los test.

test/ => Cuenta con los archivos de test unitarios de algunas de las partes más importantes del código como son user_provider_test.dart
user_detail_screen_test.dart y user_card_test.dart. En estos se usan simulaciones de los repositories, services y provider para que se ejecute todo en la misma prueba sin necesidad de hacer conexiones a apis. Se usaron las herramientas que ya trae flutter para hacer pruebas que provee la dependencia flutter_test.


Cuenta con las siguientes dependencias:

1. sdk: flutter
flutter: Es la SDK principal para desarrollar aplicaciones móviles con Flutter. Proporciona todas las herramientas y bibliotecas necesarias para crear la interfaz de usuario (UI), manejar eventos, y más.

2. shared_preferences: ^2.0.6
shared_preferences: Esta dependencia permite guardar datos de manera persistente en el dispositivo de forma simple (clave-valor). Es ideal para almacenar configuraciones o datos pequeños, como preferencias de usuario, en la memoria local del dispositivo.

Ejemplo de uso:

Guardar un tema oscuro/ligero.
Guardar preferencias del usuario (por ejemplo, nombre, email).

3. http: ^0.13.3
http: Esta dependencia permite hacer solicitudes HTTP, como GET, POST, PUT, etc., para consumir APIs REST. Es ampliamente utilizada para interactuar con servicios web en aplicaciones móviles o web.

Ejemplo de uso:

Obtener datos de un servidor remoto.
Enviar datos a un backend.

4. provider: ^6.0.0
provider: Esta es una librería para manejar el estado en Flutter de manera eficiente. Proporciona un enfoque sencillo para inyectar y compartir datos entre widgets de forma reactiva. Los widgets pueden suscribirse a cambios en los datos (usando ChangeNotifier o ValueNotifier) y se actualizan automáticamente cuando esos datos cambian.

Ejemplo de uso:

Manejar el estado global de la aplicación (por ejemplo, usuarios logueados, tema, configuración).
Propagar cambios de estado entre diferentes widgets sin necesidad de pasar parámetros manualmente.

5. sqflite: ^2.0.0+4
sqflite: Esta es una biblioteca que proporciona acceso a bases de datos SQLite para almacenamiento local persistente. Puedes almacenar datos más complejos y estructurados en una base de datos, lo que te permite realizar operaciones como consultas, inserciones, actualizaciones y eliminaciones.

Ejemplo de uso:

Guardar y consultar información en una base de datos local (por ejemplo, registros de usuario, tareas pendientes).
Usar tablas y relaciones en una base de datos SQLite en lugar de simplemente guardar datos clave-valor.

6. path_provider: ^2.0.11
path_provider: Esta dependencia ayuda a obtener las rutas de directorios específicos en el sistema de archivos del dispositivo. Es útil cuando quieres acceder a directorios como el de documentos, almacenamiento interno o la caché de la aplicación, donde puedes almacenar archivos de manera más organizada y accesible.

Ejemplo de uso:

Guardar archivos en una carpeta específica en el dispositivo (como imágenes, archivos de configuración, etc.).
Acceder a rutas del sistema de archivos para guardar datos de manera más estructurada.




