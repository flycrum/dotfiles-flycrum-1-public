# Chezmoi Setup on New Machine

## Two-Repo strategy

**Contains non-sensitive configs:**
- Basic shell configuration (`.zshrc`, `.bashrc`)
- Git configuration (name/email, aliases)
- SSH configuration templates
- Development tools setup
- Editor configurations
- Terminal preferences
- Bootstrap scripts for private repo setup

### Public repo

> `dotfiles-flycrum-1-public`

**Contains non-sensitive configs:**
- Basic shell configuration (`.zshrc`, `.bashrc`)
- Git configuration (name/email, aliases)
- SSH configuration templates
- Development tools setup
- Editor configurations
- Terminal preferences
- Bootstrap scripts for private repo setup

### Private repo

>[`dotfiles-flycrum-2-private`](./𝚉-readme-chezmoi-dotfiles-flycrum-2-private.md)


## Benefits of This Approach

✅ **No authentication complexity** on fresh machines  
✅ **True magic one-liner** for initial setup  
✅ **Clean separation** of public vs. sensitive configs  
✅ **Public repo enables** private repo setup  
✅ **No chicken-and-egg** SSH configuration problems  
