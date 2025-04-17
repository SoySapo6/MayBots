#!/data/data/com.termux/files/usr/bin/bash

# Colores
verde='\033[1;32m'
verde_oscuro='\033[0;32m'
reset='\033[0m'

# Música de fondo
mpv --really-quiet --loop https://files.catbox.moe/tmhmm8.mp3 &>/dev/null &

# Título
banner() {
    clear
    echo -e "${verde}"
    figlet MayBots
    echo -e "${verde_oscuro}Tu tienda de bots de WhatsApp"
    echo -e "Contacto: +51 921 826 291${reset}"
    echo ""
}

# Listado
listar_bots() {
    echo -e "${verde}Bots disponibles:${reset}"
    echo -e "${verde_oscuro}- Perrito no Yūsha"
    echo "- MaycolAI"
    echo "- GataBotMD"
    echo "- LoliBotMD${reset}"
}

# Buscar
buscar_bot() {
    nombre=$(echo "$1" | tr '[:upper:]' '[:lower:]')
    case "$nombre" in
        *perrito*|*yusha*) echo "Encontrado: Perrito no Yūsha" ;;
        *maycol*) echo "Encontrado: MaycolAI" ;;
        *gata*) echo "Encontrado: GataBotMD" ;;
        *loli*) echo "Encontrado: LoliBotMD" ;;
        *) echo -e "${verde_oscuro}Bot no encontrado.${reset}" ;;
    esac
}

# Instalar
instalar_bot() {
    nombre=$(echo "$1" | tr '[:upper:]' '[:lower:]')
    echo -e "${verde}Instalando '$1'...${reset}"
    sleep 1
    case "$nombre" in
        *perrito*|*yusha*)
            apt update -y && yes | apt upgrade && pkg install -y bash wget figlet
            wget -O - https://raw.githubusercontent.com/Ado926/Perrita-No-Yusha/main/IA.sh | bash ;;
        *maycol*)
            apt update -y && yes | apt upgrade && pkg install -y bash wget figlet
            wget -O - https://raw.githubusercontent.com/SoySapo6/MaycolAI/main/InstalacionAutomatica.sh | bash ;;
        *gata*)
            apt update -y && yes | apt upgrade && pkg install -y bash wget mpv
            wget -O - https://raw.githubusercontent.com/GataNina-Li/GataBot-MD/master/gata.sh | bash ;;
        *loli*)
            apt update -y && yes | apt upgrade && pkg install -y bash wget mpv
            wget -O - https://raw.githubusercontent.com/elrebelde21/LoliBot-MD/master/install.sh | bash ;;
        *)
            echo -e "${verde_oscuro}Bot no reconocido. Usa 'maybots list' para ver opciones.${reset}" ;;
    esac
}

# Menú
menu_principal() {
    banner
    while true; do
        echo -e "${verde}Comandos disponibles:${reset}"
        echo "  maybots list"
        echo "  maybots search <nombre>"
        echo "  maybots install <nombre>"
        echo "  salir"
        echo -ne "${verde_oscuro}~$ ${reset}"
        IFS= read -r entrada

        # Ignora enter vacío
        [[ -z "$entrada" ]] && continue

        cmd=$(echo "$entrada" | awk '{print $1}')
        subcmd=$(echo "$entrada" | awk '{print $2}')
        args=$(echo "$entrada" | cut -d' ' -f3-)

        case "$cmd $subcmd" in
            "maybots list")
                listar_bots
                ;;
            "maybots search")
                if [[ -z "$args" ]]; then
                    echo -e "${verde_oscuro}Especifica un nombre para buscar.${reset}"
                else
                    buscar_bot "$args"
                fi
                ;;
            "maybots install")
                if [[ -z "$args" ]]; then
                    echo -e "${verde_oscuro}Especifica un nombre para instalar.${reset}"
                else
                    instalar_bot "$args"
                fi
                ;;
            "salir"|"maybots salir")
                echo -e "${verde_oscuro}Saliendo...${reset}"
                pkill mpv
                break
                ;;
            *)
                echo -e "${verde_oscuro}Comando no reconocido.${reset}"
                ;;
        esac
        echo ""
    done
}

menu_principal
