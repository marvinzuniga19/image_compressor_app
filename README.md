# Image Compressor App

Una aplicación de Flutter simple e intuitiva para comprimir imágenes de forma rápida y sencilla.

## Características

- **Seleccionar imágenes**: Elige imágenes de la galería de tu dispositivo.
- **Comprimir con calidad ajustable**: Controla el nivel de compresión con un deslizador de calidad.
- **Vista previa de compresión**: Compara la imagen original y la comprimida, incluyendo los tamaños de archivo.
- **Compartir imágenes**: Comparte fácilmente las imágenes comprimidas a través de otras aplicaciones.
- **Manejo de permisos**: La aplicación solicita los permisos necesarios para acceder al almacenamiento y a las fotos.

## Capturas de pantalla
![app1](https://github.com/user-attachments/assets/3b551efd-912f-4e9f-a014-416f33eab880)

![app2](https://github.com/user-attachments/assets/71e2a120-d3d1-4182-9bec-70e8613b1c17)

![app3](https://github.com/user-attachments/assets/44d2ac46-ce36-4580-a754-2ae3b937038a)

![app4](https://github.com/user-attachments/assets/c7a9a7a3-3b50-46f2-b26a-915ccb9be0ee)

## Tecnologías utilizadas

- **Framework**: [Flutter](https://flutter.dev/)
- **Gestión de estado**: [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- **Compresión de imágenes**: [flutter_image_compress](https://pub.dev/packages/flutter_image_compress)
- **Selección de imágenes**: [image_picker](https://pub.dev/packages/image_picker)
- **Compartir archivos**: [share_plus](https://pub.dev/packages/share_plus)
- **Manejo de permisos**: [permission_handler](https://pub.dev/packages/permission_handler)

## Cómo empezar

### Prerrequisitos

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Un editor de código como [VS Code](https://code.visualstudio.com/) o [Android Studio](https://developer.android.com/studio)

### Instalación

1. Clona el repositorio:
   ```sh
   git clone https://github.com/marvinzuniga19/image_compressor_app.git
   ```
2. Navega al directorio del proyecto:
   ```sh
   cd image_compressor_app
   ```
3. Instala las dependencias:
   ```sh
   flutter pub get
   ```
4. Ejecuta la aplicación:
   ```sh
   flutter run
   ```

## Estructura del proyecto

El proyecto sigue una estructura organizada por características para una mejor mantenibilidad:

```
lib/
├── core/
│   └── utils/
│       ├── app_strings.dart
│       └── permission_handler.dart
├── features/
│   ├── compress/
│   │   └── image_compressor.dart
│   └── home/
│       ├── home_screen.dart
│       └── bloc/
│           ├── home_bloc.dart
│           ├── home_event.dart
│           └── home_state.dart
└── main.dart
```

- **`core`**: Contiene la lógica y las utilidades principales compartidas en toda la aplicación.
- **`features`**: Cada característica de la aplicación (como `home` y `compress`) tiene su propio directorio con sus componentes de UI, lógica de negocio y estado.
- **`main.dart`**: El punto de entrada de la aplicación.

## Contribuciones

Las contribuciones son bienvenidas. Si tienes alguna idea o sugerencia, no dudes en abrir un *issue* o enviar un *pull request*.

## Licencia

Este proyecto está bajo la Licencia MIT. Consulta el archivo `LICENSE` para más detalles.