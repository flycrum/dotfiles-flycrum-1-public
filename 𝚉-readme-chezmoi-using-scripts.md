# How to configure scripts to run

## What are Chezmoi Scripts?

Scripts are executable files in your chezmoi source directory that run automatically when you `chezmoi apply`. They're perfect for automating software installation, system configuration, and setup tasks.

## Script Types

**`run_` scripts** - Execute every time you run `chezmoi apply`
```bash
run_setup-something.sh        # Runs every time
```

**`run_once_` scripts** - Execute only once per unique content (perfect for installations)
```bash
run_once_01_install-homebrew.sh    # Runs once, numbered for order
run_once_02_install-packages.sh    # Runs after script 01
```

**`run_onchange_` scripts** - Execute only when script content changes
```bash
run_onchange_configure-git.sh      # Only when you update the script
```

## How to Use

1. **Create scripts** in your chezmoi source directory (`~/.local/share/chezmoi/`)
2. **Use numbering** for execution order (01, 02, 03...)
3. **Make them idempotent** - safe to run multiple times
4. **Include shebang** line (`#!/bin/bash`)

## Example Structure

```
~/.local/share/chezmoi/
├── run_once_01_install-homebrew.sh     # Foundation
├── run_once_02_install-packages.sh     # Apps via brew
├── run_once_10_configure-git.sh        # Configuration
└── run_onchange_update-settings.sh     # When settings change
```

## Pro Tips

- Scripts run in **alphabetical order**
- Use `before_` or `after_` prefixes to control timing
- Add `.tmpl` suffix for template variables
- Scripts should be **idempotent** (safe to run repeatedly)

## Resources

📖 **Official Documentation:** [chezmoi.io/user-guide/use-scripts-to-perform-actions](https://www.chezmoi.io/user-guide/use-scripts-to-perform-actions/) 