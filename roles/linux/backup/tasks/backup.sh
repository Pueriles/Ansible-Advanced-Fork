#!/bin/bash

# Basispad voor back-ups
backup_base="/etc/backup/backup"

# Voeg de huidige datum toe aan de mapnaam
backup_dir="$backup_base-$(date +%Y%m%d)"

# Controleer of de doelmap bestaat, anders maak deze aan
if [ ! -d "$backup_dir" ]; then
  mkdir -p "$backup_dir"
fi

# Array deze bestanden en mappen die we willen back-uppen
source_dirs=(
  "/etc/apache2"
  "/var/www/html/"
  "/etc/ssh/"
)

# Loop door de bronmappen en voer rsync uit voor elke map
for source_dir in "${source_dirs[@]}"; do
  rsync -av "$source_dir" "$backup_dir"
done

echo "Back-up voltooid naar: $backup_dir"