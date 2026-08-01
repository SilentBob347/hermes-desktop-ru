<p align="center">
  <img src="https://img.shields.io/badge/Hermes_Desktop-Russian_locale_v2-FFD700?style=for-the-badge&labelColor=1a1a2e" alt="Hermes Desktop Russian Locale v2" width="100%">
</p>

<h1 align="center">🇷🇺 Hermes Desktop — 俄语翻译 (v2)</h1>

<p align="center">
  <a href="https://github.com/NousResearch/hermes-agent"><img src="https://img.shields.io/badge/Hermes_Agent-Official_Repo-FFD700?style=for-the-badge&logo=github" alt="Hermes Agent"></a>
  <a href="https://github.com/warment/hermes-desktop-ru/releases"><img src="https://img.shields.io/github/v/release/warment/hermes-desktop-ru?style=for-the-badge&color=green" alt="Release"></a>
</p>

<p align="center">
  <b>Hermes Agent 桌面应用的完整俄语本地化 — 约 99% 的界面文本。</b><br>
  [<a href="README.md">Русский</a>] · [<a href="README.en.md">English</a>] · [<b>中文</b>]
</p>

---

## ⚡ 快速安装

```bash
git clone https://github.com/warment/hermes-desktop-ru.git
cd hermes-desktop-ru
./install.sh
```

或单条命令：

```bash
curl -sSL https://raw.githubusercontent.com/warment/hermes-desktop-ru/main/install.sh | bash
```

> ⚠️ 需要 Hermes Agent **v0.19.1** (2026-07-30) 或更新版本 — 脚本会将完整的翻译文件覆盖到源码上。

安装后：**设置** → **外观** → **Русский**

---

## ✨ 翻译内容 (v2)

- **全部 38 个 i18n 区块**（`ru.ts` 约 3000 行）：菜单、设置、账单、通知、快捷键、覆盖窗口、启动、安装、引导、状态栏等
- **设置字段**（`ru-constants.ts`）：所有标签和描述
- **组件硬编码字符串**（41 个文件）：
  - 账单：验证页面、套餐、自动充值、测试数据
  - 应用卸载（危险区）、Computer Use（权限、驱动健康）
  - MoA 预设、自定义端点、主题搜索、生成参考图
  - Quick Entry 窗口和宠物覆盖层（独立渲染窗口）
  - 表情选择器、会话时间线、星空图（图例/技能/记忆）
  - Show options / More actions 按钮、OAuth / API key、个人资料、嵌入

有意不翻译：URL 示例、服务商品牌名、配置文件（config.yaml、SOUL.md）。

---

## 🛡️ 自动更新

Hermes 更新后，俄语翻译通过 macOS LaunchAgent **自动重新应用**，脚本会监控源文件。

---

## 🗑️ 卸载

```bash
./uninstall.sh
```

从备份恢复全部 41 个原始文件并移除翻译。

---

## 📁 结构

```
hermes-desktop-ru/
├── install.sh              # 安装器 (v2)
├── uninstall.sh            # 卸载器
├── README.md               # 文档 (RU/EN/ZH)
├── patches/
│   ├── i18n/               # 完整 i18n 文件 (ru, en, zh, types, catalog, languages)
│   ├── ru-constants.ts     # 俄语设置字段标签
│   └── src/                # 已翻译的组件 (34 个文件)
└── scripts/
    └── auto-patch.sh       # 更新后自动重新应用
```

---

## 🔧 工作原理

1. `install.sh` 查找 Hermes 安装位置
2. 备份全部 41 个文件到 `.ru-backup-*`
3. 复制完整的 i18n 文件（en/zh/types 始终同步）
4. 将翻译后的组件覆盖到源码
5. 重新构建应用（`npm run pack`）
6. 安装 LaunchAgent 以便更新后自动重新应用

---

## ✅ 验证

- `tsc --noEmit` → 0 错误
- 694 个测试通过（6 个已知的 localStorage 失败与翻译无关）
- 俄语字符串已在构建的 `app.asar` 中确认

---

## 📋 要求

- macOS（用于 LaunchAgent 自动修补）
- 标准位置的 Hermes Agent v0.19.1+
- Node.js 和 npm（用于构建）

---

## 📣 上游

主仓库中的 PR：[#42705](https://github.com/NousResearch/hermes-agent/pull/42705) · Issue：[#40347](https://github.com/NousResearch/hermes-agent/issues/40347)

---

## 📄 许可证

MIT License
