#!/bin/bash

# Verifica si se está ejecutando la primera parte del script o la segunda
if [[ "$REEXEC" != "true" ]]; then
  # Primera parte del script

  # Add Docker's official GPG key:
  sudo apt-get update
  sudo apt-get install ca-certificates curl -y
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  # Add the repository to Apt sources:
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update

  # Install Docker
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

  # Add current user to the Docker group
  sudo usermod -aG docker $USER

  # Re-ejecuta el script en una nueva sesión con los permisos actualizados
  echo "Re-ejecutando el script con permisos de Docker"
  export REEXEC=true
  exec sg docker "$0"
else
  # Segunda parte del script (una vez que el usuario ya tiene permisos de Docker)

  # Clonar el repositorio
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

  # Iniciar los contenedores con Docker Compose usando el archivo .env
  docker compose --env-file .env up mongo mongo-builder redis postgres spark-master spark-worker processor worker gateway client -d

  echo "Script completado con éxito"
fi
