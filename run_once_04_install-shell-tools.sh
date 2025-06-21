#!/bin/bash

# Shell tools and dependencies for zsh configuration
set -e

echo "🐚 Installing shell tools and dependencies..."

# Ensure Homebrew is in PATH
if [[ $(uname -m) == "arm64" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
fi

# Check that Homebrew is available
if ! command -v brew &> /dev/null; then
    echo "❌ Error: Homebrew not found. Please run install-homebrew.sh first"
    exit 1
fi

# Function to install with error handling
install_package() {
    local package="$1"
    local type="$2"  # "formula" or "cask"
    
    echo "Installing $package..."
    if [[ $type == "cask" ]]; then
        if brew install --cask "$package" 2>/dev/null; then
            echo "✅ Successfully installed $package"
        else
            echo "⚠️  Failed to install $package (continuing...)"
        fi
    else
        if brew install "$package" 2>/dev/null; then
            echo "✅ Successfully installed $package"
        else
            echo "⚠️  Failed to install $package (continuing...)"
        fi
    fi
}

# Install shell tools
echo "🔧 Installing shell enhancement tools..."
install_package "oh-my-posh" "formula"
install_package "fzf" "formula"
install_package "zoxide" "formula"

echo "🔤 Installing required font..."
install_package "font-meslo-lg-nerd-font" "cask"

echo ""
echo "🎉 Shell tools installation complete!"
echo ""
echo "📝 Next steps:"
echo "   • Restart terminal for changes to take effect"
echo "   • Zinit plugin manager will auto-install on first shell startup"
echo "   • Your Oh My Posh themes are ready to use"
