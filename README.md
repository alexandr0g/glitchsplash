# GlitchSplash

Splash Screen liviano para **KDE Plasma 6** diseñado para unificar la transición visual entre el inicio de sesión y el escritorio.

## Características

* **Sincronización visual:** El Splash utiliza automáticamente tu fondo de pantalla actual.
* **Transición progresiva:** Carga el fondo en capas de resolución (1/4 y 1/2) con un efecto de parpadeo (fade) para suavizar la carga de servicios de fondo.
* **Optimizado:** Sin animaciones pesadas, ideal para sistemas que buscan rapidez.

## Requisitos

Para que el script de sincronización funcione correctamente, es necesario tener instalado **ImageMagick**:

```bash
# En Fedora:
sudo dnf install ImageMagick
```

## Instalación

### 1. El Tema

Si descargaste el archivo comprimido, extrae la carpeta `com.alexanderog.splashpixel` en la siguiente ruta:
`~/.local/share/plasma/look-and-feel/`

### 2. El Script de Sincronización

Para que el Splash se actualice automáticamente al cambiar de fondo de pantalla, debes configurar el script de la siguiente manera:

1. Ve a **Ajustes de Sistema > Inicio y apagado > Autostart**.
2. Haz clic en **+ Añadir... > Añadir guion...**.
3. Busca y selecciona el archivo `sync_splash_pixel.sh` (asegúrate de que tenga permisos de ejecución).
4. En la columna **"Ejecutar al"**, cambia la opción a **"Cerrar sesión"**.

## Estructura del Proyecto

* `metadata.desktop`: Archivo de configuración del servicio KDE.
* `contents/splash/main.qml`: Código fuente de la animación en QML.
* `sync_splash_pixel.sh`: Script en Bash para procesar el wallpaper.
