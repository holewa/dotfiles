#!/bin/bash

# Check if rg (ripgrep) is installed
if ! command -v rg &> /dev/null; then
    echo "Installing ripgrep (rg)..."
    # Download the latest release of ripgrep binary
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/$(curl -s https://api.github.com/repos/BurntSushi/ripgrep/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')/ripgrep_$(curl -s https://api.github.com/repos/BurntSushi/ripgrep/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")').deb
    # Install the downloaded .deb package
    sudo dpkg -i ripgrep_*.deb
    # Clean up the downloaded .deb package
    rm ripgrep_*.deb
else
    echo "ripgrep (rg) is already installed."
fi
