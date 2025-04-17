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
  echo -e "${verde}Contacto: +51 921 826 291${reset}"
  echo ""
}

listar_bots() {
  echo -e "${verde}1. Perrito no Yūsha"
  echo "2. MaycolAI"
  echo "3. GataBotMD"
  echo -e "4. LoliBotMD${reset}"
}

buscar_bot() {
  local query=$(echo "$1" | tr '[:upper:]' '[:lower:]')
  echo -e "${verde}Buscando bot: $1...${reset}"
  case $query in
    perrito*|no*yusha)
      echo "Encontrado: Perrito no Yūsha";;
    maycol*|ai)
      echo "Encontrado: MaycolAI";;
    gata*|md)
      echo "Encontrado: GataBotMD";;
    loli*|md)
      echo "Encontrado: LoliBotMD";;
    *)
      echo -e "${verde_oscuro}No se encontró el bot '$1'.${reset}";;
  esac
}

instalar_bot() {
  local bot=$(echo "$1" | tr '[:upper:]' '[:lower:]')
  case $bot in
    perrito*|no*yusha)
      echo -e "${verde}Instalando Perrito no Yūsha...${reset}"
      apt update -y && yes | apt upgrade && pkg install -y bash wget figlet
      wget -O - https://raw.githubusercontent.com/Ado926/Perrita-No-Yusha/main/IA.sh | bash;;
    maycol*|ai)
      echo -e "${verde}Instalando MaycolAI...${reset}"
      apt update -y && yes | apt upgrade && pkg install -y bash wget figlet
      wget -O - https://raw.githubusercontent.com/SoySapo6/MaycolAI/main/InstalacionAutomatica.sh | bash;;
    gata*|md)
      echo -e "${verde}Instalando GataBotMD...${reset}"
      apt update -y && yes | apt upgrade && pkg install -y bash wget mpv
      wget -O - https://raw.githubusercontent.com/GataNina-Li/GataBot-MD/master/gata.sh | bash;;
    loli*|md)
      echo -e "${verde}Instalando LoliBotMD...${reset}"
      apt update -y && yes | apt upgrade && pkg install -y bash wget mpv
      wget -O - https://raw.githubusercontent.com/elrebelde21/LoliBot-MD/master/install.sh | bash;;
    *)
      echo -e "${verde_oscuro}Bot '$1' no encontrado.${reset}";;
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
    echo -e "${reset}"
    read -p "~$ " input

    # Saltar líneas vacías
    [ -z "$input" ] && continue

    # Procesar comando
    IFS=' ' read -r cmd subcmd arg_rest <<< "$input"
    arg="${input#"$cmd $subcmd "}"

    case $cmd in
      maybots)
        case $subcmd in
          list)
            listar_bots;;
          search)
            if [ -z "$arg" ]; then
              read -p "Nombre del bot: " nombre
              buscar_bot "$nombre"
            else
              buscar_bot "$arg"
            fi;;
          install)
            if [ -z "$arg" ]; then
              read -p "Nombre del bot a instalar: " nombre
              instalar_bot "$nombre"
            else
              instalar_bot "$arg"
            fi;;
          *)
            echo -e "${verde_oscuro}Comando inválido. Usa list, search o install.${reset}";;
        esac;;
      salir)
        echo -e "${verde_oscuro}Saliendo...${reset}"
        pkill mpv
        exit 0;;
      *)
        echo -e "${verde_oscuro}Comando no reconocido.${reset}";;
    esac
  done
}

main_menu
