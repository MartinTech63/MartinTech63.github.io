#!/bin/bash

# Fonction pour installer Apache2
installer_apache() {
    sudo apt update
    sudo apt install apache2
    echo "Apache2 installé."
}

# Fonction pour activer un service
activer_service() {
    sudo systemctl start $1
    echo "$1 activé."
}

# Fonction pour désactiver un service
desactiver_service() {
    if [ "$1" == "ssh" ]; then
        sudo pkill -TERM -u $USER sshd
    fi
    sudo systemctl stop $1
    echo "$1 désactivé."
}

# Fonction pour activer Apache
activer_apache() {
    sudo systemctl start apache2
    echo "Apache activé."
}

# Fonction pour désactiver Apache
desactiver_apache() {
    sudo systemctl stop apache2
    echo "Apache désactivé."
}

# Fonction pour activer l'authentification par mot de passe SSH
activer_auth_ssh() {
    sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
    sudo systemctl restart ssh
    echo "Authentification par mot de passe SSH activée."
}

# Fonction pour désactiver l'authentification par mot de passe SSH
desactiver_auth_ssh() {
    sudo sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
    sudo systemctl restart ssh
    echo "Authentification par mot de passe SSH désactivée."
}

# Fonction pour vérifier l'état d'un service
verifier_service() {
    sudo systemctl status $1
}

# Fonction pour ajouter une clé SSH à partir d'un fichier spécifié par l'utilisateur
ajouter_cle_ssh() {
    read -p "Entrez le chemin du fichier de clé SSH : " chemin_cle_ssh
    if [ -f "$chemin_cle_ssh" ]; then
        cat "$chemin_cle_ssh" >> ~/.ssh/authorized_keys
        echo "Clé SSH ajoutée."
    else
        echo "Fichier introuvable."
    fi
}

# Fonction pour changer la page web par défaut d'Apache à partir d'un fichier spécifié par l'utilisateur
changer_page_web() {
    read -p "Entrez le chemin du fichier HTML pour la page web par défaut d'Apache : " chemin_html
    if [ -f "$chemin_html" ]; then
        sudo cp "$chemin_html" /var/www/html/index.html
        echo "Page web par défaut d'Apache modifiée."
    else
        echo "Fichier introuvable."
    fi
}

# Menu principal
while true; do
    clear  # Efface l'écran avant d'afficher le menu



echo -e "\e[38;2;255;165;0m
    ░        ░  ░░░░  ░░      ░░  ░░░░░░░░       ░░░      ░░░      ░░  ░░░░  ░
    ▒  ▒▒▒▒▒▒▒  ▒▒▒▒  ▒  ▒▒▒▒  ▒  ▒▒▒▒▒▒▒▒  ▒▒▒▒  ▒  ▒▒▒▒  ▒  ▒▒▒▒▒▒▒  ▒▒▒▒  ▒
    ▓      ▓▓▓▓  ▓▓  ▓▓  ▓▓▓▓  ▓  ▓▓▓▓▓▓▓▓       ▓▓  ▓▓▓▓  ▓▓      ▓▓        ▓
    █  █████████    ███        █  ████████  ████  █        ███████  █  ████  █
    █        ████  ████  ████  █        ██       ██  ████  ██      ██  ████  █                                                           
\e[0m"
echo -e "   \n              Made by Martin Tech | https://martintech.fr/ | 2023\n"



echo -e "    1. Installer Apache2
    2. Activer SSH
    3. Désactiver SSH
    4. Activer Apache
    5. Désactiver Apache
    6. Ajouter une clé d'authentification SSH à partir d'un fichier
    7. Activer l'authentification par mot de passe SSH
    8. Désactiver l'authentification par mot de passe SSH
    9. Vérifier l'état d'un service
    10. Changer la page web par défaut d'Apache à partir d'un fichier
    11. Quitter\n"

    read -p "Choisissez une option : " choix

    case $choix in
        1) installer_apache;;
        2) activer_service ssh;;
        3) desactiver_service ssh;;
        4) activer_apache;;
        5) desactiver_apache;;
        6) ajouter_cle_ssh;;
        7) activer_auth_ssh;;
        8) desactiver_auth_ssh;;
        9) read -p "Entrez le nom du service : " service
           verifier_service $service;;
        10) changer_page_web;;
        11) break;;
        *) echo "Option invalide";;
    esac
    read -p "Appuyez sur Entrée pour continuer..."
done
