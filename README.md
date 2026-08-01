<p align="center">
  <img src="https://img.shields.io/badge/Hermes_Desktop-Russian_locale_v2-FFD700?style=for-the-badge&labelColor=1a1a2e" alt="Hermes Desktop Russian Locale v2" width="100%">
</p>

<h1 align="center">🇷🇺 Hermes Desktop — Русский язык (v2)</h1>

<p align="center">
  <a href="https://github.com/NousResearch/hermes-agent"><img src="https://img.shields.io/badge/Hermes_Agent-Official_Repo-FFD700?style=for-the-badge&logo=github" alt="Hermes Agent"></a>
  <a href="https://github.com/warment/hermes-desktop-ru/releases"><img src="https://img.shields.io/github/v/release/warment/hermes-desktop-ru?style=for-the-badge&color=green" alt="Release"></a>
  <a href="https://github.com/warment/hermes-desktop-ru/blob/main/LICENSE"><img src="https://img.shields.io/badge/License-MIT-green?style=for-the-badge" alt="License: MIT"></a>
  <a href="https://discord.gg/NousResearch"><img src="https://img.shields.io/badge/Discord-5865F2?style=for-the-badge&logo=discord&logoColor=white" alt="Discord"></a>
</p>

<p align="center">
  <b>Полная русификация десктопного приложения Hermes Agent — ~99% всех строк интерфейса.</b><br>
  [<b>Русский</b>] · [<a href="README.en.md">English</a>] · [<a href="README.zh.md">中文</a>]
</p>

---

## ⚡ Быстрая установка

```bash
git clone https://github.com/warment/hermes-desktop-ru.git
cd hermes-desktop-ru
./install.sh
```

Или одной командой:

```bash
curl -sSL https://raw.githubusercontent.com/warment/hermes-desktop-ru/main/install.sh | bash
```

> ⚠️ Требуется Hermes Agent **v0.19.1** (2026-07-30) или новее — скрипт подставляет полные файлы перевода поверх исходников.

После установки: **Settings** → **Appearance** → **Русский**

---

## ✨ Что переведено (v2)

- **Все 38 секций i18n** (~3000 строк `ru.ts`): меню, настройки, биллинг, уведомления, горячие клавиши, мастер-оверлеи, загрузка, установка, онбординг, статус-бар и др.
- **Поля настроек** (`ru-constants.ts`): все названия и описания
- **Hardcoded-строки компонентов** (41 файл):
  - Биллинг: страница проверки, планы, автопополнение кредитов, фикстуры
  - Удаление приложения (Danger zone), Computer Use (разрешения, driver health)
  - MoA-пресеты, пользовательские эндпоинты, поиск тем, референсы генерации
  - Окно Quick Entry и пет-оверлей (отдельные renderer-окна)
  - Эмодзи-пикер, таймлайны сессий, star map (легенда/навык/память)
  - Кнопки Show options / More actions, OAuth / API key, профили, вложения

Сознательно не переведены: URL-примеры, имена провайдеров, файлы-конфиги (config.yaml, SOUL.md).

---

## 🛡️ Автоматическое обновление

При обновлении Hermes русский перевод **автоматически пере-применяется** через macOS LaunchAgent. Скрипт следит за файлами Hermes и при обновлении снова применяет файлы перевода.

---

## 🗑️ Удаление

```bash
./uninstall.sh
```

Восстановит оригинальные файлы из бэкапа (все 41) и удалит русский перевод.

---

## 📁 Структура

```
hermes-desktop-ru/
├── install.sh              # Установщик (v2)
├── uninstall.sh            # Удаление
├── README.md               # Документация (RU/EN/ZH)
├── patches/
│   ├── i18n/               # Полные i18n-файлы (ru, en, zh, types, catalog, languages)
│   ├── ru-constants.ts     # Русские названия полей настроек
│   └── src/                # Переведённые компоненты (34 файла)
└── scripts/
    └── auto-patch.sh       # Auto-reapply при обновлении
```

---

## 🔧 Как это работает

1. `install.sh` находит установку Hermes в стандартных расположениях
2. Создаёт бэкап всех 41 файла в `.ru-backup-*`
3. Копирует i18n-файлы (полные версии, включая en/zh/types — типы всегда согласованы)
4. Копирует переведённые компоненты поверх исходников
5. Пересобирает приложение (`npm run pack`)
6. Устанавливает LaunchAgent для auto-reapply при обновлении

---

## ✅ Проверки

- `tsc --noEmit` → 0 ошибок
- 694 теста passed (6 известных фейлов localStorage, не связаны с переводом)
- Русские строки подтверждены в собранном `app.asar`

---

## 📋 Требования

- macOS (для LaunchAgent auto-patcher)
- Hermes Agent v0.19.1+ в одном из стандартных расположений
- Node.js и npm (для сборки)

---

## 🤝 Вклад

Приветствуются:
- Переводы на другие языки
- Исправления ошибок
- Улучшения скрипта установки

## 📣 Официальное обсуждение

PR в основном репозитории Hermes: [#42705](https://github.com/NousResearch/hermes-agent/pull/42705) · Issue: [#40347](https://github.com/NousResearch/hermes-agent/issues/40347)

---

## 📄 Лицензия

MIT License

---

<p align="center">
  <sub>Built with ❤️ for the <a href="https://github.com/NousResearch/hermes-agent">Hermes Agent</a> community</sub>
</p>
