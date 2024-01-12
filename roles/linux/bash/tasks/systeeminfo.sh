#!/bin/bash

# Datum en tijd
datum_en_tijd=$(date)

# Gebruikersnaam
gebruikersnaam=$(whoami)

# Hostnaam
hostnaam=$(hostname)

# Type processor
processor=$(lscpu | grep "Model name" | awk -F: '{print $2}' | xargs)

# Hoeveelheid RAM
ram=$(free -h | awk '/^Mem/ {print $2}')

# Besturingssysteem
os=$(lsb_release -d | cut -f2-)

# Temperatuur (afhankelijk van beschikbare commando's en hardware)
temperatuur=$(sensors | awk '/^Package/{print $4}' || echo "Niet beschikbaar")

# Functie om het systeem bij te werken
update_system() {
    echo "Updates ophalen..."
    sudo apt update

    echo "Beschikbare updates weergeven:"
    sudo apt list --upgradable

    echo "Updates installeren..."
    sudo apt upgrade -y
}

# Toon de uitgebreide systeeminformatie
echo "Datum en tijd: $datum_en_tijd"
echo "Gebruikersnaam: $gebruikersnaam"
echo "Hostnaam: $hostnaam"
echo "Processor: $processor"
echo "RAM: $ram"
echo "Besturingssysteem: $os"
echo "Temperatuur: $temperatuur"

# Automatisch het systeem bijwerken zonder te vragen
update_system
echo "Systeem is bijgewerkt."
