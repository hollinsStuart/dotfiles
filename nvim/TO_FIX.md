# TO_FIX

## Duplicate / Conflicting Keybindings

### 1. `gd` — LSP Go to Definition (normal mode) ✓ FIXED

Removed `gd` from `plugin/lsp/lsp.lua`. Canonical binding is now `lua/plugins/snacks.lua` → `Snacks.picker.lsp_definitions()`.

---

### 2. `gD` — LSP Go to Declaration (normal mode) ✓ FIXED

Removed `gD` from `plugin/lsp/lsp.lua`. Canonical binding is now `lua/plugins/snacks.lua` → `Snacks.picker.lsp_declarations()`.

---

### 3. `<leader>s` — Switch word vs. mini.surround prefix (normal mode) ✓ FIXED

Rebound switch.vim from `<leader>s` to `gs` in `lua/plugins/switch.lua:6`.

---

### 4. `<C-k>` / `<C-j>` — Navigation in insert mode ✓ NOT A CONFLICT

Telescope's mappings are defined inside `telescope.setup()` and are scoped to the telescope prompt buffer only. They cannot fire in regular insert mode where blink is active. No fix needed.
