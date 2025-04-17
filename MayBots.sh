#!/data/data/com.termux/files/usr/bin/bash

# Reproduce música de fondo en bucle
mpv --really-quiet --loop https://files.catbox.moe/tmhmm8.mp3 >/dev/null 2>&1 &

# Colores
verde='\033[1;32m'
verde_oscuro='\033[0;32m'
reset='\033[0m'

# Mostrar título
clear
echo -e "${verde}"
figlet -c MayBots
echo -e "${verde_oscuro}  Google Play para Bots de WhatsApp${reset}"
echo -e "${verde}  Contacto: +51 921 826 291${reset}"
echo

# Funciones
list_bots() {
  echo -e "${verde}Bots disponibles:${reset}"
  echo -e "${verde_oscuro}1.${reset} Perrito no Yūsha"
  echo -e "${verde_oscuro}2.${reset} MaycolAI"
  echo -e "${verde_oscuro}3.${reset} GataBotMD"
  echo -e "${verde_oscuro}4.${reset} LoliBotMD"
}

search_bot() {
  case "$1" in
    Perrito*|perrito*)
      echo -e "${verde}Bot encontrado: Perrito no Yūsha${reset}" ;;
    Maycol*|maycol*)
      echo -e "${verde}Bot encontrado: MaycolAI${reset}" ;;
    Gata*|gata*)
      echo -e "${verde}Bot encontrado: GataBotMD${reset}" ;;
    Loli*|loli*)
      echo -e "${verde}Bot encontrado: LoliBotMD${reset}" ;;
    *)
      echo -e "${verde_oscuro}No se encontró ningún bot llamado '$1'${reset}" ;;
  esac
}

install_bot() {
  case "$1" in
    Perrito*|perrito*)
      echo -e "${verde}Instalando Perrito no Yūsha...${reset}"
      apt update -y && yes | apt upgrade && pkg install -y bash wget figlet && \
      wget -O - https://raw.githubusercontent.com/Ado926/Perrita-No-Yusha/main/IA.sh | bash ;;
    Maycol*|maycol*)
      echo -e "${verde}Instalando MaycolAI...${reset}"
      apt update -y && yes | apt upgrade && pkg install -y bash wget figlet && \
      wget -O - https://raw.githubusercontent.com/SoySapo6/MaycolAI/main/InstalacionAutomatica.sh | bash ;;
    Gata*|gata*)
      echo -e "${verde}Instalando GataBotMD...${reset}"
      apt update -y && yes | apt upgrade && pkg install -y bash wget mpv && \
      wget -O - https://raw.githubusercontent.com/GataNina-Li/GataBot-MD/master/gata.sh | bash ;;
    Loli*|loli*)
      echo -e "${verde}Instalando LoliBotMD...${reset}"
      apt update -y && yes | apt upgrade && pkg install -y bash wget mpv && \
      wget -O - https://raw.githubusercontent.com/elrebelde21/LoliBot-MD/master/install.sh | bash ;;
    *)
      echo -e "${verde_oscuro}Bot no reconocido: '$1'${reset}" ;;
  esac
}

# Menú interactivo
while true; do
  echo
  echo -e "${verde}Comandos disponibles:${reset}"
  echo -e "${verde_oscuro}- maybots list${reset}"
  echo -e "${verde_oscuro}- maybots search <bot>${reset}"
  echo -e "${verde_oscuro}- maybots install <bot>${reset}"
  echo -e "${verde_oscuro}- exit${reset}"
  echo
  read -p "${verde_oscuro}~$ ${reset}" comando arg

  case "$comando" in
    maybots)
      case "$arg" in
        list)
          list_bots ;;
        search)
          read -p "${verde_oscuro}Nombre del bot: ${reset}" nombre
          search_bot "$nombre" ;;
        install)
          read -p "${verde_oscuro}Nombre del bot: ${reset}" nombre
          install_bot "$nombre"
          break ;;
        *)
          echo -e "${verde_oscuro}Comando inválido. Usa: list, search o install.${reset}" ;;
      esac ;;
    exit)
      echo -e "${verde}Saliendo de MayBots...${reset}"
      pkill mpv
      exit ;;
    *)
      echo -e "${verde_oscuro}Comando no reconocido. Intenta de nuevo.${reset}" ;;
  esac
done
