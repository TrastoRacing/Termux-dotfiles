# Zsh Terminal Environment in Termux

Modern interactive shell stack built on Zsh, Oh My Posh, Rust CLI utilities, and Tokyo Night theming.

---

## 1. Stack Overview

- **Interactive Shell:** Zsh with optimized history, directory hashing, and completion systems.
- **Prompt:** Oh My Posh running a self-contained Powerlevel10k Classic theme.
- **Color Palette:** Tokyo Night Moon matching Neovim, Tmux, Lazygit, and terminal borders.
- **Config Path:** `~/.zshrc`.

---

## 2. Command and Shortcut Reference

| Shortcut / Command | Tool | Purpose | Usage Example |
| :--- | :--- | :--- | :--- |
| `Ctrl + R` | **fzf** | Interactive command history search. | Type query, press `Enter` to execute. |
| `Ctrl + T` | **fzf + fd + bat** | Fuzzy find files and insert path into prompt with syntax-highlighted preview. | `nvim` + `Ctrl + T` -> select file -> `Enter`. |
| `Alt + C` | **fzf + fd + eza** | Fuzzy find directories and `cd` immediately with tree preview. | `Alt + C` -> select folder -> `Enter`. |
| `**<TAB>` | **fzf + fd** | Fuzzy completion trigger for commands and paths. | `vim **<TAB>` or `cd **<TAB>`. |
| `z <query>` | **zoxide** | Jump to any frequent/recent directory by keyword. | `z down` -> jumps to `/storage/emulated/0/Download`. |
| `zi` | **zoxide + fzf** | Interactive menu to select and jump to tracked directories. | `zi` -> filter with arrows -> `Enter`. |
| `ls` | **eza** | List files with icons and directories grouped first. | `ls` |
| `ll` | **eza** | Long format listing with permissions, file sizes, and dates. | `ll` |
| `la` | **eza** | Long format listing including hidden files (`.dotfiles`). | `la` |
| `lt` | **eza** | Two-level deep hierarchical directory tree view. | `lt` |
| `cat <file>` | **bat** | Print syntax-highlighted content without paging. | `cat ~/.zshrc` |
| `batp <file>` | **bat** | Open file with interactive pager and line numbers. | `batp large_log.txt` |
| `rg <query>` | **ripgrep** | Fast recursive text search across files. | `rg "alias"` |
| `rgi [query]` | **rg + fzf + bat** | Live interactive search with synchronized line preview in `bat`. | `rgi` or `rgi HISTSIZE` |
| `df` | **duf** | Clean disk space overview formatted for Termux and internal storage. | `df` |
| `btm` | **bottom** | Real-time system monitor (CPU cores, RAM, network, processes). | `btm` or `bottom` |
| `mise` | **mise** | Polyglot runtime and environment manager (Node, Python, Bun). | `mise use node@22` |
| `atuin` / `at` | **atuin** | Indexed SQLite history with runtime statistics and error codes. | `atuin` or `at` |
| `y` / `yz` | **yazi** | Asynchronous TUI file manager with auto-cd on exit. | `y` or `y ~/docs` |
| `ta` / `tls` | **tmux** | Attach to or create `main` session, list sessions. | `ta` or `tls` |
| `tldr <command>` | **tealdeer** | Practical command cheat sheet with real-world examples in sub-second time. | `tldr tar` |
| `git diff` | **delta** | Side-by-side or unified syntax-highlighted diffs in terminal and Lazygit. | `git diff` or `lazygit` |
| `Right Arrow` / `Tab` | **autosuggestions** | Accept ghost history suggestions. | Type prefix, press `Right Arrow`. |
| `nvim` / `v` | **Neovim** | Modal code editor and full development environment. | `nvim` or `v file.lua` |

---

## 3. Tool Details and Integrations

### Zoxide (Smart Directory Navigation)

Zoxide tracks directory visit frequency and recency ("frecency"). You do not need to type long absolute paths. After navigating once via `cd`, you can jump back with `z <folder_snippet>`. Running `zi` launches an interactive selector using FZF.

### FZF & FD (Fuzzy Finding)

- Configured with `--height 40% --layout=reverse` to preserve screen real estate on mobile devices.
- Uses `fd` instead of standard `find` to automatically ignore `.git` directories and respect `.gitignore` rules.
- File previews leverage `bat` with line ranges; directory previews display an `eza` tree.

### Bat & Eza

- `cat` defaults to `bat --paging=never` for fast syntax-colored output.
- `MANPAGER` is routed through `bat` so system man pages render formatted and highlighted.
- `eza` groups directories first and renders file-type glyphs via the bundled Nerd Font.

### Atuin (Searchable Shell History)

- Initialized with `--disable-ctrl-r` and `--disable-up-arrow` to preserve native Zsh arrow navigation and FZF history bindings.
- Dedicated `at` alias or typing `atuin` opens the interactive search interface.
- Includes automated secret filtering to prevent environment tokens and passwords from persisting into the SQLite history database.

### Mise (Polyglot Runtime and Tool Manager)

Mise is a high-performance development environment and toolchain manager written in Rust, serving as an efficient alternative to `asdf`, `nvm`, and `pyenv`:

- **Automatic Per-Project Toolchains:** Automatically activates project-specific versions of Node.js, Python, Bun, or Go when entering directories containing `.mise.toml`, `.nvmrc`, or `.tool-versions`.
- **Low Resource Overhead:** Implemented in Rust with near-zero shell startup latency, making it optimal for ARM64 mobile environments.
- **Global and Local Workflows:** Pin system-wide defaults with `mise use -g node@22` or isolate development runtimes without modifying the underlying Termux package system.

### Fastfetch

- Displays system telemetry (OS, kernel, uptime, hardware specs, memory, battery, and storage).
- Automatically renders distribution logos without proprietary dependencies or hardcoded paths.
