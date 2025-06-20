# Install Chezmoi and apply initial public configs

## Pull down and apply public repo

```bash
# Install chezmoi and apply public dotfiles in one command
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply flycrum/dotfiles-flycrum-1-public
```

That's it! No SSH setup, no authentication - just works on any fresh machine.

## Next up: the private repo

[Install private `flycrum/dotfiles-flycrum-2-private`](./𝚉-readme-chezmoi-2-install-existing-private.md)

## Two-Repo strategy

[`flycrum/dotfiles-flycrum-1-public`](./𝚉-readme-chezmoi-dotfiles-flycrum-1-public.md)
[`flycrum/dotfiles-flycrum-2-private`](./𝚉-readme-chezmoi-dotfiles-flycrum-2-private.md)