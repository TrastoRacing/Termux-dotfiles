#!/data/data/com.termux/files/usr/bin/bash
# =============================================================================
# chezmoi: run_once_before_01-install-packages.sh
# Installs native Termux packages (pkg) and global Node.js LSPs/linters (npm -g).
# =============================================================================
set -euo pipefail

if ! command -v pkg >/dev/null 2>&1; then
    echo "[chezmoi] Termux environment not detected (pkg missing). Skipping package installation."
    exit 0
fi

TERMUX_PKGS=(
    zsh
    oh-my-posh
    fastfetch
    neovim
    git
    gh
    lazygit
    git-delta
    yazi
    7zip
    poppler
    ffmpegthumbnailer
    chafa
    tealdeer
    mise
    atuin
    bat
    eza
    fzf
    fd
    ripgrep
    zoxide
    duf
    dust
    ncdu
    htop
    tmux
    jq
    yq
    curlie
    curl
    wget
    rsync
    rclone
    openssh
    termux-api
    termux-tools
    termux-am
    clang
    make
    cmake
    pkg-config
    python
    nodejs-lts
    bun
    tree-sitter
    stylua
    shfmt
    shellcheck
    marksman
    unzip
    tar
    gzip
    xz-utils
    zstd
)

MISSING_PKGS=()
for p in "${TERMUX_PKGS[@]}"; do
    if ! dpkg -s "$p" >/dev/null 2>&1; then
        MISSING_PKGS+=("$p")
    fi
done

if (( ${#MISSING_PKGS[@]} > 0 )); then
    echo "[chezmoi] Installing missing Termux packages: ${MISSING_PKGS[*]}"
    pkg update -y
    pkg install -y "${MISSING_PKGS[@]}"
else
    echo "[chezmoi] All required Termux packages are already installed."
fi

# Global NPM packages (LSPs, formatters, and linters for LazyVim)
# Pinned to tested stable versions for deterministic supply-chain security
if command -v npm >/dev/null 2>&1; then
    declare -A NPM_BINS=(
        ["@angular/language-server@22.2.3"]="ngserver"
        ["@ansible/ansible-language-server@26.6.0"]="ansible-language-server"
        ["@astrojs/language-server@2.17.2"]="astro-ls"
        ["@olrtg/emmet-language-server@2.8.0"]="emmet-language-server"
        ["@vtsls/language-server@0.3.0"]="vtsls"
        ["dockerfile-language-server-nodejs@0.15.0"]="docker-langserver"
        ["markdown-toc@1.2.0"]="markdown-toc"
        ["markdownlint-cli2@0.23.3"]="markdownlint-cli2"
        ["prettier@3.9.10"]="prettier"
        ["pyright@1.1.414"]="pyright"
        ["typescript@7.0.2"]="tsc"
        ["vscode-langservers-extracted@4.10.0"]="vscode-html-language-server"
        ["yaml-language-server@1.25.0"]="yaml-language-server"
    )

    MISSING_NPM=()
    for pkg_name in "${!NPM_BINS[@]}"; do
        bin_name="${NPM_BINS[$pkg_name]}"
        if ! command -v "$bin_name" >/dev/null 2>&1; then
            MISSING_NPM+=("$pkg_name")
        fi
    done

    if (( ${#MISSING_NPM[@]} > 0 )); then
        echo "[chezmoi] Installing missing global NPM tools: ${MISSING_NPM[*]}"
        npm install -g "${MISSING_NPM[@]}"
    else
        echo "[chezmoi] All global NPM tools and language servers are already installed."
    fi
fi
