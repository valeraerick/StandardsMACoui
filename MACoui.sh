#!/bin/bash

# Colours
greenColour="\033[1;32m"
endColour="\033[0m"
redColour="\033[1;31m"
blueColour="\033[1;34m"
purpleColour="\033[1;35m"
yellowColour="\033[1;33m"

#Funcion Ctrl+C

trap ctrl_c INT

function ctrl_c(){
    echo -e "\n\n${redColour}[!] Saliendo...\n${endColour}"
    exit 1
}


#Variable
mac_address=$1

# Función para validar el formato de la dirección MAC

validar_mac() {
    if [[ $1 =~ ^([0-9A-Fa-f]{2}[-:.]){5}[0-9A-Fa-f]{2}$ ]]; then
        return 0  # Formato de dirección MAC válido
    else
        return 1  # Formato de dirección MAC inválido
    fi
}

if ! validar_mac "$mac_address";
then
    echo -e "${redColour}[X] formato invalido: $mac_address ${endColour}"
    echo -e " ${purpleColour}[!]uso:${endColour}./MACoui <MAC address> \n ${purpleColour}[!]formato:${endColour} \n 00-11-22-33-44-55 \n 00:11:22:33:44:55 \n 00.11.22.33.44.55"
    exit 1
fi

GET_VDR=$(curl -s https://api.macvendors.com/$mac_address)

if [[ "$GET_VDR" =~ ^[0-9A-Z] ]]; then
    echo -e "\n${purpleColour}La MAC $1 pertenece al proveedor:${endColour} ${greenColour}${GET_VDR}${endColour}\n"
    
else
    echo -e "\n\t ${yellowColour}Proveedor no encontrado${endColour}\n"
    
fi