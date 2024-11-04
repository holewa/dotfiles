#!/bin/bash

LAZYGIT_BIN="/usr/local/bin/lazygit"

# Check if Lazygit is already installed
if ! command -v lazygit &> /dev/null; then
    echo "Downloading Lazygit..."

    # Get the latest version number
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')

    # Download the latest Lazygit tarball
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"

    # Extract the tarball
    tar xf lazygit.tar.gz lazygit

    # Move Lazygit binary to /usr/local/bin
    sudo install lazygit /usr/local/bin/

    # Clean up
    rm lazygit.tar.gz lazygit

    echo "Lazygit installed successfully."
else
    echo "Lazygit is already installed, skipping installation."
fi
