# Install Chezmoi and apply private config, setttings, etc

## Pull down and apply private repo

Make sure we have our SSH keys set up and registered on Github

```bash
# Initialize private repo in separate source directory
chezmoi --source ~/.local/share/chezmoi-private init git@github.com:flycrum/dotfiles-flycrum-2-private.git
chezmoi --source ~/.local/share/chezmoi-private apply
```

## Two-Repo strategy

[`flycrum/dotfiles-flycrum-1-public`](./𝚉-readme-chezmoi-dotfiles-flycrum-1-public.md)
[`flycrum/dotfiles-flycrum-2-private`](./𝚉-readme-chezmoi-dotfiles-flycrum-2-private.md)