#!/data/data/com.termux/files/usr/bin/bash

# Colores
verde='\033[1;32m'
verde_oscuro='\033[0;32m'
negro='\033[0;30m'
reset='\033[0m'

# Música de fondo
mpv --really-quiet --loop https://files.catbox.moe/tmhmm8.mp3 &>/dev/null &
PID_MUSIC=$!

# Título
clear
echo -e "${verde}"
figlet -f big "MayBots"
echo -e "${verde_oscuro}By SoyMaycol | Contacto: +51 921 826 291${reset}"
echo

# Bots disponibles
declare -A bots
bots["Perrito"]="apt update -y && yes | apt upgrade && pkg install -y bash wget figlet && wget -O - https://raw.githubusercontent.com/Ado926/Perrita-No-Yusha/main/IA.sh | bash"
bots["MaycolAI"]="apt update -y && yes | apt upgrade && pkg install -y bash wget figlet && wget -O - https://raw.githubusercontent.com/SoySapo6/MaycolAI/main/InstalacionAutomatica.sh | bash"
bots["GataBotMD"]="apt update -y && yes | apt upgrade && pkg install -y bash wget mpv && wget -O - https://raw.githubusercontent.com/GataNina-Li/GataBot-MD/master/gata.sh | bash"
bots["LoliBotMD"]="apt update -y && yes | apt upgrade && pkg install -y bash wget mpv && wget -O - https://raw.githubusercontent.com/elrebelde21/LoliBot-MD/master/install.sh | bash"

function show_menu() {
    echo -e "${verde}Comandos disponibles:${reset}"
    echo -e "${verde_oscuro}  maybots list${reset}           - Ver todos los bots"
    echo -e "${verde_oscuro}  maybots search <nombre>${reset} - Buscar un bot"
    echo -e "${verde_oscuro}  maybots install <nombre>${reset} - Instalar un bot"
    echo
}

function list_bots() {
    echo -e "${verde}Bots disponibles:${reset}"
    for name in "${!bots[@]}"; do
        echo -e " - ${verde_oscuro}${name}${reset}"
    done
}

function search_bot() {
    if [[ -n "${bots[$1]}" ]]; then
        echo -e "${verde}Bot encontrado: $1${reset}"
    else
        echo -e "${negro}Bot no encontrado: $1${reset}"
    fi
}

function install_bot() {
    local botname="$1"
    if [[ -n "${bots[$botname]}" ]]; then
        echo -e "${verde}Instalando $botname...${reset}"
        sleep 1
        echo -e "${verde_oscuro}Procesando instalación...${reset}"
        sleep 1
        bash -c "${bots[$botname]}"
        echo -e "${verde}$botname instalado correctamente.${reset}"
    else
        echo -e "${negro}Bot '$botname' no existe.${reset}"
    fi
}

function handle_command() {
    case "$1" in
        list)
            list_bots
            ;;
        search)
            search_bot "$2"
            ;;
        install)
            install_bot "$2"
            ;;
        *)
            echo -e "${negro}Comando no válido.${reset}"
            show_menu
            ;;
    esac
}

# Entrada del usuario
if [[ $# -eq 0 ]]; then
    show_menu
else
    handle_command "$1" "$2"
fi

# Detener música al final
kill $PID_MUSIC &>/dev/null
