#!/bin/bash
greeting=“Bienvenido"
user=$(whoami)
day=$(date +%A)

echo "$greeting de vuelta $user! Hoy es $day, cual es el mejor día de la semana ¡ "
echo “Tu version de Bash shell es: $BASH_VERSION. Sigamos!"
