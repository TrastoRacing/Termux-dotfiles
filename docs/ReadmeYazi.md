# Yazi File Manager Configuration for Termux

Terminal file manager configuration built in Rust with asynchronous non-blocking I/O, preview rendering, and deep integration with Neovim and Android.

---

## 1. Overview

Yazi is an asynchronous terminal file manager. In this Termux environment, it is configured with:

- **Theme:** Tokyo Night palette matching Neovim and the Oh My Posh shell prompt.
- **Shell Wrapper (`y` / `yz`):** Changes the shell working directory to the last browsed folder upon exit.
- **Preview Engines:**
  - Images: Rendered in terminal cells using `chafa`.
  - PDF Documents: Page rasterization via `poppler` (`pdftoppm`).
  - Videos: Thumbnail extraction via `ffmpegthumbnailer`.
  - Archives: Content inspection of `.zip`, `.tar.gz`, `.7z` via `7zip`.
  - Code / Text: Syntax-highlighted previews with Tokyo Night styling.
- **Android Integration:** Clipboard sync through `termux-clipboard-set` and file handoff to native apps via `termux-open`.
- **Neovim Integration:** Floating file browser via the `yazi.nvim` plugin.

---

## 2. Launching Yazi

| Command | Behavior |
| :--- | :--- |
| `y` | Launches Yazi. When exiting with `q`, your shell automatically `cd`s to the current folder. |
| `yz` | Fast alias identical to `y`. |
| `y <path>` | Opens Yazi directly at a specified path (e.g. `y /storage/emulated/0/Download`). |
| `yazi` | Direct executable (exits without changing the parent shell directory). |
| `q` | Exit and confirm directory change in your shell. |
| `Q` | Exit and cancel directory change (stays in original shell directory). |

---

## 3. Navigation Shortcuts

| Key | Action |
| :--- | :--- |
| `h` / `Left` | Go to parent directory. |
| `l` / `Right` / `Enter` | Enter directory or open file. |
| `j` / `Down` | Move cursor down. |
| `k` / `Up` | Move cursor up. |
| `g g` | Jump to the first item in the list. |
| `G` | Jump to the last item in the list. |
| `Ctrl + u` / `Ctrl + d` | Scroll half page up or down. |
| `.` | Toggle visibility of hidden files and dotfiles. |
| `/` | Filter items in real time in the current folder. |
| `z` | Quick jump using integrated `zoxide`. |
| `Z` | Fuzzy directory jump using integrated `fzf`. |

---

## 4. File Operations

| Key | Action |
| :--- | :--- |
| `a` | Create file or folder (append `/` to name to create a folder). |
| `r` | Rename item under cursor. |
| `y` | Copy (yank) selected item(s). |
| `x` | Cut selected item(s). |
| `p` | Paste copied or cut items into current directory. |
| `d` | Move item(s) to trash. |
| `D` | Permanently delete item(s). |
| `v` | Toggle visual selection mode. |
| `Ctrl + a` | Select all items in current directory. |
| `Esc` | Clear selection or return to normal mode. |

---

## 5. Android and Termux Shortcuts

Configured in `~/.config/yazi/keymap.toml`:

| Key Sequence | Action |
| :--- | :--- |
| `c` then `p` | Copy absolute file path to Android clipboard (`termux-clipboard-set`). |
| `c` then `d` | Copy parent directory path to Android clipboard. |
| `c` then `n` | Copy file name to Android clipboard. |
| `T` | Open file with native Android app via `termux-open` (photo viewer, video player, PDF reader). |
| `!` | Open an interactive Zsh subshell in the current folder. Exit the subshell to return to Yazi. |

---

## 6. Neovim Integration

Configured via `yazi.nvim`:

| Shortcut in Neovim | Action |
| :--- | :--- |
| `<Space> -` or `<Space> y` | Open Yazi in a floating window focused on the active buffer. Selecting a file opens it in Neovim. |
| `<Space> c w` | Open Yazi at the root working directory (`cwd`) of the active project. |
| `<Ctrl + Up>` | Resume the previous Yazi session within Neovim. |
