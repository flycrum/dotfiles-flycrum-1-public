#!/bin/bash

# Foundation script - must succeed for everything else to work
set -e

# Function to add steps to the next steps queue
add_next_step() {
    echo "$1" >> "/tmp/chezmoi_next_steps"
}

echo "🍺 Installing Homebrew (user-specific)..."

# Define user-specific Homebrew paths
USER_HOMEBREW_PREFIX="$HOME/.homebrew"
USER_HOMEBREW_BIN="$USER_HOMEBREW_PREFIX/bin"
USER_HOMEBREW_CELLAR="$USER_HOMEBREW_PREFIX/Cellar"

# Install Homebrew if not already installed in user directory
if ! [ -x "$USER_HOMEBREW_BIN/brew" ]; then
    echo "User-specific Homebrew not found, installing to $USER_HOMEBREW_PREFIX..."
    
    # Create the homebrew directory
    mkdir -p "$USER_HOMEBREW_PREFIX"
    
    # Download and install Homebrew to user directory
    curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C "$USER_HOMEBREW_PREFIX"
    
    echo "✅ Homebrew installed to user directory!"
else
    echo "✅ User-specific Homebrew already installed, skipping..."
fi

# Add user Homebrew to PATH for the current session
export PATH="$USER_HOMEBREW_BIN:$PATH"

# Permanently add to shell profile (.zprofile created by run_once_00_zprofile.sh)
SHELL_PROFILE="$HOME/.zprofile"
BREW_PATH_LINE='export PATH="$HOME/.homebrew/bin:$PATH"'

if ! grep -q '\.homebrew/bin' "$SHELL_PROFILE" 2>/dev/null; then
    echo "Adding user Homebrew to $SHELL_PROFILE for permanent PATH..."
    echo "" >> "$SHELL_PROFILE"
    echo "# Add user-specific Homebrew to PATH" >> "$SHELL_PROFILE"
    echo "$BREW_PATH_LINE" >> "$SHELL_PROFILE"
    echo "✅ Added user Homebrew to shell profile"
    
    # Source the profile immediately so brew is available in this session
    source "$SHELL_PROFILE"
else
    echo "✅ User Homebrew already in shell profile"
fi

# Verify brew is working
if ! "$USER_HOMEBREW_BIN/brew" --version &> /dev/null; then
    echo "❌ Error: User Homebrew installation failed"
    exit 1
fi

# Show isolation info
echo "🏠 Homebrew Isolation Info:"
echo "   📍 Installation: $USER_HOMEBREW_PREFIX"
echo "   👤 User: $(whoami)"
echo "   🆔 User ID: $(id -u)"
echo "   🔒 This installation is completely isolated from other users"

# Add to next steps queue
add_next_step "🔁 Restart terminal for Homebrew PATH changes to take effect"

echo "🍺 User-specific Homebrew setup complete!"
