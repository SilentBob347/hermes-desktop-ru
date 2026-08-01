#!/bin/bash
# Auto-patcher: re-applies Russian translation after Hermes updates
# Triggered by LaunchAgent when en.ts changes (indicating an update)

REPO_DIR="$(dirname "$(dirname "$0")")"
HERMES_DIR=""

find_hermes() {
  local candidates=(
    "$HOME/.hermes/hermes-agent"
    "$HOME/hermes-agent"
    "$HOME/Dev/hermes-agent"
    "$HOME/projects/hermes-agent"
  )
  for dir in "${candidates[@]}"; do
    if [ -d "$dir/apps/desktop/src/i18n" ]; then
      HERMES_DIR="$dir"
      return 0
    fi
  done
  return 1
}

if ! find_hermes; then
  exit 0
fi

# Check if Russian was previously installed
if [ ! -f "$HERMES_DIR/.ru-last-backup" ]; then
  exit 0
fi

# Re-apply if ru.ts was overwritten by an update
if [ ! -f "$HERMES_DIR/apps/desktop/src/i18n/ru.ts" ] || ! grep -q "Hermes Desktop готов" "$HERMES_DIR/apps/desktop/src/i18n/ru.ts" 2>/dev/null; then
  echo "[$(date)] Hermes updated, re-applying Russian translation..."
  # Копируем i18n-файлы
  cp "$REPO_DIR/patches/i18n/"*.ts "$HERMES_DIR/apps/desktop/src/i18n/"
  cp "$REPO_DIR/patches/ru-constants.ts" "$HERMES_DIR/apps/desktop/src/app/settings/ru-constants.ts"
  rsync -a "$REPO_DIR/patches/src/" "$HERMES_DIR/apps/desktop/src/"
  # Пересборка
  cd "$HERMES_DIR/apps/desktop" && npm run pack >/dev/null 2>&1 || true
  echo "[$(date)] Russian locale re-applied"
fi
