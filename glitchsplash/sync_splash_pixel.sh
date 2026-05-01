#!/bin/bash
THEME_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
IMAGES_DIR="$THEME_DIR/contents/splash/images"
PREVIEWS_DIR="$THEME_DIR/contents/previews"

# Obtener el valor de Image= del config de Plasma
RAW=$(grep "Image=" ~/.config/plasma-org.kde.plasma.desktop-appletsrc | head -n 1 | cut -d "=" -f2- | sed "s|file://||" | xargs)

resolve_wallpaper() {
    local path="$1"

    # Es un archivo directo
    if [ -f "$path" ]; then
        echo "$path"
        return
    fi

    # Es un directorio (paquete de wallpaper de KDE)
    # Buscar en contents/images/ el archivo más grande (mayor resolución)
    if [ -d "$path" ]; then
        local img
        img=$(find "$path/contents/images/" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) \
              2>/dev/null | xargs ls -S 2>/dev/null | head -n 1)
        if [ -n "$img" ]; then
            echo "$img"
            return
        fi

        # Fallback: cualquier imagen dentro del directorio
        img=$(find "$path" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) \
              2>/dev/null | head -n 1)
        [ -n "$img" ] && echo "$img"
    fi
}

WALLPAPER=$(resolve_wallpaper "$RAW")

if [ -f "$WALLPAPER" ]; then
    echo "✓ Wallpaper: $WALLPAPER"
    magick "$WALLPAPER" -blur 0x8 -fill black -colorize 40% "$IMAGES_DIR/bg_low.jpg"
    cp "$IMAGES_DIR/bg_low.jpg" "$PREVIEWS_DIR/preview.png"
    cp "$IMAGES_DIR/bg_low.jpg" "$PREVIEWS_DIR/splash.png"
    echo "✓ Fondo actualizado correctamente"
else
    echo "✗ No se pudo resolver el wallpaper desde: '$RAW'"
fi
