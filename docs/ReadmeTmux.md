# Tmux Configuration for Termux

Terminal multiplexer configuration optimized for Android tablet workflows with hardware keyboard, trackpad, and touch input.

---

## 1. Overview and Key Benefits

Tmux (Terminal Multiplexer) decouples running terminal processes from the graphical interface. In Termux on Android, this provides three key benefits:

1. **Process Persistence:** If Android suspends or kills the Termux activity in the background, your active processes (Neovim, compilers, dev servers) continue running. Attaching to the session restores the exact working state.
2. **Split Panes:** Run multiple interactive consoles side-by-side (for example, Neovim alongside a terminal or Yazi file manager).
3. **Hardware Input Integration:** Full support for trackpad clicks, border dragging, two-finger scrolling, and touch navigation.

---

## 2. Shell Aliases

Pre-configured in `.zshrc` for session management:

| Command | Action |
| :--- | :--- |
| `ta` | Attach to the `main` session if it exists; create it otherwise. |
| `tls` | List all active Tmux sessions. |
| `tkill` | Terminate the Tmux server and all active sessions. |
| `tmux new -s <name>` | Create a session with a custom name. |

---

## 3. Prefix Key

Tmux commands require pressing the prefix key combination before the command key:

- **Primary Prefix:** `Ctrl + a` (optimized for ergonomics and mobile keyboard rows).
- **Secondary Prefix:** `Ctrl + b` (standard Tmux compatibility).

---

## 4. Pane Management

| Action | Hardware / Touch Shortcut | Fallback / Alternative |
| :--- | :--- | :--- |
| **Split Vertically (columns side-by-side)** | `Ctrl + a` then `v` | `\|`, `\`, `%` |
| **Split Horizontally (rows top and bottom)** | `Ctrl + a` then `s` or `-` | `_`, `"` |
| **Navigate Panes Direct (no prefix)** | `Alt + Left / Down / Up / Right` | Direct jump |
| **Navigate Panes with Vim keys** | `Ctrl + a` then `h` (left), `j` (down), `k` (up), `l` (right) | Directional arrows |
| **Focus Pane with Pointer / Finger** | Tap or click directly inside the target pane | Border turns active blue |
| **Resize Pane with Pointer / Finger** | Click and drag the dividing border line | Immediate live resize |
| **Resize Pane with Keyboard** | `Ctrl + a` then `H` / `J` / `K` / `L` | Steps of 5 columns/rows |
| **Maximize / Restore Pane (Zoom)** | `Ctrl + a` then `z` | Toggles full-screen pane |
| **Close Current Pane** | Type `exit` or press `Ctrl + d` | Closes active shell |

---

## 5. Window Management (Tabs)

| Action | Shortcut |
| :--- | :--- |
| **Create New Window** | `Ctrl + a` then `c` (preserves current working directory) |
| **Switch Window with Pointer / Finger** | Click or tap the window name in the bottom status bar |
| **Next Window** | `Ctrl + a` then `n` |
| **Previous Window** | `Ctrl + a` then `p` |
| **Select Window by Index** | `Ctrl + a` then `1`, `2`, `3`... |
| **Rename Current Window** | `Ctrl + a` then `,` |
| **Interactive Window List** | `Ctrl + a` then `w` |

---

## 6. Trackpad, Mouse, and Touch Navigation

Mouse tracking is globally enabled (`set -g mouse on`):

- **Pane Selection:** Click or tap any pane to focus it.
- **Resizing:** Click and hold the divider border line between panes and drag it.
- **Scrollback Buffer:** Perform a two-finger scroll up on the trackpad or drag upward on touch to browse command history. Exit scroll mode by pressing `q`.
- **Text Selection:** Click and drag across text to highlight and copy within Tmux.
- **Android Native Clipboard Bypass:** Hold the `Shift` key while clicking or dragging to bypass Tmux mouse capture and trigger the native Android/Termux copy/paste menu.

> [!NOTE]
> On Xiaomi HyperOS and certain Android tablet keyboards, trackpads require a physical mechanical click down by default. To enable tap-to-click, go to `Settings > Additional Settings > Keyboard, mouse and trackpad > Trackpad > Tap to click`.

---

## 7. Session Detach and Clipboard

| Action | Shortcut |
| :--- | :--- |
| **Detach Session** | `Ctrl + a` then `d` (leaves session alive in background, returns to shell) |
| **Live Configuration Reload** | `Ctrl + a` then `r` (reloads `~/.tmux.conf` immediately) |
| **Manual Vi Copy Mode** | `Ctrl + a` then `[` (navigate with `hjkl`, exit with `q`) |
| **Copy to Android Clipboard** | In vi copy mode, press `v` to begin selection and `y` to pipe to `termux-clipboard-set` |

---

## 8. Visual Theme

The status bar and borders use the Tokyo Night palette:

- Active window and focused pane borders are highlighted in Tokyo Night Blue (`#7aa2f7`).
- Inactive tabs and borders are styled in muted slate tones (`#414868`, `#565f89`).
- Session name appears on the bottom-left; timestamp and date are displayed on the bottom-right.
