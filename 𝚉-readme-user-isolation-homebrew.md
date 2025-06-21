# 🏠 User Isolation & Sandboxing Strategy

## The Problem 🚫
When testing chezmoi with multiple users on the same Mac, system-wide Homebrew creates conflicts:
- User ID conflicts cause: `Permission denied @ rb_sysopen`
- Different users step on each other's Homebrew installation

## The Solution 🎯
**User-Specific Homebrew** - Each user installs to `~/.homebrew/` instead of system-wide `/opt/homebrew/`

```bash
# Traditional (BAD): /opt/homebrew/          ← Shared, causes conflicts
# Our approach (GOOD): ~/.homebrew/          ← Per-user, isolated
```

## Benefits 🔒
- Complete separation between users
- Safe testing without affecting primary user
- No permission conflicts possible

## Testing Multi-User 🧪
```bash
# Create test user
sudo dscl . -create /Users/testuser
sudo dscl . -create /Users/testuser UserShell /bin/zsh
sudo dscl . -create /Users/testuser UniqueID 503
sudo dscl . -create /Users/testuser PrimaryGroupID 20
sudo dscl . -create /Users/testuser NFSHomeDirectory /Users/testuser
sudo createhomedir -c -u testuser

# Test as new user
sudo su - testuser
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply flycrum/dotfiles-flycrum-1-public
```

## Cleanup 🧹
```bash
sudo dscl . -delete /Users/testuser && sudo rm -rf /Users/testuser
```

## Verification 🔍
```bash
which brew        # Should show ~/.homebrew/bin/brew
brew --prefix     # Should show /Users/username/.homebrew
```

Each user gets their own isolated Homebrew installation! 🎉 