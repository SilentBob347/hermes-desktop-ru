#!/bin/bash
# Hermes Desktop Russian Locale Installer (v2, 2026-08-01)
# Устанавливает русский язык в десктопное приложение Hermes Agent (v0.19.1)
#
# Использование:
#   git clone https://github.com/warment/hermes-desktop-ru.git && cd hermes-desktop-ru && ./install.sh
#   или с указанием пути: ./install.sh /path/to/hermes-agent

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

HERMES_DIR="${1:-}"
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

log()   { echo -e "${GREEN}[✓]${NC} $1"; }
warn()  { echo -e "${YELLOW}[!]${NC} $1"; }
error() { echo -e "${RED}[✗]${NC} $1"; exit 1; }

# Список всех файлов перевода (патчи i18n + компоненты)
FILES=(
  "apps/desktop/src/i18n/catalog.ts"
  "apps/desktop/src/i18n/en.ts"
  "apps/desktop/src/i18n/languages.ts"
  "apps/desktop/src/i18n/ru.ts"
  "apps/desktop/src/i18n/types.ts"
  "apps/desktop/src/i18n/zh.ts"
  "apps/desktop/src/app/settings/ru-constants.ts"
  "apps/desktop/src/app/chat/index.tsx"
  "apps/desktop/src/app/chat/session-tile.tsx"
  "apps/desktop/src/app/chat/sidebar/profile-switcher.tsx"
  "apps/desktop/src/app/contrib/controller.tsx"
  "apps/desktop/src/app/contrib/panes.tsx"
  "apps/desktop/src/app/pet-generate/components/generate-unavailable.tsx"
  "apps/desktop/src/app/pet-generate/components/reference-chip.tsx"
  "apps/desktop/src/app/pet-overlay/overlay-root.tsx"
  "apps/desktop/src/app/pet-overlay/pet-overlay-app.tsx"
  "apps/desktop/src/app/quick-entry/quick-entry-app.tsx"
  "apps/desktop/src/app/quick-entry/quick-entry-root.tsx"
  "apps/desktop/src/app/settings/appearance-settings.tsx"
  "apps/desktop/src/app/settings/billing/auto-reload-row.tsx"
  "apps/desktop/src/app/settings/billing/current-plan-card.tsx"
  "apps/desktop/src/app/settings/billing/index.tsx"
  "apps/desktop/src/app/settings/billing/inline-feedback.tsx"
  "apps/desktop/src/app/settings/billing/plans-view.tsx"
  "apps/desktop/src/app/settings/combobox-input.tsx"
  "apps/desktop/src/app/settings/computer-use-panel.tsx"
  "apps/desktop/src/app/settings/custom-endpoints-settings.tsx"
  "apps/desktop/src/app/settings/model-settings.tsx"
  "apps/desktop/src/app/settings/uninstall-section.tsx"
  "apps/desktop/src/app/shell/model-menu-panel.tsx"
  "apps/desktop/src/app/skills/mcp-tab.tsx"
  "apps/desktop/src/app/starmap/star-map.tsx"
  "apps/desktop/src/app/starmap/timeline.tsx"
  "apps/desktop/src/components/assistant-ui/embeds/spotify-embed.tsx"
  "apps/desktop/src/components/assistant-ui/embeds/youtube-embed.tsx"
  "apps/desktop/src/components/assistant-ui/thread/message-reactions.tsx"
  "apps/desktop/src/components/assistant-ui/thread/timeline.tsx"
  "apps/desktop/src/components/assistant-ui/tool/fallback.tsx"
  "apps/desktop/src/components/chat/generated-image-result.tsx"
  "apps/desktop/src/components/pet/pet-egg-hatch.tsx"
  "apps/desktop/src/components/ui/split-button.tsx"
)

