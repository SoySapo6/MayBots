#!/data/data/com.termux/files/usr/bin/bash

# Colores
verde='\e[1;32m'
verde_oscuro='\e[0;32m'
reset='\e[0m'

# Reproducir música en bucle sin mostrar nada
mpv --really-quiet --loop https://files.catbox.moe/tmhmm8.mp3 &>/dev/null &

# Mostrar banner
banner() {
  clear
  echo -e "${verde}"
  figlet -c MayBots
  echo -e "${verde_oscuro}La Google Play de Bots de WhatsApp"
  echo -e "${verde}Contacto: +51 921 826 291${reset}\n"
}

# Mostrar lista
listar_bots() {
  echo -e "${verde}Bots disponibles:"
  echo "  - Perrito no Yūsha"
  echo "  - MaycolAI"
  echo -e "  - GataBotMD"
  echo -e "  - LoliBotMD${reset}"
}

# Buscar bot
buscar_bot() {
  nombre=$(echo "$1" | tr '[:upper:]' '[:lower:]')
  case "$nombre" in
    *perrito*|*yusha*) echo "Encontrado: Perrito no Yūsha";;
    *maycol*) echo "Encontrado: MaycolAI";;
    *gata*) echo "Encontrado: GataBotMD";;
    *loli*) echo "Encontrado: LoliBotMD";;
    *) echo -e "${verde_oscuro}No se encontró el bot '$1'.${reset}";;
  esac
}

# Instalar bot
instalar_bot() {
  nombre=$(echo "$1" | tr '[:upper:]' '[:lower:]')
  echo -e "${verde}Descargando e instalando '$1'...${reset}"
  sleep 1
  case "$nombre" in
    *perrito*|*yusha*)
      apt update -y && yes | apt upgrade && pkg install -y bash wget figlet
      wget -O - https://raw.githubusercontent.com/Ado926/Perrita-No-Yusha/main/IA.sh | bash;;
    *maycol*)
      apt update -y && yes | apt upgrade && pkg install -y bash wget figlet
      wget -O - https://raw.githubusercontent.com/SoySapo6/MaycolAI/main/InstalacionAutomatica.sh | bash;;
    *gata*)
      apt update -y && yes | apt upgrade && pkg install -y bash wget mpv
      wget -O - https://raw.githubusercontent.com/GataNina-Li/GataBot-MD/master/gata.sh | bash;;
    *loli*)
      apt update -y && yes | apt upgrade && pkg install -y bash wget mpv
      wget -O - https://raw.githubusercontent.com/elrebelde21/LoliBot-MD/master/install.sh | bash;;
    *) echo -e "${verde_oscuro}Bot '$1' no encontrado.${reset}";;
  esac
}

# Menú principal
main_menu() {
  banner
  while true; do
    echo -e "${verde}"
    echo "Comandos disponibles:"
    echo "  maybots list"
    echo "  maybots search <nombre>"
    echo "  maybots install <nombre>"
    echo "  salir"
    echo -ne "${reset}~$ "
    IFS= read -r input  # leer la línea completa incluso con espacios

    # Ignorar líneas vacías
    [[ -z "$input" ]] && continue

    comando=$(echo "$input" | awk '{print $1}')
    subcomando=$(echo "$input" | awk '{print $2}')
    argumento=$(echo "$input" | cut -d' ' -f3-)

    case "$input" in
      salir)
        echo -e "${verde_oscuro}Saliendo...${reset}"
        pkill mpv
        break
        ;;
      maybots\ list)
        listar_bots
        ;;
      maybots\ search\ *)
        if [[ -z "$argumento" ]]; then
          echo -e "${verde_oscuro}Especifica un nombre de bot.${reset}"
        else
          buscar_bot "$argumento"
        fi
        ;;
      maybots\ install\ *)
        if [[ -z "$argumento" ]]; then
          echo -e "${verde_oscuro}Especifica un nombre de bot para instalar.${reset}"
        else
          instalar_bot "$argumento"
        fi
        ;;
      *)
        echo -e "${verde_oscuro}Comando inválido. Usa list, search o install.${reset}"
        ;;
    esac
  done
}

main_menu
