#!/bin/bash

# macOS system preferences configuration
set -e

echo "⚙️  Configuring macOS preferences..."

# Finder preferences
echo "📁 Configuring Finder..."
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

echo "🔄 Restarting affected applications..."
# Kill and restart Finder
killall Finder
# Kill and restart Dock
killall Dock

echo "✅ macOS preferences configured successfully!"
echo "📝 Note: Some changes may require a logout/login to take full effect"
