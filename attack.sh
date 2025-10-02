#!/bin/bash

API="http://localhost:8000"
echo "=== Probando seguridad del login ==="


passwords=(
    "Marti_2024" "DaniPass09" "Val3ri@" "Andres98" "Cami*321"
    "123456" "password" "admin" "test" "1234"
)


emails=("martina23@gmail.com" "daniel.pro@gmail.com" "valeria.dev@gmail.com" "andres1998@gmail.com" "camila.design@gmail.com")

echo "Probando ${#emails[@]} usuarios con ${#passwords[@]} contraseñas..."
echo ""

for email in "${emails[@]}"; do
    echo "Atacando: $email"
    
    for pass in "${passwords[@]}"; do
        respuesta=$(curl -s -X POST "$API/login" \
            -H "Content-Type: application/json" \
            -d "{\"correo\":\"$email\", \"password\":\"$pass\"}")
        

        if echo "$respuesta" | grep -q "exitoso"; then
            echo "✅ ENCONTRADO: $email - $pass"
        else
            echo "❌ Fallo: $pass"
        fi
    done
    echo "---"
done

echo "=== Prueba terminada ==="
