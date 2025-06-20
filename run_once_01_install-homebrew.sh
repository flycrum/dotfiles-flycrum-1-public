#!/bin/bash

# Foundation script - must succeed for everything else to work
set -e

echo "🍺 Installing Homebrew..."

# Install Homebrew if not already installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found, installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for the current session
    if [[ $(uname -m) == "arm64" ]]; then
        # Apple Silicon Mac
        echo "Adding Homebrew to PATH (Apple Silicon)..."
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        # Intel Mac
        echo "Adding Homebrew to PATH (Intel)..."
        eval "$(/usr/local/bin/brew shellenv)"
    fi
    
    echo "✅ Homebrew installed successfully!"
else
    echo "✅ Homebrew already installed, skipping..."
fi

# Verify brew is working
if ! brew --version &> /dev/null; then
    echo "❌ Error: Homebrew installation failed"
    exit 1
fi

echo "🎉 Homebrew setup complete!"
