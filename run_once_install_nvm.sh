#!/bin/bash

# Install NVM if not already installed
if [ ! -d "$HOME/.nvm" ]; then
    echo "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
else
    echo "NVM is already installed."
fi

# Load NVM and install the latest LTS version of Node.js
source "$HOME/.nvm/nvm.sh"
nvm install --lts

# Verify Node.js and NPM installations
node -v
npm -v
