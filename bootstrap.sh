#!/bin/bash

echo "🚀 [1/3] 開始安裝基礎開發工具..."

# 1. 安裝 Homebrew
if ! command -v brew &> /dev/null; then
    echo "🍺 安裝 Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [[ $(uname -m) == "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    echo "✅ Homebrew 已存在"
fi

# 2. 安裝 NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
if [ ! -d "$NVM_DIR" ]; then
    echo "🟢 安裝 NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
else
    echo "✅ NVM 已存在"
fi

# 確保 ~/.zshrc 存在並包含基礎 NVM 初始化 (支援後續 gemini 指令)
if [ ! -f "$HOME/.zshrc" ]; then
    touch "$HOME/.zshrc"
    echo "📝 已建立 ~/.zshrc"
fi

if ! grep -q "NVM_DIR" "$HOME/.zshrc"; then
    echo "" >> "$HOME/.zshrc"
    echo 'export NVM_DIR="$HOME/.nvm"' >> "$HOME/.zshrc"
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> "$HOME/.zshrc"
    echo "✅ 已將 NVM 初始化加入 ~/.zshrc"
fi

# 為當前工作環境載入 NVM
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# 驗證 NVM 是否可執行
if command -v nvm &> /dev/null; then
    echo "✅ NVM 環境檢查通過"
else
    echo "❌ 錯誤: 無法啟動 NVM，請檢查安裝過程。"
    exit 1
fi

# 3. 安裝 Node.js 與 Gemini CLI
echo "📦 安裝 Node.js (LTS) 與 Gemini CLI..."
nvm install --lts
npm install -g @google/gemini-cli

echo ""
echo "------------------------------------------------"
echo "✅ 第一階段：基礎工具安裝完畢！"
echo ""
echo "🚀 [2/3] 請手動設定 SSH 金鑰："
echo "   1. 執行: ssh-keygen -t ed25519 -C \"linc27595@gmail.com\""
echo "   2. 執行: cat ~/.ssh/id_ed25519.pub"
echo "   3. 將內容新增至 GitHub (Settings -> SSH and GPG keys)"
echo ""
echo "🚀 [3/3] 完成後，請執行以下指令讓 Gemini 接手 (建議在家目錄執行)："
echo ""
echo "   cd ~ && gemini \"請幫我安裝 chezmoi，接著執行 'ssh -T' 辨識我的 GitHub 帳號，最後將該帳號的 'dotfiles' 儲存庫透過 chezmoi init --apply 進行還原。\""
echo "------------------------------------------------"
echo "💡 Gemini 將自動協助您安裝 chezmoi、偵測身份並完成所有環境設定。"
