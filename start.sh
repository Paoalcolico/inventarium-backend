#!/bin/bash
# Script para facilitar a execução do backend

# Parar processos anteriores se existirem
echo "Verificando e parando processos anteriores..."
pkill -f "inventory-management" 2>/dev/null || true

echo "Compilando o projeto..."
mvn clean package -DskipTests

if [ $? -eq 0 ]; then
    echo "Compilação bem-sucedida! Iniciando o servidor..."
    java -jar target/inventory-management-0.0.1-SNAPSHOT.jar &
    echo "Backend iniciado em background na porta 4000"
    echo "Para parar: pkill -f inventory-management"
    echo "Para logs: tail -f backend.log"
else
    echo "Erro na compilação!"
    exit 1
fi
