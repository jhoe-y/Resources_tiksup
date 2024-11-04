#!/bin/bash

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

chmod a+x kubectl
mkdir -p ~/.local/bin
mv ./kubectl ~/.local/bin/kubectl



#or

# 1. Actualizar el índice de paquetes
sudo apt-get update

# 2. Instalar paquetes necesarios para usar el repositorio de Kubernetes
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg

# 3. Crear la carpeta /etc/apt/keyrings si no existe
sudo mkdir -p -m 755 /etc/apt/keyrings

# 4. Descargar la clave de firma pública para el repositorio de Kubernetes
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# 5. Asignar permisos de lectura a la clave descargada
sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# 6. Añadir el repositorio de Kubernetes a la lista de fuentes de apt
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

# 7. Asignar permisos de lectura al archivo del repositorio
sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list

# 8. Actualizar el índice de paquetes nuevamente
sudo apt-get update

# 9. Instalar kubectl
sudo apt-get install -y kubectl


# Instalación de kind

# For AMD64 / x86_64
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.24.0/kind-linux-amd64
# For ARM64
[ $(uname -m) = aarch64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.24.0/kind-linux-arm64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

