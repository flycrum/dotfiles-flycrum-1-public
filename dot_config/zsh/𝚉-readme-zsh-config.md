# Zsh Configuration with XDG Base Directory Specification

## Overview

Modern zsh configuration following XDG Base Directory Specification, moving away from scattered dotfiles to organized, standards-compliant structure.

## Why XDG?

**Problems with traditional approach:**
- Cluttered home directory with scattered config files
- Inconsistent config locations across applications
- Hard to distinguish configs from data

**Benefits:**
- All configs in `~/.config/`, cache in `~/.cache/`
- Standards compliance
- Cleaner home directory
- Easier backups

## File Structure

```
~/
├── .zshenv                    # XDG environment variables
├── .zshrc                     # Bridge file (required by zsh)
└── .config/
    ├── zsh/
    │   ├── config.zsh         # Main configuration
    │   └── 𝚉-readme-zsh-config.md
    ├── oh-my-posh/
    │   └── config.json        # Oh My Posh theme
    └── ghostty/
        └── config             # Terminal configuration
└── .cache/zsh/                # History, completion cache
```

## Components

### Zsh Configuration
- XDG-compliant file organization
- Bridge pattern for `~/.zshrc` requirement
- History and completion in `~/.cache/zsh/`

### Oh My Posh Integration
- Custom theme with dark design and teal accents
- Git integration, Node.js detection, exit codes
- Located in `~/.config/oh-my-posh/config.json`

### Font Setup
- MesloLGM Nerd Font for proper icon display
- Configured in Ghostty terminal
- Required for Oh My Posh icons and symbols

## Zsh Loading Order

1. `/etc/zshenv` → `~/.zshenv` (XDG variables)
2. `/etc/zprofile` → `~/.zprofile`
3. `/etc/zshrc` → `~/.zshrc` (bridge file)
4. `~/.config/zsh/config.zsh` (main config)

## Troubleshooting

**XDG variables not set:** Check `~/.zshenv` exists and is readable
**Config not loading:** Verify `~/.zshrc` sources correct file
**Cache issues:** Check `~/.cache/zsh/` permissions
**Oh My Posh issues:** Validate config with `oh-my-posh config validate`
**Font issues:** Restart terminal after font installation

## Zinit Plugin Manager

**Features:**
- XDG-compliant installation in `~/.local/share/zinit/`
- Turbo mode for ultra-fast shell startup
- Auto-installation on first run

**Installed Plugins:**
- `fast-syntax-highlighting` - Real-time syntax highlighting
- `zsh-autosuggestions` - Fish-like autosuggestions
- `zsh-completions` - Additional completion definitions
- `fzf` - Fuzzy finder for files, history, and commands
- `fzf-tab` - Enhanced tab completion with fzf integration
- `wd` (warp directory) - Directory bookmarking system
- `zoxide` - Smart cd replacement with frecency algorithm
- Oh My Zsh snippets: git, sudo, command-not-found

## Key Features

### Fuzzy Finding & Navigation
- **fzf integration:** `Ctrl+R` for history search, `Ctrl+T` for file finder
- **Enhanced tab completion:** fzf-powered completions with previews
- **Smart directory navigation:** 
  - `z partial-name` - Jump to frequently used directories
  - `zi` - Interactive directory picker
  - `cd` - Enhanced with zoxide learning
  - `wd add/remove bookmark` - Explicit directory bookmarks

### History Search
- **Prefix search:** Type command start + arrow keys for filtered history
- **Fuzzy history:** `Ctrl+R` for fzf-powered history search
- **Deduplication:** No duplicate commands in history

### Completion Enhancements
- **Case-insensitive matching:** Type lowercase, match any case
- **Colorized completions:** Directory listings with LS_COLORS
- **Preview windows:** See directory contents during tab completion

## Next Steps

- Customize Oh My Posh theme
- Add more zinit plugins as needed
- Configure additional development tools
- Set up wd bookmarks for frequently used directories 