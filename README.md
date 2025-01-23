### tp2_flutter_grupo12

## PARTE DISEÑO FLUTTER

**Pantalla Principal de Usuarios: UsuariosListScreen**

La pantalla de UsuariosListScreen permite visualizar a todos los usuarios registrados.
Para cada usuarios se muestra:
-Ávatar
-Nombre y apellido
-Icono de género 
-Bandera de su país 
-Estrella de favoritos

En esta pantalla tenes varias opciones para realizar:
-Usar el buscador de usuario para encontrar el buscado por su nombre y/o apellido (Clickeando la lupa)
-Entrar en la pantalla individual de cada usuario (Clickeando al usuario)
-Agregar/Desagregar como favorito al usuario (Clickeando la estrella de cada usuario)
-Ver solamente los usuarios en favoritos (Clickeando el boton abajo a la derecha con el icono de la estrella)
-Volver al menu (Clickeando la flecha en la parte superior izquierda)

**Pantalla individual de Usuarios: UsuariosDetailScreen**

En la pantalla UsuariosDetailScreen se puede ver todos los atributos de un usuario.
Para cada usuario se muestra:
-Nombre y apellido
-ID del Usuario (En un tono más oscuro ya que no es una información que le interese al usuario)
-Avatar
-Estrella de favoritos
-Correo electrónico
-Género
-País

En esta pantalla se puede:
-Ver más grande y sin el circulo que lo rodea, a la imagen de avatar (Clickeando la imagen)
-Agregar/Desagregar como favorito al usuario (Clickeando la estrella de favoritos)
-Copiar el correo electrónico (Clickeando el boton de copiar a la derecha del correo, queda guardado en el portapapeles)
-Volver a la lista de usuarios

Las pantallas de usuarios tienen la caracteristica de tener una estrellita de favoritos, vendría a ser como un botón de seguir en alguna red social.
Estos favoritos se guardan al cambiar de pantallas y también al reiniciar la aplicación.
También se adapta al modo nocturno de la aplicación.

## PARTE CONEXION API

-Se eliminaron los mocks de usuarios para reemplazarlos por la información que devuelve la API.
-Se agrego un api_service.dart para gestionar los pedidos de usuarios a la API.
-Se agrego un .env para la variable de entorno API_URL.
-Se adaptaron los model de datos.
-Se adaptaron partes del codigo para que coincidan con la petición a la API.
-Nuevas dependencies: flutter_dotenv: ^5.0.2 y http: ^1.0.0.

Como la API siempre devuelve siempre usuarios diferentes, hice que los usuarios se carguen al iniciar la aplicación. Sino al entrar a la screen de usuarios, provocaba que no tenga mucho sentido el tema de favoritos, ahora se guardan de mientras usas al app,  y al reiniciar se borra todos los usuarios y favoritos.

También modifique la API en Mockaroo para que devuelva todo lo que yo necesita que antes no tenia, por ejemplo una imagen, un binary true false o que devuelva ciertos paises, asi no tengo que agregar todas las banderitas. Solo tuve que modificaron desde la página de Mockaroo, no hice ninguna modificación en el primer proyecto en grupo. 

Usé como base mi parte del segundo proyecto previo al merge, y a partir de ahí empecé con las modificaciones de código para adaptarlo a la API, pero en las funciones es lo mismo.