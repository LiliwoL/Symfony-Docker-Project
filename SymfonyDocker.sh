#!/bin/bash

# SymfonyDocker.sh
# Script pour gérer les containers Docker d'un projet Symfony

# Couleurs pour l'affichage
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Fonction pour afficher le menu
afficher_menu() {
    clear
    echo -e "${YELLOW}============================================${NC}"
    echo -e "${YELLOW}          Gestion des containers Docker      ${NC}"
    echo -e "${YELLOW}============================================${NC}"
    echo -e "${GREEN}  🛠️ 1. Construire les containers${NC}"
    echo -e "${GREEN}  ▶️ 2. Lancer les containers${NC}"
    echo -e "${GREEN}  ⏹️ 3. Stopper les containers${NC}"
    echo -e "${GREEN}  ❌ 4. Quitter${NC}"
    echo -e "${YELLOW}============================================${NC}"
    echo -n "Choisissez une option (1-4) : "
}

# Fonction pour construire les containers
construire_containers() {
    echo -e "${YELLOW}🛠️ Construction des containers en cours...${NC}"
    # Remplacez la commande ci-dessous par celle que vous souhaitez exécuter
    docker compose build --pull --no-cache
    read -n 1 -s -r -p "Appuyez sur une touche pour continuer..."
}

# Fonction pour lancer les containers
lancer_containers() {
    echo -e "${YELLOW}▶️ Lancement des containers en cours...${NC}"
    # Remplacez la commande ci-dessous par celle que vous souhaitez exécuter
    docker compose up --wait
    read -n 1 -s -r -p "Appuyez sur une touche pour continuer..."
}

# Fonction pour stopper les containers
stopper_containers() {
    echo -e "${YELLOW}⏹️ Arrêt des containers en cours...${NC}"
    # Remplacez la commande ci-dessous par celle que vous souhaitez exécuter
    docker compose down --remove-orphans
    read -n 1 -s -r -p "Appuyez sur une touche pour continuer..."
}

# Boucle principale du menu
while true; do
    afficher_menu
    read choix
    case $choix in
        1) construire_containers ;;
        2) lancer_containers ;;
        3) stopper_containers ;;
        4)
            echo -e "${RED}❌ Sortie du script.${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Option invalide. Veuillez réessayer.${NC}"
            sleep 1
            ;;
    esac
done
