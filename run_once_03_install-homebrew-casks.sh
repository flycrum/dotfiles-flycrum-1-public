#!/bin/bash

# Function to add steps to the next steps queue
add_next_step() {
    echo "$1" >> "/tmp/chezmoi_next_steps"
}

echo "🔧 Installing essential tools..."

# Ensure user-specific Homebrew is in PATH
USER_HOMEBREW_BIN="$HOME/.homebrew/bin"
export PATH="$USER_HOMEBREW_BIN:$PATH"

# Set user Applications directory (Homebrew configured to use this automatically)
USER_APPLICATIONS_DIR="$HOME/Applications"

# Check that user Homebrew is available
if ! [ -x "$USER_HOMEBREW_BIN/brew" ]; then
    echo "❌ Error: User-specific Homebrew not found at $USER_HOMEBREW_BIN"
    echo "Please run the Homebrew installation script first (run_once_02_install-homebrew.sh)"
    exit 1
fi

# Function to install with error handling
install_package() {
    local package="$1"
    local type="$2"  # "formula" or "cask"
    
    echo "Installing $package..."
    if [[ $type == "cask" ]]; then
        # Install casks (automatically goes to user's Applications directory via HOMEBREW_CASK_OPTS)
        if brew install --cask "$package" 2>/dev/null; then
            echo "Successfully installed $package to $USER_APPLICATIONS_DIR"
        else
            echo "⚠️ Failed to install $package (continuing...)"
        fi
    else
        if brew install "$package" 2>/dev/null; then
            echo "Successfully installed $package"
        else
            echo "⚠️ Failed to install $package (continuing...)"
        fi
    fi
}

# Install packages
echo "📦 Installing packages..."

install_package "nvm" "formula"
install_package "karabiner-elements" "cask"

# Auto-open Karabiner-Elements from user Applications directory
echo "🚀 Opening Karabiner-Elements so config changes take effect and our keybinding are immediately available..."
open -a "$USER_APPLICATIONS_DIR/Karabiner-Elements.app" 2>/dev/null || echo "⚠️  Could not auto-open Karabiner-Elements"

# Add to next steps queue
add_next_step "⌨️ Open Karabiner-Elements to have your keybindings take immediate effect"

echo ""
echo "🪣 Homebrew Casks installation complete!"