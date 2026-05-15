# macOS Bootstrap (引導儲存庫)

一鍵建置基礎環境，並透過 AI (Gemini CLI) 完成自動化還原。

## 🚀 快速開始

### 1. 基礎打底
開啟 macOS `Terminal.app`，直接貼上以下指令：

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ClaudeLin/bootstrap-mac/main/bootstrap.sh)"
```

### 2. 設定 SSH
根據終端機提示，產生 SSH 金鑰並新增至您的 GitHub 帳號。

### 3. AI 接管
當 SSH 連線就緒後，請執行以下指令進行全自動還原：

```sh
cd ~ && gemini "請幫我安裝 chezmoi，接著執行 'ssh -T' 辨識我的 GitHub 帳號，最後將該帳號的 'dotfiles' 儲存庫透過 chezmoi init --apply 進行還原。"
```

---

## 🎯 說明
- 本工具僅安裝基礎環境 (Homebrew, NVM, Node.js, Gemini CLI)。
- 所有的個人化設定均保留在私有儲存庫中，由 Gemini 自動偵測並還原。
