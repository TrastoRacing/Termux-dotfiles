# Chezmoi Dotfiles Management in Termux

Automated configuration management and provisioning workflow powered by [chezmoi](https://www.chezmoi.io/) for Termux environments on Android.

---

## 1. Managed Components

| Category | Path in `$HOME` | Path in Repository | Description |
| :--- | :--- | :--- | :--- |
| **Zsh** | `~/.zshrc` | `private_dot_zshrc` | Shell configuration, plugins, aliases (`bat`, `eza`, `duf`, `nvim`), FZF integration, Zoxide, Mise, and Atuin. |
| **Yazi** | `~/.config/yazi/` | `private_dot_config/private_yazi/` | Asynchronous file manager, Tokyo Night theme, preview renderers, Android clipboard, and Termux open hooks. |
| **Tmux** | `~/.tmux.conf` | `private_dot_tmux.conf` | Terminal multiplexer, session persistence against Android background process termination, and mouse/touch navigation. |
| **Oh My Posh** | `~/.config/oh-my-posh/...` | `private_dot_config/private_oh-my-posh/...` | Self-contained Powerlevel10k Classic prompt theme configuration. |
| **Fastfetch** | `~/.config/fastfetch/` | `private_dot_config/private_fastfetch/` | System information display configuration with automatic OS logo detection. |
| **Neovim / LazyVim** | `~/.config/nvim/` | `private_dot_config/private_nvim/` | LazyVim IDE distribution, plugins (`auto-save`, `diffview`, `emmet`, `markdown-preview`, `markdownlint`, `mason`, `yazi.nvim`), and locks. |
| **Markdownlint** | `~/.markdownlint.json` | `private_dot_markdownlint.json` | Global markdownlint configuration tuned for technical documentation. |
| **Termux UI** | `~/.termux/` and `~/.hushlogin` | `private_dot_termux/` | MesloLGS Nerd Font (`font.ttf`), Tokyo Night Moon color scheme (`colors.properties`), and silent MOTD startup. |
| **CLI Utilities** | `~/.config/` | `private_dot_config/...` | Tokyo Night configurations for Bottom (`btm`), Atuin, Tealdeer (`tldr`), Lazygit, and Htop. |
| **Documentation** | `~/docs/` | `docs/` | Comprehensive technical manuals (`ReadmeTmux.md`, `ReadmeYazi.md`, `ReadmeZsh.md`, `ReadmeNeovim.md`, `ReadmeChezmoi.md`). |
| **Provisioning** | Lifecycle scripts | `run_once_*.sh` | Automated, unattended installer for packages, Node.js LSPs, plugins, and binary tools. |

---

## 2. Zero-Secrets Architecture

This repository strictly enforces a zero-secrets security baseline:

- **Restricted File Attributes:** Configurations maintain restricted permissions (`0600`/`0700`) through chezmoi's `private_` attribute prefixes.
- **Strict Secrets Exclusion:**
  - No SSH private/public keys (`~/.ssh`) or GPG keyrings (`~/.gnupg`).
  - No Git credentials, personal signing keys, or GitHub CLI auth tokens (`~/.config/gh/hosts.yml`).
  - No shell history files (`~/.zsh_history`, `~/.bash_history`).
  - No AI assistant session databases or telemetry tokens (`~/.gemini`, `~/.omp`).
- **Defensive Safeguards:** `.gitignore` and `.chezmoiignore` block accidental tracking of `.env`, `.pem`, `.key`, or files matching credential patterns.

---

## 3. Daily Usage

### Check Workspace Status

Compare your local environment against the tracked repository:

```bash
chezmoi status
chezmoi diff
```

### Save Modifications

After making adjustments to a tracked file (such as `~/.zshrc` or `~/.config/nvim/`):

```bash
# Update all modified tracked files in the chezmoi source directory:
chezmoi re-add

# Or add a specific file:
chezmoi add ~/.zshrc
```

Commit changes within the chezmoi repository:

```bash
chezmoi git -- add -A
chezmoi git -- commit -m "feat(config): update shell settings"
```

### Apply Repository State

To restore or sync configurations back to your `$HOME` directory:

```bash
chezmoi apply
```

---

## 4. Fresh Installation on a New Device

To reproduce the entire setup on a clean Termux installation:

```bash
pkg install -y git chezmoi
chezmoi init --apply TrastoRacing/Termux-dotfiles
```

The lifecycle scripts execute automatically during initialization:

1. `run_once_before_01-install-packages.sh`: Installs native Termux packages and global Node.js language servers.
2. `run_once_after_02-setup-environment.sh`: Configures Zsh as default shell, reloads Termux styling (Nerd Font deployed by chezmoi), clones pinned Zsh plugins, downloads and verifies `bottom` (btm), generates a local Atuin encryption key, and restores LazyVim plugins.
