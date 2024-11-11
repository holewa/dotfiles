#!/bin/bash

NVIM_DIR="$HOME/nvim-linux64"
NVIM_BIN="$NVIM_DIR/bin/nvim"

if [ ! -f "$NVIM_BIN" ]; then
    echo "Downloading Neovim..."
    
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz

    sudo rm -rf /opt/nvim

    sudo tar -C /opt -xzf nvim-linux64.tar.gz

    echo "Neovim installed successfully."
else
    echo "Neovim already found, skipping installation."
fi
