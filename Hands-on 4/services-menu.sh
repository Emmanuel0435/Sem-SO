#!/bin/bash

while true; do
    echo "===== MENÚ DE SERVICIOS ====="
    echo "1. Listar contenido de una carpeta"
    echo "2. Crear un archivo con una línea de texto"
    echo "3. Comparar dos archivos de texto"
    echo "4. Usar comando AWK"
    echo "5. Usar comando GREP"
    echo "6. Salir"
    echo "============================="
    read -p "Elige una opción [1-6]: " opcion

    case $opcion in
        1)
            read -p "Ingresa la ruta absoluta del directorio: " ruta
            if [ -d "$ruta" ]; then
                ls -l "$ruta"
            else
                echo "La ruta no existe o no es un directorio."
            fi
            ;;
        2)
            read -p "Nombre del archivo a crear: " archivo
            read -p "Escribe el texto que deseas guardar: " texto
            echo "$texto" > "$archivo"
            echo "Archivo '$archivo' creado."
            ;;
        3)
            read -p "Ingresa el primer archivo: " archivo1
            read -p "Ingresa el segundo archivo: " archivo2
            if [[ -f "$archivo1" && -f "$archivo2" ]]; then
                diff "$archivo1" "$archivo2"
            else
                echo "Uno o ambos archivos no existen."
            fi
            ;;
        4)
            read -p "Archivo a procesar con awk: " archivo_awk
            if [ -f "$archivo_awk" ]; then
                echo "Mostrando la primera columna de cada línea:"
                awk '{print $1}' "$archivo_awk"
            else
                echo "Archivo no encontrado."
            fi
            ;;
        5)
            read -p "Archivo a buscar con grep: " archivo_grep
            read -p "Texto a buscar: " busqueda
            if [ -f "$archivo_grep" ]; then
                grep "$busqueda" "$archivo_grep"
            else
                echo "Archivo no encontrado."
            fi
            ;;
        6)
            echo "Saliendo del menú. ¡Hasta luego!"
            break
            ;;
        *)
            echo "Opción no válida. Intenta de nuevo."
            ;;
    esac

    echo "" # Salto de línea
done