# --- Find Hermes installation ---
find_hermes() {
  [ -n "$HERMES_DIR" ] && return 0
  local candidates=(
    "$HOME/.hermes/hermes-agent"
    "$HOME/hermes-agent"
    "/opt/hermes-agent"
    "$HOME/Dev/hermes-agent"
    "$HOME/projects/hermes-agent"
  )
  for dir in "${candidates[@]}"; do
    if [ -d "$dir/apps/desktop/src/i18n" ]; then
      HERMES_DIR="$dir"
      return 0
    fi
  done
  # Try to find via `which hermes`
  local hermes_bin
  hermes_bin=$(which hermes 2>/dev/null || true)
  if [ -n "$hermes_bin" ]; then
    local real_path
    real_path=$(realpath "$hermes_bin" 2>/dev/null || readlink -f "$hermes_bin" 2>/dev/null || true)
    if [ -n "$real_path" ]; then
      local candidate
      candidate=$(dirname "$(dirname "$real_path")")
      if [ -d "$candidate/apps/desktop/src/i18n" ]; then
        HERMES_DIR="$candidate"
        return 0
      fi
    fi
  fi
  return 1
}

# --- Check if Russian is already installed ---
check_existing() {
  if [ -f "$HERMES_DIR/apps/desktop/src/i18n/ru.ts" ]; then
    if grep -q "Hermes Desktop готов" "$HERMES_DIR/apps/desktop/src/i18n/ru.ts" 2>/dev/null; then
      warn "Русский перевод уже установлен"
      read -p "Переустановить? (y/N) " -n 1 -r
      echo
      if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 0
      fi
    fi
  fi
}

# --- Backup ---
backup() {
  local backup_dir="$HERMES_DIR/.ru-backup-$(date +%Y%m%d%H%M%S)"
  mkdir -p "$backup_dir"
  for f in "${FILES[@]}"; do
    if [ -f "$HERMES_DIR/$f" ]; then
      mkdir -p "$backup_dir/$(dirname "$f")"
      cp "$HERMES_DIR/$f" "$backup_dir/$f"
    fi
  done
  log "Бэкап создан: $backup_dir"
  echo "$backup_dir" > "$HERMES_DIR/.ru-last-backup"
}

# --- Apply files ---
apply_patches() {
  log "Копирование файлов перевода..."

  # i18n-файлы (полные версии en/zh/types/catalog/languages + ru)
  cp "$REPO_DIR/patches/i18n/"*.ts "$HERMES_DIR/apps/desktop/src/i18n/"
  # ru-constants.ts (поля настроек)
  cp "$REPO_DIR/patches/ru-constants.ts" "$HERMES_DIR/apps/desktop/src/app/settings/ru-constants.ts"
  # переведённые компоненты (биллинг, компьютер, эмодзи-пикер, оверлеи и т.д.)
  rsync -a "$REPO_DIR/patches/src/" "$HERMES_DIR/apps/desktop/src/"

  log "Все 41 файл перевода применены"
}

# --- Build ---
build() {
  log "Сборка приложения (несколько минут)..."
  cd "$HERMES_DIR/apps/desktop"
  if npm run pack 2>&1 | tail -5; then
    log "Сборка завершена успешно"
  else
    error "Ошибка сборки. Проверьте логи выше."
  fi
}

# --- Install LaunchAgent for auto-reapply ---
install_autopatch() {
  local plist_path="$HOME/Library/LaunchAgents/com.hermes-desktop-ru.patcher.plist"
  local script_path="$REPO_DIR/scripts/auto-patch.sh"

  chmod +x "$script_path"

  cat > "$plist_path" << PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.hermes-desktop-ru.patcher</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/bash</string>
        <string>$script_path</string>
    </array>
    <key>WatchPaths</key>
    <array>
        <string>$HERMES_DIR/apps/desktop/src/i18n/en.ts</string>
    </array>
    <key>ThrottleInterval</key>
    <integer>10</integer>
</dict>
</plist>
PLIST

  launchctl load "$plist_path" 2>/dev/null || true
  log "Auto-patcher установлен (LaunchAgent)"
}

# --- Main ---
echo ""
echo "🇷🇺 Hermes Desktop Russian Locale Installer v2"
echo "=============================================="
echo ""

if ! find_hermes; then
  error "Hermes Agent не найден. Укажите путь вручную: ./install.sh /path/to/hermes-agent"
fi

log "Hermes найден: $HERMES_DIR"
check_existing
backup
apply_patches
build
install_autopatch

echo ""
echo "============================================"
log "Готово! Русский язык установлен (~99% интерфейса)."
echo ""
echo "Запустите Hermes Desktop и выберите:"
echo "  Settings → Appearance → Русский"
echo ""
echo "Для отката: $HERMES_DIR/.ru-backup-*/restore.sh"
echo "Для удаления: ./uninstall.sh"
echo ""
