#!/bin/bash

echo "🔧 Installing essential tools..."

# Ensure Homebrew is in PATH
if [[ $(uname -m) == "arm64" ]]; then
    # Apple Silicon Mac
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    # Intel Mac
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

# Install packages
echo "📦 Installing packages..."

install_package "nvm" "formula"
install_package "karabiner-elements" "cask"

echo ""
echo "🎉 Essential tools installation complete!"
echo ""
echo "📝 Next steps:"
echo "   • Restart terminal to use nvm"
echo "   • Open Karabiner-Elements to configure keyboard" 