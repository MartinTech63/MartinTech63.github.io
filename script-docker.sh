#!/bin/bash

# Fonction pour installer Docker
install_docker() {
    sudo apt update
    sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt update
    sudo apt install -y docker-ce
    sudo usermod -aG docker $USER
}

# Fonction pour installer Portainer
install_portainer() {
    sudo docker volume create portainer_data
    sudo docker run -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data --restart always --name portainer portainer/portainer
}

# Fonction pour installer Docker Compose
install_docker_compose() {
    sudo apt install -y docker-compose
}

# Fonction pour mettre à jour Docker
update_docker() {
    sudo apt update
    sudo apt upgrade -y docker-ce
}

# Fonction pour mettre à jour Portainer
update_portainer() {
    sudo docker stop portainer
    sudo docker rm portainer
    install_portainer
}

# Fonction pour mettre à jour Docker Compose
update_docker_compose() {
    sudo apt update
    sudo apt upgrade -y docker-compose
}

# Fonction pour désinstaller Docker
uninstall_docker() {
    sudo apt purge -y docker-ce
    sudo apt autoremove -y
}

# Fonction pour désinstaller Portainer
uninstall_portainer() {
    sudo docker stop portainer
    sudo docker rm portainer
    sudo docker volume rm portainer_data
}

# Fonction pour désinstaller Docker Compose
uninstall_docker_compose() {
    sudo apt purge -y docker-compose
}

# Menu principal
echo "Choisissez une option :"
echo "1. Installer Docker"
echo "2. Installer Portainer"
echo "3. Installer Docker Compose"
echo "4. Mettre à jour Docker"
echo "5. Mettre à jour Portainer"
echo "6. Mettre à jour Docker Compose"
echo "7. Désinstaller Docker"
echo "8. Désinstaller Portainer"
echo "9. Désinstaller Docker Compose"
echo "10. Quitter"

read -p "Entrez votre choix : " choix

case $choix in
    1) install_docker ;;
    2) install_portainer ;;
    3) install_docker_compose ;;
    4) update_docker ;;
    5) update_portainer ;;
    6) update_docker_compose ;;
    7) uninstall_docker ;;
    8) uninstall_portainer ;;
    9) uninstall_docker_compose ;;
    10) echo "Au revoir!"; exit ;;
    *) echo "Choix non valide";;
esac
