#!/bin/bash

# Check if pip is installed
if ! command -v pip &> /dev/null; then
    echo "Installing pip..."
    # Install pip via get-pip.py script
    curl -LO https://bootstrap.pypa.io/get-pip.py
    sudo python get-pip.py
    # Clean up the downloaded script
    rm get-pip.py
else
    echo "pip is already installed."
fi

# Upgrade pip to the latest version
echo "Upgrading pip to the latest version..."
sudo pip install --upgrade pip
