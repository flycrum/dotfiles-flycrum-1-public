# Using the CLI for daily commands

## Common Commands

### Happy path

1. `chezmoi add ~/.gitconfig`
2. `chezmoi diff`
3. `chezmoi apply`
4. `git add . && git commit -m "Apply chezmoi changes and update documentation" && git push`

### Adding Files to Management

```bash
# Add a file to public repo
chezmoi add ~/.gitconfig

# Add a file to private repo
chezmoi --source ~/.local/share/chezmoi-private add ~/.ssh/config
```

### Managing Files

```bash
# Edit files in your default editor
chezmoi edit ~/.bashrc
chezmoi-private edit ~/.ssh/config

# See what changes would be made
chezmoi diff
chezmoi-private diff
```

### Applying Changes

```bash
# Apply changes (verbose mode shows exactly what happens)
chezmoi apply -v
chezmoi-private apply -v

# Dry run - see what would happen without making changes
chezmoi apply -n -v
```

### Managing the Repository

```bash
# Go to source directory to commit changes
chezmoi cd
git add .
git commit -m "Update configs"
git push
exit

# Same for private repo
chezmoi --source ~/.local/share/chezmoi-private cd
git add .
git commit -m "Update private configs"
git push
exit
```

### Checking Status

```bash
# See what files are managed and their status
chezmoi status
chezmoi-private status

# See differences between source and target
chezmoi diff
chezmoi-private diff
```

### Merging Conflicts

```bash
# If you have conflicts, use merge tool
chezmoi merge ~/.gitconfig
chezmoi-private merge ~/.ssh/config
```

## Updating

```bash
# Update public dotfiles
chezmoi update

# Update private dotfiles  
chezmoi --source ~/.local/share/chezmoi-private update

# Or create aliases for convenience
alias chezmoi-private="chezmoi --source ~/.local/share/chezmoi-private"
```

## Tips

- Use `-v` (verbose) flag to see exactly what chezmoi is doing
- Use `-n` (dry run) flag to preview changes without applying them
- Combine `-n -v` to see what would happen without doing it
- `chezmoi help` shows all available commands