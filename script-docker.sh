#!/bin/bash

# Vérifier si l'utilisateur a les privilèges administratifs
check_admin_privileges() {
    if [ "$(id -u)" != "0" ]; then
        echo "Ce script nécessite des privilèges administratifs pour fonctionner."
        exit 1
    fi
}

# Fonction pour installer Docker
install_docker() {
    apt update
    apt install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    apt update
    apt install -y docker-ce
    usermod -aG docker $USER
}

# Fonction pour installer Portainer
install_portainer() {
    docker volume create portainer_data
    docker run -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data --restart always --name portainer portainer/portainer
}

# Fonction pour installer Docker Compose
install_docker_compose() {
    apt install -y docker-compose
}

# Fonction pour installer GitLab en Docker Compose
install_gitlab() {
    mkdir -p /srv/gitlab/{config,logs,data}
    cat <<EOF > docker-compose-gitlab.yml
version: "3.7"
services:
  gitlab:
    image: gitlab/gitlab-ce:latest
    restart: always
    hostname: gitlab.martintech.fr
    environment:
      GITLAB_OMNIBUS_CONFIG: |
        external_url 'https://gitlab.martintech.fr'
    ports:
      - 80:80
      - 443:443
      - 222:22
    volumes:
      - /srv/gitlab/config:/etc/gitlab
      - /srv/gitlab/logs:/var/log/gitlab
      - /srv/gitlab/data:/var/opt/gitlab
networks: {}
EOF
    docker-compose -f docker-compose-gitlab.yml up -d
}

# Fonction pour installer GLPI avec Docker Compose
install_glpi() {
    cat <<EOF > docker-compose-glpi.yml
version: "3"
services:
  glpi:
    image: diouxx/glpi:latest
    container_name: glpi
    restart: always
    ports:
      - 8080:80 # Map port 8080 on host to port 80 on container
    environment:
      - MYSQL_HOST=mysql
      - MYSQL_DATABASE=glpidb
      - MYSQL_USER=glpiuser
      - MYSQL_PASSWORD=glpipassword
    depends_on:
      - mysql
  mysql:
    image: mysql:5.7
    container_name: mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_DATABASE: glpidb
      MYSQL_USER: glpiuser
      MYSQL_PASSWORD: glpipassword
EOF
    docker-compose -f docker-compose-glpi.yml up -d
}

# Fonction pour mettre à jour Docker
update_docker() {
    apt update
    apt upgrade -y docker-ce
}

# Fonction pour mettre à jour Portainer
update_portainer() {
    docker stop portainer
    docker rm portainer
    install_portainer
}

# Fonction pour mettre à jour Docker Compose
update_docker_compose() {
    apt update
    apt upgrade -y docker-compose
}

# Fonction pour désinstaller Docker
uninstall_docker() {
    apt purge -y docker-ce
    apt autoremove -y
}

# Fonction pour désinstaller Portainer
uninstall_portainer() {
    docker stop portainer
    docker rm portainer
    docker volume rm portainer_data
}

# Fonction pour désinstaller Docker Compose
uninstall_docker_compose() {
    apt purge -y docker-compose
}

# Menu principal
echo "Choisissez une option :"
echo "1. Installer Docker"
echo "2. Installer Portainer (http 9000)"
echo "3. Installer Docker Compose"
echo "4. Installer GitLab avec Docker Compose (https 443)"
echo "5. Installer GLPI avec Docker Compose (http 8080)"
echo "6. Mettre à jour Docker"
echo "7. Mettre à jour Portainer"
echo "8. Mettre à jour Docker Compose"
echo "9. Désinstaller Docker"
echo "10. Désinstaller Portainer"
echo "11. Désinstaller Docker Compose"
echo "12. Quitter"

read -p "Entrez votre choix : " choix

check_admin_privileges

case $choix in
    1) install_docker ;;
    2) install_portainer ;;
    3) install_docker_compose ;;
    4) install_gitlab ;;
    5) install_glpi ;;
    6) update_docker ;;
    7) update_portainer ;;
    8) update_docker_compose ;;
    9) uninstall_docker ;;
    10) uninstall_portainer ;;
    11) uninstall_docker_compose ;;
    12) echo "Au revoir!"; exit ;;
    *) echo "Choix non valide";;
esac
