#!/bin/bash

# Fonction pour afficher le menu principal
show_main_menu() {
    clear
    echo "===================="
    echo "  Boîte à Outils"
    echo "===================="
    echo "1. VM"
    echo "2. LXC"
    echo "3. Debian"
    echo "4. Ubuntu"
    echo "5. Docker"
    echo "6. Quitter"
    echo "===================="
    read -p "Choisissez une option [1-6]: " main_choice
    case $main_choice in
        1) show_vm_menu ;;
        2) show_lxc_menu ;;
        3) show_debian_menu ;;
        4) show_ubuntu_menu ;;
        5) show_docker_menu ;;
        6) exit 0 ;;
        *) echo "Option invalide"; show_main_menu ;;
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
    echo "4. Retour au menu principal"
    echo "===================="
    read -p "Choisissez une option [1-4]: " vm_choice
    case $vm_choice in
        1) echo "Commande pour créer une VM" ;;
        2) echo "Commande pour lister les VMs" ;;
        3) echo "Commande pour démarrer une VM" ;;
        4) show_main_menu ;;
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
    echo "4. Retour au menu principal"
    echo "===================="
    read -p "Choisissez une option [1-4]: " lxc_choice
    case $lxc_choice in
        1) echo "Commande pour créer un conteneur LXC" ;;
        2) echo "Commande pour lister les conteneurs LXC" ;;
        3) echo "Commande pour démarrer un conteneur LXC" ;;
        4) show_main_menu ;;
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
        1) sudo apt update && sudo apt upgrade ;;
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
        1) sudo apt update && sudo apt upgrade ;;
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
    echo "1. Démarrer Docker"
    echo "2. Lister les conteneurs Docker"
    echo "3. Retour au menu principal"
    echo "===================="
    read -p "Choisissez une option [1-3]: " docker_choice
    case $docker_choice in
        1) sudo systemctl start docker ;;
        2) sudo docker ps -a ;;
        3) show_main_menu ;;
        *) echo "Option invalide"; show_docker_menu ;;
    esac
}

# Afficher le menu principal
show_main_menu
