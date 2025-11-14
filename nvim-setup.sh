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

