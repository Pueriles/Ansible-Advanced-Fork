#!/bin/bash

# Basispad voor back-ups
backup_base="/etc/backup/backup"

# Zoek de nieuwste back-upmap op basis van de datum in de naam
latest_backup=$(ls -td $backup_base-* | head -n 1)

# Controleer of er back-ups beschikbaar zijn
if [ -z "$latest_backup" ]; then
  echo "Geen back-ups gevonden in $backup_base"
  exit 1
fi

#Map om te herstellen
restore_dir="/etc/restore"

# Controleer of de doelmap bestaat, anders maak deze aan
if [ ! -d "$restore_dir" ]; then
  mkdir -p "$restore_dir"
fi

# Array van bestanden en mappen die we willen herstellen
restore_files=(
  "/etc/apache2"
  "/var/www/html/"
  "/etc/ssh/"
)

# Loop door de bestanden en mappen en voer rsync uit voor elke map
for restore_source in "$restore_dirs[@]}"; do
  restore_path="$latest_backup${restore_source}"
  echo "Herstellen van $restore_path naar $restore_dir"
    rsync -a "$restore_path" "$restore_dir"
done

echo "Herstel voltooid naar: $restore_dir"