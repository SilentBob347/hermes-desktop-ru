<p align="center">
  <img src="https://img.shields.io/badge/Hermes_Desktop-Russian_locale_v2-FFD700?style=for-the-badge&labelColor=1a1a2e" alt="Hermes Desktop Russian Locale v2" width="100%">
</p>

<h1 align="center">🇷🇺 Hermes Desktop — Russian Language (v2)</h1>

<p align="center">
  <a href="https://github.com/NousResearch/hermes-agent"><img src="https://img.shields.io/badge/Hermes_Agent-Official_Repo-FFD700?style=for-the-badge&logo=github" alt="Hermes Agent"></a>
  <a href="https://github.com/warment/hermes-desktop-ru/releases"><img src="https://img.shields.io/github/v/release/warment/hermes-desktop-ru?style=for-the-badge&color=green" alt="Release"></a>
  <a href="https://github.com/warment/hermes-desktop-ru/blob/main/LICENSE"><img src="https://img.shields.io/badge/License-MIT-green?style=for-the-badge" alt="License: MIT"></a>
</p>

<p align="center">
  <b>Full Russian localization of the Hermes Agent desktop app — ~99% of all UI strings.</b><br>
  [<a href="README.md">Русский</a>] · [<b>English</b>] · [<a href="README.zh.md">中文</a>]
</p>

---

## ⚡ Quick install

```bash
git clone https://github.com/warment/hermes-desktop-ru.git
cd hermes-desktop-ru
./install.sh
```

Or in one command:

```bash
curl -sSL https://raw.githubusercontent.com/warment/hermes-desktop-ru/main/install.sh | bash
```

> ⚠️ Requires Hermes Agent **v0.19.1** (2026-07-30) or newer — the script copies full translation files over the sources.

After install: **Settings** → **Appearance** → **Русский**

---

## ✨ What's translated (v2)

- **All 38 i18n sections** (~3000 lines of `ru.ts`): menus, settings, billing, notifications, hotkeys, overlays, boot, install, onboarding, status bar and more
- **Settings fields** (`ru-constants.ts`): all labels and descriptions
- **Hardcoded component strings** (41 files):
  - Billing: verification page, plans, auto-reload, fixtures
  - App uninstall (Danger zone), Computer Use (permissions, driver health)
  - MoA presets, custom endpoints, theme search, generation references
  - Quick Entry window and pet overlay (separate renderer windows)
  - Emoji picker, session timelines, star map (legend/skill/memory)
  - Show options / More actions buttons, OAuth / API key, profiles, embeds

Intentionally untranslated: URL examples, provider brand names, config files (config.yaml, SOUL.md).

---

## 🛡️ Auto-update

When Hermes updates, the Russian locale is **automatically re-applied** via a macOS LaunchAgent that watches the source files.

---

## 🗑️ Uninstall

```bash
./uninstall.sh
```

Restores all 41 original files from backup and removes the translation.

---

## 📁 Structure

```
hermes-desktop-ru/
├── install.sh              # Installer (v2)
├── uninstall.sh            # Uninstaller
├── README.md               # Docs (RU/EN/ZH)
├── patches/
│   ├── i18n/               # Full i18n files (ru, en, zh, types, catalog, languages)
│   ├── ru-constants.ts     # Russian settings field labels
│   └── src/                # Translated components (34 files)
└── scripts/
    └── auto-patch.sh       # Auto-reapply on update
```

---

## 🔧 How it works

1. `install.sh` locates the Hermes installation
2. Backs up all 41 files to `.ru-backup-*`
3. Copies full i18n files (en/zh/types always in sync)
4. Copies translated components over the sources
5. Rebuilds the app (`npm run pack`)
6. Installs LaunchAgent for auto-reapply on updates

---

## ✅ Verification

- `tsc --noEmit` → 0 errors
- 694 tests passed (6 known localStorage failures unrelated to translation)
- Russian strings confirmed in the built `app.asar`

---

## 📋 Requirements

- macOS (for the LaunchAgent auto-patcher)
- Hermes Agent v0.19.1+ in a standard location
- Node.js and npm (for building)

---

## 🤝 Contributing

Welcome:
- Translations to other languages
- Bug fixes
- Installer improvements

## 📣 Upstream

PR in the main Hermes repo: [#42705](https://github.com/NousResearch/hermes-agent/pull/42705) · Issue: [#40347](https://github.com/NousResearch/hermes-agent/issues/40347)

---

## 📄 License

MIT License
