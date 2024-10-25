#!/bin/bash

git clone https://github.com/jsusmachaca/tiksup.git

cd tiksup

# Crear archivo .env y agregar el contenido en un solo bloque
cat <<EOF > .env
SECRET_KEY=ZmFkZTc1MzEtYzI1Ni00OWY2LTk2NmItNjU5NWMzYzAzMTI4Cg==

KAFKA_SERVER=161.132.40.126:9092
KAFKA_TOPIC=tiksup-user-data

REDIS_HOST=redis
REDIS_PORT=6379

PG_HOST=postgres
PG_PORT=5432
PG_NAME=tiksup
PG_USER=jsus
PG_PASSWORD=godylody

MONGO_HOST=mongo
MONGO_PORT=27017
MONGO_USER=27017
MONGO_PASSWORD=godylody
MONGO_DB=tiksup
MONGO_COLLECTION=movies

SPARK_HOST=spark-master
SPARK_PORT=7077

GATEWAY_PORT=3000
WORKER_PORT=8081
CLIENT_PORT=3001

GATEWAY_URL=gateway:3000
PROCESSOR_URL=processor:8000
WORKER_URL=worker:8081

GRPC_HOST=
EOF
