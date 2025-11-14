# Tmux + Neovim Setup Script

A simple bash script to set up tmux and Neovim with seamless integration on OmarchyOS

## What This Script Does

- Installs tmux via pacman
- Creates `~/.tmux.conf` with custom configuration
- Installs TPM (Tmux Plugin Manager)
- Configures vim-tmux-navigator plugin for Neovim
- Sets up Neovim line numbers (relative + absolute)
- Adds custom keymaps for window splits

## Installation

### Quick Install (One-liner)

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/ehoang0106/nvim-setup/master/nvim-setup.sh)
```

### Manual Install

```bash
# Download the script
curl -O https://raw.githubusercontent.com/ehoang0106/nvim-setup/master/nvim-setup.sh

# Make it executable
chmod +x nvim-setup.sh

# Run it
./nvim-setup.sh
```

## What Gets Configured

### Tmux Configuration
- **Prefix key:** Changed to `Ctrl+s` (from default `Ctrl+b`)
- **Mouse support:** Enabled
- **Pane navigation:** `Ctrl+s` then `h/j/k/l`
- **Split windows:**
  - `Ctrl+s` then `v` for vertical split
  - `Ctrl+s` then `h` for horizontal split
- **Reload config:** `Ctrl+s` then `r`
- **Status bar:** Positioned at top
- **Theme:** Everforest dark-medium

### Neovim Configuration
- **Line numbers:** Hybrid mode (relative + absolute)
- **Tmux integration:** Seamless navigation between vim splits and tmux panes using `Ctrl+h/j/k/l`
- **Window splits:**
  - `<leader>v` for vertical split
  - `<leader>h` for horizontal split

## Post-Installation Steps

1. Start tmux:
   ```bash
   tmux
   ```

2. Install tmux plugins:
   - Press `Ctrl+s` then `Shift+I` (capital I)

3. Reload tmux config (if needed):
   - Press `Ctrl+s` then `r`

4. Open Neovim and enjoy seamless navigation:
   - Use `Ctrl+h/j/k/l` to navigate between tmux panes and vim splits

## Plugins Included

### Tmux Plugins
- [TPM](https://github.com/tmux-plugins/tpm) - Tmux Plugin Manager
- [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) - Seamless navigation between tmux panes and vim splits
- [tmux-everforest](https://github.com/omerxx/tmux-everforest) - Everforest theme for tmux

### Neovim Plugins
- [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) - Neovim integration for tmux navigation
