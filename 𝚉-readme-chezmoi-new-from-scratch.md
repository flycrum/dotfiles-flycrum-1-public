# Chezmoi Configuration Guide

## What is Chezmoi?

Chezmoi is a tool for managing your dotfiles (personal configuration files like `.gitconfig`, `.zshrc`, etc.) across multiple machines securely. It provides features like:

- **Templates** - Handle small differences between machines
- **Password manager support** - Store secrets securely  
- **File encryption** - Using GPG or age
- **Scripts** - Run commands during apply
- **Version control** - Built on Git

🌐 **Official website:** https://www.chezmoi.io/

## Installation & Setup

### 1. Install Chezmoi

```bash
# Install using the official script
sh -c "$(curl -fsLS get.chezmoi.io)"
```

This installs chezmoi to `~/bin/chezmoi`.

### 2. Add to PATH

```bash
# Add to your shell configuration
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### 3. Initialize Chezmoi

```bash
# Initialize the source directory
chezmoi init
```

This creates your source directory at `~/.local/share/chezmoi` and initializes it as a Git repository.

### 4. Verify Installation

```bash
chezmoi --version
chezmoi source-path  # Should show: /Users/crumbook/.local/share/chezmoi
```

## Basic Usage

### Adding Files to Chezmoi

```bash
# Add existing dotfiles to chezmoi management
chezmoi add ~/.gitconfig
chezmoi add ~/.zshrc
chezmoi add ~/.ssh/config
```

### Editing Managed Files

```bash
# Edit files in the source directory
chezmoi edit ~/.gitconfig

# Apply changes to your home directory
chezmoi apply
```

### Checking Status

```bash
# See what files have changes
chezmoi status

# See differences between source and target
chezmoi diff
```

## Git Integration

### Set up Remote Repository

```bash
cd ~/.local/share/chezmoi
git remote add origin https://github.com/yourusername/dotfiles.git
git add .
git commit -m "Initial commit"
git push -u origin main
```

### Sync Across Machines

```bash
# Pull and apply changes from remote
chezmoi update
```

### Install on New Machine

```bash
# Install chezmoi and your dotfiles in one command
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply yourusername
```

## Useful Commands

| Command | Description |
|---------|-------------|
| `chezmoi add <file>` | Add a file to chezmoi management |
| `chezmoi edit <file>` | Edit a managed file |
| `chezmoi apply` | Apply changes from source to target |
| `chezmoi status` | Show status of managed files |
| `chezmoi diff` | Show differences |
| `chezmoi update` | Pull from git and apply changes |
| `chezmoi doctor` | Check for potential issues |
| `chezmoi cd` | Change to source directory |
| `chezmoi data` | Show template data |

## Advanced Features

### Templates
Use Go templates to handle machine-specific differences:

```bash
# Example .gitconfig.tmpl
[user]
    name = "Your Name"
    email = "{{ .email }}"
```

### Password Managers
Integrate with 1Password, Bitwarden, etc.:

```bash
# Example using 1Password
password = "{{ onepassword "item-id" "field" }}"
```

### Scripts
Run scripts during apply:

```bash
# run_once_install-packages.sh
#!/bin/bash
brew install git vim tmux
```

## Configuration File

Chezmoi can be configured via `~/.config/chezmoi/chezmoi.toml`:

```toml
[data]
    email = "you@example.com"
    
[edit]
    command = "code"
    
[git]
    autoCommit = true
    autoPush = true
```

## Resources

- 📖 **Documentation:** https://www.chezmoi.io/user-guide/
- 🔧 **Quick Start:** https://www.chezmoi.io/quick-start/
- 💻 **GitHub:** https://github.com/twpayne/chezmoi
- 🎯 **Examples:** https://www.chezmoi.io/links/

## Installation Status

✅ **Chezmoi v2.62.6** installed  
✅ **Source directory** initialized at `/Users/crumbook/.local/share/chezmoi`  
✅ **PATH** configured in `~/.zshrc`  
✅ **Git repository** initialized  

Ready to manage your dotfiles! 🎉
