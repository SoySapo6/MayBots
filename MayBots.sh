#!/data/data/com.termux/files/usr/bin/bash

# Colores
verde='\e[1;32m'
verde_oscuro='\e[0;32m'
reset='\e[0m'

# Música de fondo en bucle
mpv --really-quiet --loop https://files.catbox.moe/tmhmm8.mp3 &>/dev/null &

# Cabecera
banner() {
  clear
  echo -e "${verde}"
  figlet -c MayBots
  echo -e "${verde_oscuro}La Google Play de Bots de WhatsApp"
  echo -e "${verde}Contacto: +51 921 826 291${reset}\n"
}

listar_bots() {
  echo -e "${verde}Bots disponibles:"
  echo "  - Perrito no Yūsha"
  echo "  - MaycolAI"
  echo "  - GataBotMD"
  echo -e "  - LoliBotMD${reset}"
}

buscar_bot() {
  query=$(echo "$1" | tr '[:upper:]' '[:lower:]')
  case $query in
    *perrito*|*yusha*) echo "Encontrado: Perrito no Yūsha";;
    *maycol*) echo "Encontrado: MaycolAI";;
    *gata*) echo "Encontrado: GataBotMD";;
    *loli*) echo "Encontrado: LoliBotMD";;
    *) echo -e "${verde_oscuro}No se encontró el bot '$1'.${reset}";;
  esac
}

instalar_bot() {
  bot=$(echo "$1" | tr '[:upper:]' '[:lower:]')
  echo -e "${verde}Descargando e instalando $1...${reset}"
  sleep 1
  case $bot in
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
    *)
      echo -e "${verde_oscuro}Bot '$1' no encontrado.${reset}";;
  esac
}

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
    read -r input

    # Saltar líneas vacías
    [[ -z "$input" ]] && continue

    comando=$(echo "$input" | awk '{print $1}')
    accion=$(echo "$input" | awk '{print $2}')
    argumento=$(echo "$input" | cut -d' ' -f3-)

    if [[ "$input" == "salir" ]]; then
      echo -e "${verde_oscuro}Saliendo...${reset}"
      pkill mpv
      break
    elif [[ "$comando" == "maybots" ]]; then
      case "$accion" in
        list) listar_bots;;
        search)
          if [[ -z "$argumento" ]]; then
            echo -e "${verde_oscuro}Especifica un bot para buscar.${reset}"
          else
            buscar_bot "$argumento"
          fi;;
        install)
          if [[ -z "$argumento" ]]; then
            echo -e "${verde_oscuro}Especifica un bot para instalar.${reset}"
          else
            instalar_bot "$argumento"
          fi;;
        *) echo -e "${verde_oscuro}Comando inválido. Usa list, search o install.${reset}";;
      esac
    else
      echo -e "${verde_oscuro}Comando no reconocido.${reset}"
    fi
  done
}

main_menu
