# SSH + iCloud Keychain Sync Setup

## Overview

This setup uses macOS's experimental iCloud Keychain SSH sync feature to share SSH keys across your Apple devices. Set up once, use everywhere.

⚠️ **Note:** This feature is experimental and results may vary across devices.

## Usage on Future Devices

### Expected Workflow (Best Case)

```bash
# Should work immediately if sync is successful
ssh -T git@github.com
git ls-remote git@github.com:flycrum/dotfiles-flycrum.git
```

### More Likely Scenario

```bash
# Key synced but needs activation
ssh-add --apple-use-keychain ~/.ssh/id_ed25519-flycrum
ssh -T git@github.com
git ls-remote git@github.com:flycrum/dotfiles-flycrum.git
```

## Realistic Expectations

- ✅ **Best case (10%):** Works out-of-the-box on new devices
- 🤔 **Likely case (70%):** Key syncs but needs one `ssh-add` command
- 😅 **Fallback (20%):** Generate new SSH key per device (traditional approach)

---

## Initial Setup (Reference)

### 1. Generate SSH Key

```bash
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519-flycrum -C "clcrum@gmail.com"
```

### 2. Add to Apple Keychain for iCloud Sync

```bash
ssh-add --apple-use-keychain ~/.ssh/id_ed25519-flycrum
cat ~/.ssh/id_ed25519-flycrum.pub
# Add new public key to GitHub
```

### 3. Test Connection

```bash
ssh -T git@github.com
```

You should see: "Hi flycrum! You've successfully authenticated..." 
