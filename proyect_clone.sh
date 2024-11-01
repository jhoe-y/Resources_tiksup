#!/bin/bash

# Clonar el repositorio
cd /tmp || { echo "Error al cambiar a /tmp"; exit 1; }
git clone https://github.com/jsusmachaca/tiksup.git
cd tiksup || { echo "Error al cambiar a tiksup"; exit 1; }

# Verificar si el archivo movies.json.gz existe antes de descomprimir
if [[ -f movies.json.gz ]]; then
    echo "Descomprimiendo movies.json.gz..."
    gunzip movies.json.gz
else
    echo "El archivo movies.json.gz no se encontró."
    exit 1
fi

# Crear archivo .env y agregar el contenido en un solo bloque
cat <<EOF > .env
SECRET_KEY=ZmFkZTc1MzEtYzI1Ni00OWY2LTk2NmItNjU5NWMzYzAzMTI4Cg==

KAFKA_SERVER=kafka:9092
KAFKA_TOPIC=tiksup-user-data

REDIS_HOST=redis
REDIS_PORT=6379

PG_HOST=postgres
PG_PORT=5432
PG_NAME=tiksup
PG_USER=user
PG_PASSWORD=admin

MONGO_HOST=mongo
MONGO_PORT=27017
MONGO_USER=user
MONGO_PASSWORD=admin
MONGO_DB=tiksup
MONGO_COLLECTION=movies

SPARK_HOST=spark-master
SPARK_PORT=7077

GATEWAY_PORT=3000
WORKER_PORT=8081
CLIENT_PORT=3001

GATEWAY_URL=http://gateway:3000
PROCESSOR_URL=http://processor:8000
WORKER_URL=http://worker:8081

GRPC_HOST=
EOF

# Iniciar los contenedores con Docker Compose usando el archivo .env
echo "Iniciando los contenedores con Docker Compose..."
docker compose --env-file .env up -d

echo "Script completado con éxito"
