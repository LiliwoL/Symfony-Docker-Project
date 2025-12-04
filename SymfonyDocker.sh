#!/bin/bash
# SymfonyDocker.sh
# Script pour gérer les containers Docker d'un projet Symfony

# Couleurs pour l'affichage
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Détection de la commande docker compose/compose
if command -v docker compose &> /dev/null; then
    DOCKER_CMD="docker compose"
elif command -v docker-compose &> /dev/null; then
    DOCKER_CMD="docker-compose"
else
    echo -e "${RED}Erreur : ni 'docker compose' ni 'docker-compose' n'est installé.${NC}"
    exit 1
fi

# Fonction pour afficher le menu
afficher_menu() {
    clear
    echo -e "${YELLOW}============================================${NC}"
    echo -e "${YELLOW}          Gestion des containers Docker      ${NC}"
    echo -e "${YELLOW}============================================${NC}"
    echo -e "${GREEN}  🛠️ 1. Construire les containers${NC}"
    echo -e "${GREEN}  ▶️ 2. Lancer les containers${NC}"
    echo -e "${GREEN}  ⏹️ 3. Stopper les containers${NC}"
    echo -e "${GREEN}  🐚 4. Ouvrir un shell dans le container Symfony${NC}"
    echo -e "${GREEN}  📜 5. Afficher les logs du container Symfony${NC}"
    echo -e "${GREEN}  ❌ 6. Quitter${NC}"
    echo -e "${YELLOW}============================================${NC}"
}

# Fonction pour construire les containers
construire_containers() {
    echo -e "${YELLOW}🛠️ Construction des containers en cours...${NC}"
    $DOCKER_CMD build --pull --no-cache
    read -n 1 -s -r -p "Appuyez sur une touche pour continuer..."
}

# Fonction pour lancer les containers
lancer_containers() {
    echo -e "${YELLOW}▶️ Lancement des containers en cours...${NC}"
    $DOCKER_CMD up --wait
    read -n 1 -s -r -p "Appuyez sur une touche pour continuer..."
}

# Fonction pour stopper les containers
stopper_containers() {
    echo -e "${YELLOW}⏹️ Arrêt des containers en cours...${NC}"
    $DOCKER_CMD down --remove-orphans
    read -n 1 -s -r -p "Appuyez sur une touche pour continuer..."
}

# Fonction pour ouvrir un shell dans un container
ouvrir_shell() {
    echo -e "${YELLOW}🐚 Ouverture du shell :${NC}"
    $DOCKER_CMD exec php bash
}

# Fonction pour afficher les logs d'un container
afficher_logs() {
    echo -e "${YELLOW}📜 Ouverture des logs :${NC}"
    $DOCKER_CMD logs php -t -f
    read -n 1 -s -r -p "Appuyez sur une touche pour continuer..."
}

# Boucle principale du menu
while true; do
    afficher_menu
    PS3="Choisissez une option (1-6) : "
    options=("Construire" "Lancer" "Stopper" "Ouvrir un shell" "Afficher les logs" "Quitter")
    select opt in "${options[@]}"; do
        case $opt in
            "Construire") construire_containers; break ;;
            "Lancer") lancer_containers; break ;;
            "Stopper") stopper_containers; break ;;
            "Ouvrir un shell") ouvrir_shell; break ;;
            "Afficher les logs") afficher_logs; break ;;
            "Quitter")
                echo -e "${RED}❌ Sortie du script.${NC}"
                exit 0
                ;;
            *) echo -e "${RED}Option invalide.${NC}"; sleep 1; break ;;
        esac
    done
done
