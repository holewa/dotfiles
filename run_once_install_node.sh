#!/bin/bash

if ! command -v node &> /dev/null; then
    echo "Node.js not found, installing..."
    sudo apt update
    sudo apt install nodejs npm
else
    echo "Node.js is already installed."
fi
