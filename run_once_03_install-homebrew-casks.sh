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

# Function to install casks with error handling
install_cask() {
    local package="$1"
    
    echo "Installing $package..."
    if brew install --cask "$package" 2>/dev/null; then
        echo "✅ Successfully installed $package to $USER_APPLICATIONS_DIR"
    else
        echo "⚠️ Failed to install $package (continuing...)"
        return 1
    fi
}

# Install packages
echo "📦 Installing packages..."

# Install nvm the proper way (not via Homebrew)
echo "Installing nvm..."
if curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash; then
    echo "✅ Successfully installed nvm"
    # Source nvm immediately for this session
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
else
    echo "⚠️ Failed to install nvm (continuing...)"
fi

# Install Karabiner-Elements
if install_cask "karabiner-elements"; then
    echo "Installing Karabiner-Elements..."
    echo "❗IMPORTANT: Karabiner-Elements Security Setup"
    echo "1. Go to System Settings > Privacy & Security > Input Monitoring"
    echo "2. Enable 'karabiner_grabber' and 'karabiner_observer'"
    echo "3. Then manually open Karabiner-Elements from Applications"
    echo ""
    add_next_step "🔒 Grant Karabiner-Elements Input Monitoring permissions in System Settings"
    add_next_step "⌨️ Open Karabiner-Elements to configure your keybindings"
else
    add_next_step "⚠️ Install Karabiner-Elements manually if needed"
fi

# Install Kitty terminal emulator
echo "Installing Kitty..."
install_cask "kitty"

echo ""
echo "🪣 Essential tools installation complete!"