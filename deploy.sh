#!/bin/bash
# Deploy einer Datei auf p2cx.de
# Usage: ./deploy.sh <lokale-datei> [ziel-pfad]
# Beispiel: ./deploy.sh content/de/technische-anforderungen-vm.html de/technische-anforderungen-vm.html

SSH_KEY="C:/Users/Hauke Loyos/Documents/.ssh/id_ed25519"
SERVER="root@87.106.190.113"
WEB_ROOT="/var/www/p2cx-landing/p2cx"

if [ -z "$1" ]; then
  echo "Usage: ./deploy.sh <lokale-datei> [ziel-pfad-relativ-zu-webroot]"
  echo "Beispiel: ./deploy.sh content/de/meine-seite.html de/meine-seite.html"
  exit 1
fi

LOCAL_FILE="$1"
REMOTE_PATH="${2:-$(basename "$1")}"

echo "Uploading: $LOCAL_FILE → $WEB_ROOT/$REMOTE_PATH"
scp -i "$SSH_KEY" -o StrictHostKeyChecking=no "$LOCAL_FILE" "$SERVER:$WEB_ROOT/$REMOTE_PATH"

if [ $? -eq 0 ]; then
  echo "OK — https://p2cx.de/$REMOTE_PATH"
else
  echo "FEHLER beim Upload!"
  exit 1
fi
