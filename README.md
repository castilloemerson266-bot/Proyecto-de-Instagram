# Instagram - Simulación de interfaces

## Información del proyecto

- **Aplicación asignada:** Instagram
- **Plataforma seleccionada:** Móvil
- **Integrantes:** Por completar por el equipo

Simulación académica de las pantallas principales de Instagram. La aplicación
utiliza contenido local de ejemplo y no se conecta a servicios externos.

## Pantallas

1. **Inicio de sesión:** formulario con validación y credenciales estáticas.
2. **Inicio:** historias y publicaciones con acciones para indicar Me gusta,
   comentar, compartir y guardar.
3. **Mensajes:** notas, búsqueda de demostración y conversaciones estáticas.
4. **Perfil:** datos de ejemplo, mosaico de publicaciones y pestañas de contenido.

La barra inferior permite cambiar entre Inicio, Mensajes y Perfil. El menú de
opciones de la barra superior permite cerrar sesión y volver al inicio de sesión.

## Organización del código

- `lib/main.dart`: punto de entrada requerido por Flutter y tema de la aplicación.
- `lib/pantallas/`: una pantalla Dart para cada sección.
- `lib/componentes/`: navegación y widgets reutilizables.

Las pantallas y componentes incluyen comentarios en español que explican sus
responsabilidades y las partes principales de su funcionamiento.

## Interacciones

- Validación de campos vacíos y credenciales incorrectas en el acceso.
- Mostrar u ocultar la contraseña.
- Marcar publicaciones con Me gusta, incluyendo doble toque en la imagen.
- Buscar conversaciones y seleccionar una para mostrar un mensaje de demostración.
- Mostrar avisos para las acciones de notas y solicitudes de mensajes.
- Cambiar las pestañas del Perfil y alternar el botón Editar/Guardar perfil.
- Mostrar mensajes de confirmación para acciones simuladas.

## Credenciales de prueba

```text
Usuario: admin
Contraseña: 1234
```

## Ejecución

Se requiere tener instalado Flutter y Dart.

```bash
flutter pub get
flutter run
```

Para ejecutar las pruebas:

```bash
flutter test
```
