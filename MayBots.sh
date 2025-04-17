#!/data/data/com.termux/files/usr/bin/bash

# Reproduce música en bucle
mpv --really-quiet --loop https://files.catbox.moe/tmhmm8.mp3 >/dev/null 2>&1 &

verde='\033[1;32m'
verde_oscuro='\033[0;32m'
reset='\033[0m'

# Título
clear
echo -e "${verde}"
figlet -c MayBots
echo -e "${verde_oscuro}Google Play para Bots de WhatsApp${reset}"
echo -e "${verde}Contacto: +51 921 826 291${reset}"
echo

# Funciones
list_bots() {
  echo -e "${verde}Bots disponibles:${reset}"
  echo -e "${verde_oscuro}- Perrito no Yūsha${reset}"
  echo -e "${verde_oscuro}- MaycolAI${reset}"
  echo -e "${verde_oscuro}- GataBotMD${reset}"
  echo -e "${verde_oscuro}- LoliBotMD${reset}"
}

search_bot() {
  case "$1" in
    *Perrito*|*perrito*) echo -e "${verde}Bot encontrado: Perrito no Yūsha${reset}" ;;
    *Maycol*|*maycol*) echo -e "${verde}Bot encontrado: MaycolAI${reset}" ;;
    *Gata*|*gata*) echo -e "${verde}Bot encontrado: GataBotMD${reset}" ;;
    *Loli*|*loli*) echo -e "${verde}Bot encontrado: LoliBotMD${reset}" ;;
    *) echo -e "${verde_oscuro}No se encontró ningún bot llamado '$1'${reset}" ;;
  esac
}

install_bot() {
  case "$1" in
    *Perrito*|*perrito*)
      echo -e "${verde}Instalando Perrito no Yūsha...${reset}"
      apt update -y && yes | apt upgrade && pkg install -y bash wget figlet && \
      wget -O - https://raw.githubusercontent.com/Ado926/Perrita-No-Yusha/main/IA.sh | bash ;;
    *Maycol*|*maycol*)
      echo -e "${verde}Instalando MaycolAI...${reset}"
      apt update -y && yes | apt upgrade && pkg install -y bash wget figlet && \
      wget -O - https://raw.githubusercontent.com/SoySapo6/MaycolAI/main/InstalacionAutomatica.sh | bash ;;
    *Gata*|*gata*)
      echo -e "${verde}Instalando GataBotMD...${reset}"
      apt update -y && yes | apt upgrade && pkg install -y bash wget mpv && \
      wget -O - https://raw.githubusercontent.com/GataNina-Li/GataBot-MD/master/gata.sh | bash ;;
    *Loli*|*loli*)
      echo -e "${verde}Instalando LoliBotMD...${reset}"
      apt update -y && yes | apt upgrade && pkg install -y bash wget mpv && \
      wget -O - https://raw.githubusercontent.com/elrebelde21/LoliBot-MD/master/install.sh | bash ;;
    *) echo -e "${verde_oscuro}Bot no reconocido: '$1'${reset}" ;;
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
  read -p "${verde_oscuro}~$ ${reset}" input

  cmd=$(echo "$input" | awk '{print $1}')
  arg=$(echo "$input" | cut -d' ' -f2-)

  case "$cmd" in
    maybots)
      subcmd=$(echo "$arg" | awk '{print $1}')
      rest=$(echo "$arg" | cut -d' ' -f2-)
      case "$subcmd" in
        list) list_bots ;;
        search) search_bot "$rest" ;;
        install) install_bot "$rest" ;;
        *) echo -e "${verde_oscuro}Subcomando inválido: $subcmd${reset}" ;;
      esac ;;
    exit)
      echo -e "${verde}Saliendo de MayBots...${reset}"
      pkill mpv
      break ;;
    *)
      echo -e "${verde_oscuro}Comando no reconocido. Usa 'maybots' o 'exit'.${reset}" ;;
  esac
done
