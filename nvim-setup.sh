#!/bin/bash

set -e #exit on error

echo "==================================="
echo "Tmux Installation"
echo "==================================="
echo ""

#check if running on arch linux

if ! command -v pacman &> /dev/null; then
    echo "Error: This script is only work on arch linux (pacman not found)"
    exit 1
fi

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
# Install TPM (Tmux Plugin Manager)
echo ""
echo "Installing TPM (Tmux Plugin Manager)..."

echo "Cloning TPM repository..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "TPM installed successfully"



