#!/bin/bash

# Shell tools and dependencies for zsh configuration
set -e

# Function to add steps to the next steps queue
add_next_step() {
    echo "$1" >> "/tmp/chezmoi_next_steps"
}

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

# Fix zsh compinit security warnings
echo "🔧 Fixing zsh completion permissions..."
# Fix common insecure directories that cause zsh warnings
for dir in /usr/local/share/zsh /usr/local/share/zsh/site-functions /opt/homebrew/share/zsh /opt/homebrew/share/zsh/site-functions; do
    if [[ -d "$dir" ]]; then
        chmod -R go-w "$dir" 2>/dev/null || true
        echo "✅ Fixed permissions for $dir"
    fi
done
echo "✅ Zsh completion permissions updated"

# Add to next steps queue
add_next_step "▶️ Start Zinit plugin manager to auto-install on first shell startup"

echo ""
echo "🎉 Shell tools installation complete!"
