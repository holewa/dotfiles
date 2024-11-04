#!/bin/bash

NVIM_DIR="$HOME/nvim-linux64"
NVIM_BIN="$NVIM_DIR/bin/nvim"

if [ ! -f "$NVIM_BIN" ]; then
    echo "Downloading Neovim nightly build..."
    
    # Download the latest nightly tarball
    wget -O nvim-linux64.tar.gz https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
    
    # Extract the tarball
    tar xzvf nvim-linux64.tar.gz
    
    # Move the nvim binary to /usr/local/bin (optional, for global access)
    sudo mv "$NVIM_DIR/bin/nvim" /usr/local/bin/
    
    # Clean up
    rm -rf nvim-linux64.tar.gz "$NVIM_DIR"
    
    echo "Neovim installed successfully."
else
    echo "Neovim already found, skipping installation."
fi
