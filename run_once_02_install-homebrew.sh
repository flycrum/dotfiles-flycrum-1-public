#!/bin/bash

# Foundation script - must succeed for everything else to work
set -e

# Function to add steps to the next steps queue
add_next_step() {
    echo "$1" >> "/tmp/chezmoi_next_steps"
}

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
        BREW_PREFIX="/opt/homebrew"
    else
        # Intel Mac
        echo "Adding Homebrew to PATH (Intel)..."
        eval "$(/usr/local/bin/brew shellenv)"
        BREW_PREFIX="/usr/local"
    fi
    
    # Permanently add to shell profile (.zprofile created by run_once_00_zprofile.sh)
    SHELL_PROFILE="$HOME/.zprofile"
    BREW_SHELLENV_LINE='eval "$('$BREW_PREFIX'/bin/brew shellenv)"'
    
    if ! grep -q "$BREW_PREFIX/bin/brew shellenv" "$SHELL_PROFILE" 2>/dev/null; then
        echo "Adding Homebrew to $SHELL_PROFILE for permanent PATH..."
        echo "" >> "$SHELL_PROFILE"
        echo "# Add Homebrew to PATH" >> "$SHELL_PROFILE"
        echo "$BREW_SHELLENV_LINE" >> "$SHELL_PROFILE"
        echo "✅ Added Homebrew to shell profile"
        
        # Source the profile immediately so brew is available in this session
        source "$SHELL_PROFILE"
    else
        echo "✅ Homebrew already in shell profile"
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

# Add to next steps queue
add_next_step "🔁 Restart terminal for Homebrew PATH changes to take effect"

echo "🍺 Homebrew setup complete!"
