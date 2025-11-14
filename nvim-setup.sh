#!/bin/bash

set -e #exit on error

#check if running on arch linux

if ! command -v pacman &> /dev/null; then
    echo "Error: This script is only work on arch linux (pacman not found)"
    exit 1
fi

echo "==================================="
echo "Tmux Installation"
echo "==================================="
echo ""

#check if tmux is already installed

if command -v tmux &> /dev/null; then
    echo "Tmux is already installed!"
fi

#update package database
echo "Updating package database..."
sudo pacman -Sy

#install tmux
echo "Installing tmux..."
sudo pacman -S --noconfirm tmux

#verify
echo ""
echo "==================================="
if command -v tmux &> /dev/null; then
    echo "Success! Tmux has been installed."
    echo "Version: $(tmux -V)"
    echo ""
else
    echo "Error: Installation failed."
    exit 1
fi
echo "==================================="

# Create tmux configuration file
echo ""
echo "Creating ~/.tmux.conf..."
cat > ~/.tmux.conf << 'EOF'
unbind r
bind r source-file ~/.tmux.conf

set -g prefix C-s

set -g mouse on

bind-key h select-pane -L
bind-key j select-pane -D
bind-key k select-pane -U
bind-key l select-pane -R
bind-key v split-window -v -c '#{pane_current_path}'
bind-key h split-window -h -c '#{pane_current_path}'

set-option -g status-position top

set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'christoomey/vim-tmux-navigator'
set -g @vim_navigator_mapping_left "C-Left C-h"  # use C-h and C-Left
set -g @vim_navigator_mapping_right "C-Right C-l"
set -g @vim_navigator_mapping_up "C-k"
set -g @vim_navigator_mapping_down "C-j"
set -g @tmux-everforest 'dark-medium'

run '~/.tmux/plugins/tpm/tpm'
EOF

echo "tmux.conf created successfully"
echo "==================================="
#install tmp

echo ""
echo "Installing TPM (Tmux Plugin Manager)..."

echo "Cloning TPM repository..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "TPM installed successfully"

#create Neovim plugin configuration for tmux-navigator
echo ""
echo "==================================="
echo "Setting up Neovim tmux-navigator plugin..."
echo "==================================="

#create the plugins directory if it doesn't exist
mkdir -p ~/.config/nvim/lua/plugins

#create the nvim-tmux-navigator.lua file
cat > ~/.config/nvim/lua/plugins/nvim-tmux-navigator.lua << 'EOF'
return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
    "TmuxNavigatorProcessList",
  },
  keys = {
    { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
    { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
    { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
    { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
    { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
  },
}
EOF

echo "Neovim tmux-navigator plugin configured"

#configure Neovim options
echo ""
echo "==================================="
echo "Configuring Neovim options..."
echo "==================================="

#check if options.lua exists
if [ -f ~/.config/nvim/lua/config/options.lua ]; then
    echo "Found existing options.lua, updating line number settings..."

    #check if relativenumber exists and update it
    if grep -q "vim.opt.relativenumber" ~/.config/nvim/lua/config/options.lua; then
        sed -i 's/vim\.opt\.relativenumber = .*/vim.opt.relativenumber = true/' ~/.config/nvim/lua/config/options.lua
        echo "  Updated vim.opt.relativenumber = true"
    else
        echo "vim.opt.relativenumber = true" >> ~/.config/nvim/lua/config/options.lua
        echo "  Added vim.opt.relativenumber = true"
    fi

    #check if number exists, if not add it
    if ! grep -q "vim.opt.number = true" ~/.config/nvim/lua/config/options.lua; then
        echo "vim.opt.number = true" >> ~/.config/nvim/lua/config/options.lua
        echo "  Added vim.opt.number = true"
    else
        echo "  vim.opt.number = true already exists"
    fi
else
    echo "options.lua not found, creating new file..."
    mkdir -p ~/.config/nvim/lua/config
    cat > ~/.config/nvim/lua/config/options.lua << 'EOF'
-- Line numbers
vim.opt.relativenumber = true
vim.opt.number = true
EOF
    echo "  Created options.lua with line number settings"
fi

echo "  Neovim options configured successfully"

#configure Neovim keymaps
echo ""
echo "==================================="
echo "Configuring Neovim keymaps..."
echo "==================================="

#check if keymaps.lua exists
if [ -f ~/.config/nvim/lua/config/keymaps.lua ]; then
    echo "Found existing keymaps.lua, updating window split keymaps..."

    #check if the leader+v keymap exists and update it
    if grep -q '"<leader>v".*vnew' ~/.config/nvim/lua/config/keymaps.lua; then
        sed -i 's/vim\.keymap\.set.*"<leader>v".*vnew.*/vim.keymap.set({ "n", "v" }, "<leader>v", ":vnew<CR>")/' ~/.config/nvim/lua/config/keymaps.lua
        echo "  Updated <leader>v keymap"
    else
        echo 'vim.keymap.set({ "n", "v" }, "<leader>v", ":vnew<CR>")' >> ~/.config/nvim/lua/config/keymaps.lua
        echo "  Added <leader>v keymap"
    fi

    #check if the leader+h keymap exists and update it
    if grep -q '"<leader>h".*new' ~/.config/nvim/lua/config/keymaps.lua; then
        sed -i 's/vim\.keymap\.set.*"<leader>h".*new.*/vim.keymap.set({ "n", "v" }, "<leader>h", ":new<CR>")/' ~/.config/nvim/lua/config/keymaps.lua
        echo "  Updated <leader>h keymap"
    else
        echo 'vim.keymap.set({ "n", "v" }, "<leader>h", ":new<CR>")' >> ~/.config/nvim/lua/config/keymaps.lua
        echo "  Added <leader>h keymap"
    fi
else
    echo "keymaps.lua not found, creating new file..."
    mkdir -p ~/.config/nvim/lua/config
    cat > ~/.config/nvim/lua/config/keymaps.lua << 'EOF'
-- Window splits
vim.keymap.set({ "n", "v" }, "<leader>v", ":vnew<CR>")
vim.keymap.set({ "n", "v" }, "<leader>h", ":new<CR>")
EOF
    echo "  Created keymaps.lua with window split keymaps"
fi

echo "Neovim keymaps configured successfully"

echo ""
echo "==================================="
echo "Setup Complete!"
echo "==================================="




