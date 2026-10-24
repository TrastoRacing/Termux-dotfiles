# Neovim & LazyVim Cheat Sheet for Termux

Practical reference manual for modal editing, code navigation, LSP integrations, and LazyVim keybindings in Termux on Android.

---

## 1. Vim Modes

| Mode | Purpose | How to Enter | How to Exit |
| :--- | :--- | :--- | :--- |
| **Normal** | Navigate, execute commands, manipulate text blocks. | Default mode. | Press `Esc`. |
| **Insert** | Type and insert text as in standard text editors. | Press `i` (before cursor) or `a` (after cursor). | Press `Esc`. |
| **Visual** | Highlight and select text for manipulation. | `v` (character), `V` (line), `Ctrl + v` (block). | Press `Esc`. |
| **Command** | Execute editor operations (`:w`, `:q`, substitutions). | Press `:` in Normal mode. | Press `Esc` or `Enter`. |

---

## 2. File Operations: Save and Exit

From **Normal Mode**:

| Command | Action | Description |
| :--- | :--- | :--- |
| `:w` | Write | Save current buffer changes without exiting. |
| `:q` | Quit | Close window or exit (only if buffer is unchanged). |
| `:wq` or `:x` or `ZZ` | Write & Quit | Save changes and exit immediately. |
| `:q!` or `ZQ` | Force Quit | Exit without saving (discards unsaved modifications). |

> [!NOTE]
> **Auto-Save:** The `auto-save.nvim` plugin is configured to save buffers automatically during idle pauses. You can toggle auto-save on or off using `<Leader>uv`.

---

## 3. Motion and Navigation

### Character and Word Motion

- `h`, `j`, `k`, `l`: Left, down, up, right.
- `w`: Advance to the start of the next word.
- `b`: Move backward to the start of the previous word.
- `e`: Advance to the end of the current word.

### Line Motion

- `0`: Jump to the absolute beginning of the line.
- `^`: Jump to the first non-whitespace character on the line.
- `$`: Jump to the end of the line.

### Document and Screen Motion

- `gg`: Jump to the first line of the document.
- `G`: Jump to the last line of the document.
- `:<number>`: Jump to a specific line number (e.g. `:42`).
- `Ctrl + u`: Scroll half screen up.
- `Ctrl + d`: Scroll half screen down.
- `%`: Jump to matching bracket, parenthesis, or brace.

---

## 4. Editing and Text Manipulation

- `x`: Delete single character under cursor.
- `dw`: Delete from cursor to the beginning of the next word.
- `dd`: Delete (cut) entire line.
- `ciw`: Change inner word (deletes word under cursor and enters Insert mode).
- `ci"` or `ci(`: Change text enclosed in quotes or parentheses.
- `yy`: Copy (yank) entire line.
- `p`: Paste clipboard contents after cursor.
- `P`: Paste clipboard contents before cursor.
- `u`: Undo last action.
- `Ctrl + r`: Redo last undone action.
- `.` (Dot command): Repeat the last text change.

---

## 5. Search and Replace

- `/pattern`: Search forward for `pattern`. Press `Enter` to start.
- `?pattern`: Search backward for `pattern`.
- `n`: Jump to next search match.
- `N`: Jump to previous search match.
- `*`: Search forward for the word under the cursor.
- `:%s/old/new/g`: Replace all occurrences of `old` with `new` across the entire buffer.
- `:%s/old/new/gc`: Replace with interactive confirmation for each match.

---

## 6. LazyVim Keybindings (Leader Key: `<Space>`)

### File and Buffer Management

- `<Space> ff`: Fuzzy search files in project.
- `<Space> fr`: Open recently accessed files.
- `<Space> fn`: Create new empty file buffer.
- `<Space> bb`: Switch between active buffers.
- `<Space> bd`: Close active buffer without closing the split window.
- `<Space> e`: Toggle Neo-tree file explorer.

### Global Search

- `<Space> sg`: Grep across project files using Ripgrep.
- `<Space> sw`: Grep for the word currently under the cursor across the project.
- `<Space> sb`: Search within current buffer lines.

### Git Integration

- `<Space> gg`: Open Lazygit in an integrated floating window.
- `<Space> gd`: Open Diffview to review repository branch diffs.
- `<Space> gh`: Review git commit history for the current file via Diffview.
- `<Space> gH`: Review git commit history for the active branch via Diffview.

### Language Server Protocol (LSP) and Diagnostics

- `gd`: Jump to definition of symbol under cursor.
- `gr`: List all references to symbol under cursor.
- `gI`: Jump to implementation.
- `K`: Display hover documentation for symbol.
- `<Space> ca`: Open code action menu (fixes, refactorings).
- `<Space> cr`: Rename symbol across all project references.
- `<Space> cf`: Format active buffer with configured formatter (Prettier, Stylua, Shfmt).
- `<Space> xx`: Open Trouble diagnostics panel (shows workspace errors and warnings).
- `[d` / `]d`: Jump to previous / next diagnostic error.

### Yazi File Manager Integration

- `<Space> -` or `<Space> y`: Open Yazi floating file manager centered on the current file buffer.
- `<Space> cw`: Open Yazi rooted at the project working directory.

### Code Minimap Integration (`neominimap.nvim`)

- `<Space> nm`: Toggle floating code minimap on or off.
- `<Space> no`: Explicitly enable code minimap.
- `<Space> nc`: Explicitly disable code minimap.
- `<Space> nf`: Focus the minimap window to navigate via keyboard.
- `<Space> nu`: Unfocus the minimap and return to the main editor buffer.
- `<Space> nr`: Force refresh the minimap buffer.
- **Touch Navigation:** Tap directly on any section of the floating minimap to instantly warp the cursor to that line in the active buffer.

---

## 7. Touch and Mouse Interactions

Neovim operates with full mouse and touch support enabled (`mouse = "a"`):

- **Bufferline Tabs:** Tap any top tab to switch to that buffer immediately.
- **Direct Cursor Placement:** Tap anywhere inside a code buffer to place the cursor on that line and column.
- **Interactive Minimap:** Tap anywhere on the right-hand floating minimap to jump directly to that section of the document.
- **Smooth Scrolling:** Use two-finger trackpad or touchscreen swipes for smooth vertical scrolling.
