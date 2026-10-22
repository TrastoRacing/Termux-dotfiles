#!/data/data/com.termux/files/usr/bin/bash
# =============================================================================
# chezmoi: run_once_after_02-setup-environment.sh
# Configures default shell, reloads Termux styling, initializes plugins and tools.
# =============================================================================
set -euo pipefail

# 1. Set Zsh as default shell in Termux
if [[ -x "$PREFIX/bin/zsh" ]]; then
    mkdir -p "$HOME/.termux"
    if [[ ! -L "$HOME/.termux/shell" ]] || [[ "$(readlink "$HOME/.termux/shell")" != "$PREFIX/bin/zsh" ]]; then
        ln -sf "$PREFIX/bin/zsh" "$HOME/.termux/shell"
        echo "[chezmoi] Default shell set to Zsh."
    fi
fi

# 2. Reload Termux font and properties
if command -v termux-reload-settings >/dev/null 2>&1; then
    termux-reload-settings || true
    echo "[chezmoi] Termux settings and fonts reloaded."
fi

# 3. Synchronize documentation to Android shared storage if accessible
SHARED_DOCS="/storage/emulated/0/Documents"
if [[ -d "$SHARED_DOCS" ]] && [[ -w "$SHARED_DOCS" ]]; then
    for doc in ReadmeNeovim.md ReadmeZsh.md ReadmeChezmoi.md ReadmeYazi.md ReadmeTmux.md; do
        if [[ -f "$HOME/docs/$doc" ]] && [[ ! -f "$SHARED_DOCS/$doc" ]]; then
            cp "$HOME/docs/$doc" "$SHARED_DOCS/$doc"
            echo "[chezmoi] Copied $doc to $SHARED_DOCS/"
        fi
    done
fi

# 4. Initialize and restore Neovim / LazyVim plugins on clean install
if command -v nvim >/dev/null 2>&1; then
    if [[ ! -d "$HOME/.local/share/nvim/lazy/LazyVim" ]]; then
        echo "[chezmoi] Initializing Neovim and LazyVim plugins..."
        nvim --headless "+Lazy! restore" +qa || true
    else
        echo "[chezmoi] Neovim plugins already initialized."
    fi
fi

# 5. Clone essential Zsh plugins pinned to release tags
ZSH_PLUGINS_DIR="$HOME/.zsh/plugins"
mkdir -p "$ZSH_PLUGINS_DIR"
if [[ ! -d "$ZSH_PLUGINS_DIR/zsh-autosuggestions" ]]; then
    echo "[chezmoi] Cloning zsh-autosuggestions (tag v0.7.1)..."
    git clone --depth 1 --branch v0.7.1 https://github.com/zsh-users/zsh-autosuggestions "$ZSH_PLUGINS_DIR/zsh-autosuggestions"
fi
if [[ ! -d "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting" ]]; then
    echo "[chezmoi] Cloning zsh-syntax-highlighting (tag 0.8.0)..."
    git clone --depth 1 --branch 0.8.0 https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting"
fi

# 6. Initialize Tealdeer (tldr) offline database cache
if command -v tldr >/dev/null 2>&1 && [[ ! -d "$HOME/.cache/tealdeer" ]]; then
    echo "[chezmoi] Updating Tealdeer (tldr) offline cache..."
    tldr --update || true
fi

# 7. Install bottom (btm) official Android aarch64 binary (pinned with SHA-256 integrity check)
if [[ ! -x "$HOME/.local/bin/btm" ]]; then
    BTM_VERSION="0.14.9"
    BTM_SHA256="ab0962167505b8a56d7852952e17f1afeeb83f79ca21b5509ff0ba98c6ac4da1"
    BTM_URL="https://github.com/ClementTsang/bottom/releases/download/${BTM_VERSION}/bottom_aarch64-linux-android.tar.gz"
    TMP_DIR="${TMPDIR:-/data/data/com.termux/files/usr/tmp}"
    BTM_ARCHIVE="$TMP_DIR/bottom-${BTM_VERSION}.tar.gz"

    echo "[chezmoi] Downloading bottom (btm) v${BTM_VERSION} for Android aarch64..."
    mkdir -p "$HOME/.local/bin" "$TMP_DIR"
    if curl -fsSL "$BTM_URL" -o "$BTM_ARCHIVE"; then
        echo "${BTM_SHA256}  ${BTM_ARCHIVE}" | sha256sum -c - || {
            echo "[chezmoi] Error: Checksum verification failed for bottom (btm). Aborting installation." >&2
            rm -f "$BTM_ARCHIVE"
            exit 1
        }
        tar -xzf "$BTM_ARCHIVE" -C "$HOME/.local/bin" btm
        chmod +x "$HOME/.local/bin/btm"
        rm -f "$BTM_ARCHIVE"
        echo "[chezmoi] bottom (btm) v${BTM_VERSION} verified and installed to ~/.local/bin/btm."
    else
        echo "[chezmoi] Warning: Failed to download bottom (btm). Install manually if needed."
    fi
fi

# 8. Ensure local cryptographic key for Atuin exists (skips if legacy layout exists)
if command -v atuin >/dev/null 2>&1 && [[ ! -f "$HOME/.atuin/data/key" ]] && [[ ! -d "$HOME/.local/share/atuin" ]]; then
    mkdir -p "$HOME/.atuin/data"
    openssl rand -base64 32 > "$HOME/.atuin/data/key"
    chmod 600 "$HOME/.atuin/data/key"
    echo "[chezmoi] Generated local encryption key for Atuin."
fi
