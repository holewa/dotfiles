#!/bin/bash

# Check if rg (ripgrep) is installed
if ! command -v rg &> /dev/null; then
    echo "Installing ripgrep (rg)..."
    sudo apt install ripgrep
else
    echo "ripgrep (rg) is already installed."
fi
