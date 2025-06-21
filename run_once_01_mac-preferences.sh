#!/bin/bash

# macOS system preferences configuration
set -e

# Function to add steps to the next steps queue
add_next_step() {
    echo "$1" >> "/tmp/chezmoi_next_steps"
}

echo "⚙️ Configuring macOS preferences..."

# Get sudo authentication upfront for later scripts that need it
echo "🔐 Some upcoming packages will require administrator privileges..."
echo "Please enter your password now to avoid interruptions during installation:"
sudo -v

# Keep sudo alive during the entire chezmoi process
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Finder preferences
echo "Configuring Finder..."
# Show hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles -bool true
# Show full path breadcrumbs at bottom of Finder
defaults write com.apple.finder ShowPathbar -bool true
# Show status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true
# Show file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Disable warning when changing file extensions
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo "🖥️  Configuring Dock..."
# Auto-hide Dock
defaults write com.apple.dock autohide -bool true
# Position Dock on left side
defaults write com.apple.dock orientation -string left
# Set Dock tile size
defaults write com.apple.dock tilesize -int 48
# Don't show recent applications in Dock
defaults write com.apple.dock show-recents -bool false
# Minimize windows using scale effect
defaults write com.apple.dock mineffect -string scale

echo "Restarting affected applications..."
# Kill and restart Finder
killall Finder
# Kill and restart Dock
killall Dock

# Add to next steps queue
add_next_step "💻 Some macOS preference changes may require a logout/login to take full effect"

echo "💻 macOS preferences configured successfully!"
