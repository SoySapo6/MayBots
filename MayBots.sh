#!/data/data/com.termux/files/usr/bin/bash

# Colores
verde='\033[1;32m'
verde_oscuro='\033[0;32m'
reset='\033[0m'

# Iniciar música en loop de fondo
mpv --really-quiet --loop https://files.catbox.moe/tmhmm8.mp3 &>/dev/null &

# Mostrar banner principal
banner() {
    clear
    echo -e "${verde}"
    figlet MayBots
    echo -e "${verde_oscuro}La Google Play de Bots de WhatsApp${reset}"
    echo -e "${verde}Contacto: +51 921 826 291${reset}"
    echo ""
}

# Mostrar lista de bots
listar_bots() {
    echo -e "${verde}Bots disponibles:${reset}"
    echo " - Perrito no Yūsha"
    echo " - MaycolAI"
    echo " - GataBotMD"
    echo " - LoliBotMD"
}

# Buscar bot por nombre
buscar_bot() {
    nombre=$(echo "$1" | tr '[:upper:]' '[:lower:]')
    case "$nombre" in
        *perrito*|*yusha*) echo "Encontrado: Perrito no Yūsha";;
        *maycol*) echo "Encontrado: MaycolAI";;
        *gata*) echo "Encontrado: GataBotMD";;
        *loli*) echo "Encontrado: LoliBotMD";;
        *) echo -e "${verde_oscuro}No se encontró ningún bot con ese nombre.${reset}";;
    esac
}

# Instalar bot
instalar_bot() {
    nombre=$(echo "$1" | tr '[:upper:]' '[:lower:]')
    echo -e "${verde}Instalando '$1'...${reset}"
    sleep 1
    case "$nombre" in
        *perrito*|*yusha*)
            pkg install -y bash wget figlet && apt update -y && yes | apt upgrade
            wget -O - https://raw.githubusercontent.com/Ado926/Perrita-No-Yusha/main/IA.sh | bash
            ;;
        *maycol*)
            pkg install -y bash wget figlet && apt update -y && yes | apt upgrade
            wget -O - https://raw.githubusercontent.com/SoySapo6/MaycolAI/main/InstalacionAutomatica.sh | bash
            ;;
        *gata*)
            pkg install -y bash wget mpv && apt update -y && yes | apt upgrade
            wget -O - https://raw.githubusercontent.com/GataNina-Li/GataBot-MD/master/gata.sh | bash
            ;;
        *loli*)
            pkg install -y bash wget mpv && apt update -y && yes | apt upgrade
            wget -O - https://raw.githubusercontent.com/elrebelde21/LoliBot-MD/master/install.sh | bash
            ;;
        *) echo -e "${verde_oscuro}No se pudo instalar '$1'. Bot no encontrado.${reset}";;
    esac
}

# Menú principal
menu_principal() {
    banner
    while true; do
        echo -e "${verde}Comandos disponibles:${reset}"
        echo "  maybots list"
        echo "  maybots search <nombre>"
        echo "  maybots install <nombre>"
        echo "  salir"
        echo -ne "${verde_oscuro}~$ ${reset}"
        read -r entrada

        [[ -z "$entrada" ]] && continue  # Si presionó solo enter, ignorar

        comando=$(echo "$entrada" | awk '{print $1}')
        accion=$(echo "$entrada" | awk '{print $2}')
        argumento=$(echo "$entrada" | cut -d' ' -f3-)

        if [[ "$entrada" == "salir" ]]; then
            echo -e "${verde_oscuro}Saliendo...${reset}"
            pkill mpv
            break
        elif [[ "$comando" == "maybots" ]]; then
            case "$accion" in
                list) listar_bots ;;
                search)
                    if [[ -z "$argumento" ]]; then
                        echo -e "${verde_oscuro}Especifica un nombre para buscar.${reset}"
                    else
                        buscar_bot "$argumento"
                    fi
                    ;;
                install)
                    if [[ -z "$argumento" ]]; then
                        echo -e "${verde_oscuro}Especifica un nombre para instalar.${reset}"
                    else
                        instalar_bot "$argumento"
                    fi
                    ;;
                *) echo -e "${verde_oscuro}Acción inválida. Usa list, search o install.${reset}" ;;
            esac
        else
            echo -e "${verde_oscuro}Comando no reconocido.${reset}"
        fi

        echo ""  # Línea en blanco para separar
    done
}

menu_principal
