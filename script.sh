#!/bin/bash

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

    echo -e "\e[94m
    ░        ░  ░░░░  ░░      ░░  ░░░░░░░       ░░░      ░░░      ░░  ░░░░  ░
    ▒  ▒▒▒▒▒▒▒  ▒▒▒▒  ▒  ▒▒▒▒  ▒  ▒▒▒▒▒▒▒  ▒▒▒▒  ▒  ▒▒▒▒  ▒  ▒▒▒▒▒▒▒  ▒▒▒▒  ▒
    ▓      ▓▓▓▓  ▓▓  ▓▓  ▓▓▓▓  ▓  ▓▓▓▓▓▓▓       ▓▓  ▓▓▓▓  ▓▓      ▓▓        ▓
    █  █████████    ███        █  ███████  ████  █        ███████  █  ████  █
    █        ████  ████  ████  █        █       ██  ████  ██      ██  ████  █
                                                                            
    \e[0m
    1. Activer SSH
    2. Désactiver SSH
    3. Activer Apache
    4. Désactiver Apache
    5. Ajouter une clé d'authentification SSH à partir d'un fichier
    6. Activer l'authentification par mot de passe SSH
    7. Désactiver l'authentification par mot de passe SSH
    8. Vérifier l'état d'un service
    9. Changer la page web par défaut d'Apache à partir d'un fichier
    10. Quitter

    "

    read -p "Choisissez une option : " choix

    case $choix in
        1) activer_service ssh;;
        2) desactiver_service ssh;;
        3) activer_apache;;
        4) desactiver_apache;;
        5) ajouter_cle_ssh;;
        6) activer_auth_ssh;;
        7) desactiver_auth_ssh;;
        8) read -p "Entrez le nom du service : " service
           verifier_service $service;;
        9) changer_page_web;;
        10) break;;
        *) echo "Option invalide";;
    esac
    read -p "Appuyez sur Entrée pour continuer..."
done
