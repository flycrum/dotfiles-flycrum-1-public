# Chezmoi Setup on New Machine

## Two-Repo strategy

### Public repo

> [`dotfiles-flycrum-1-public`](./𝚉-readme-chezmoi-dotfiles-flycrum-1-public.md)

### Private repo

> `dotfiles-flycrum-2-private`

**Contains sensitive configs:**
- API keys and tokens
- Work-specific configurations
- Private scripts and aliases
- Sensitive environment variables
- Company-specific dotfiles

## Benefits of This Approach

✅ **No authentication complexity** on fresh machines  
✅ **True magic one-liner** for initial setup  
✅ **Clean separation** of public vs. sensitive configs  
✅ **Public repo enables** private repo setup  
✅ **No chicken-and-egg** SSH configuration problems  
