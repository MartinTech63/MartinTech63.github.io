#!/bin/bash

# Vérifier et installer sudo si nécessaire
check_and_install_sudo() {
    clear
    echo "Vérification de l'installation de sudo..."
    if ! command -v sudo &> /dev/null; then
        echo "sudo n'est pas installé. Installation de sudo..."
        apt update
        apt install -y sudo
        echo "sudo a été installé."
        # Ajouter l'utilisateur au groupe sudo
        user=$(whoami)
        sudo usermod -aG sudo $user
        echo "$user a été ajouté au groupe sudo."
    else
        echo "sudo est déjà installé."
    fi
}

# Appeler la fonction de vérification de sudo
check_and_install_sudo

# Pause de 2 secondes pour lire le message
sleep 2

# Fonction pour afficher le menu principal
show_main_menu() {
    clear
    echo "===================="
    echo "  Boîte à Outils"
    echo "===================="
    echo "1. PVE"
    echo "2. Debian"
    echo "3. Ubuntu"
    echo "4. Docker"
    echo "5. Quitter"
    echo "===================="
    read -p "Choisissez une option [1-5]: " main_choice
    case $main_choice in
        1) show_pve_menu ;;
        2) show_debian_menu ;;
        3) show_ubuntu_menu ;;
        4) show_docker_menu ;;
        5) exit 0 ;;
        *) echo "Option invalide"; show_main_menu ;;
    esac
}

# Fonction pour afficher le menu PVE
show_pve_menu() {
    clear
    echo "===================="
    echo "       PVE"
    echo "===================="
    echo "1. VM"
    echo "2. LXC"
    echo "3. Retour au menu principal"
    echo "===================="
    read -p "Choisissez une option [1-3]: " pve_choice
    case $pve_choice in
        1) show_vm_menu ;;
        2) show_lxc_menu ;;
        3) show_main_menu ;;
        *) echo "Option invalide"; show_pve_menu ;;
    esac
}

# Fonction pour afficher le menu VM
show_vm_menu() {
    clear
    echo "===================="
    echo "       VM"
    echo "===================="
    echo "1. Créer une VM"
    echo "2. Lister les VMs"
    echo "3. Démarrer une VM"
    echo "4. Retour au menu PVE"
    echo "===================="
    read -p "Choisissez une option [1-4]: " vm_choice
    case $vm_choice in
        1) echo "Commande pour créer une VM" ;;
        2) echo "Commande pour lister les VMs" ;;
        3) echo "Commande pour démarrer une VM" ;;
        4) show_pve_menu ;;
        *) echo "Option invalide"; show_vm_menu ;;
    esac
}

# Fonction pour afficher le menu LXC
show_lxc_menu() {
    clear
    echo "===================="
    echo "       LXC"
    echo "===================="
    echo "1. Créer un conteneur LXC"
    echo "2. Lister les conteneurs LXC"
    echo "3. Démarrer un conteneur LXC"
    echo "4. Retour au menu PVE"
    echo "===================="
    read -p "Choisissez une option [1-4]: " lxc_choice
    case $lxc_choice in
        1) echo "Commande pour créer un conteneur LXC" ;;
        2) echo "Commande pour lister les conteneurs LXC" ;;
        3) echo "Commande pour démarrer un conteneur LXC" ;;
        4) show_pve_menu ;;
        *) echo "Option invalide"; show_lxc_menu ;;
    esac
}

# Fonction pour afficher le menu Debian
show_debian_menu() {
    clear
    echo "===================="
    echo "     Debian"
    echo "===================="
    echo "1. Mettre à jour Debian"
    echo "2. Installer un paquet"
    echo "3. Retour au menu principal"
    echo "===================="
    read -p "Choisissez une option [1-3]: " debian_choice
    case $debian_choice in
        1) sudo apt update && sudo apt upgrade -y ;;
        2) read -p "Entrez le nom du paquet à installer: " package_name; sudo apt install -y $package_name ;;
        3) show_main_menu ;;
        *) echo "Option invalide"; show_debian_menu ;;
    esac
}

# Fonction pour afficher le menu Ubuntu
show_ubuntu_menu() {
    clear
    echo "===================="
    echo "     Ubuntu"
    echo "===================="
    echo "1. Mettre à jour Ubuntu"
    echo "2. Installer un paquet"
    echo "3. Retour au menu principal"
    echo "===================="
    read -p "Choisissez une option [1-3]: " ubuntu_choice
    case $ubuntu_choice in
        1) sudo apt update && sudo apt upgrade -y ;;
        2) read -p "Entrez le nom du paquet à installer: " package_name; sudo apt install -y $package_name ;;
        3) show_main_menu ;;
        *) echo "Option invalide"; show_ubuntu_menu ;;
    esac
}

# Fonction pour afficher le menu Docker
show_docker_menu() {
    clear
    echo "===================="
    echo "     Docker"
    echo "===================="
    echo "1. Installer Docker"
    echo "2. Lister les conteneurs Docker"
    echo "3. Installer Docker Compose"
    echo "4. Installer Dockge"
    echo "5. Retour au menu principal"
    echo "===================="
    read -p "Choisissez une option [1-5]: " docker_choice
    case $docker_choice in
        1) install_docker ;;
        2) sudo docker ps -a ;;
        3) install_docker_compose ;;
        4) install_dockge ;;
        5) show_main_menu ;;
        *) echo "Option invalide"; show_docker_menu ;;
    esac
}

# Fonction pour installer Docker
install_docker() {
    clear
    echo "Installation de Docker..."
    sudo apt update
    sudo apt install -y \
        ca-certificates \
        curl \
        gnupg \
        lsb-release
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    echo "Docker a été installé."
    sleep 2
    show_docker_menu
}

# Fonction pour installer Docker Compose
install_docker_compose() {
    clear
    echo "Installation de Docker Compose..."
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo "Docker Compose a été installé."
    sleep 2
    show_docker_menu
}

# Fonction pour installer Dockge
install_dockge() {
    clear
    echo "Installation de Dockge..."
    sudo mkdir -p /opt/stacks /opt/dockge
    cd /opt/dockge
    sudo curl "https://dockge.kuma.pet/compose.yaml?port=5001&stacksPath=%2Fopt%2Fstacks" --output compose.yaml
    sudo docker-compose up -d
    echo "Dockge a été installé et démarré."
    sleep 2
    show_docker_menu
}

# Afficher le menu principal
show_main_menu
