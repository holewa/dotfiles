#!/bin/bash

# Check if SDKMAN is installed
if [ ! -d "$HOME/.sdkman" ]; then
    echo "Getting sdkman..."
    sh -c "$(curl -s "https://get.sdkman.io" | bash)"
else
    echo "SDKMAN already found, skipping."
fi

# Load SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
source "$SDKMAN_DIR/bin/sdkman-init.sh"

# Install Java if it's not already installed
JAVA_VERSION="17.0.12-zulu"

if ! sdk list java | grep -q "$JAVA_VERSION"; then
    echo "Installing Java ($JAVA_VERSION)..."
    sdk install java "$JAVA_VERSION"
else
    echo "Java ($JAVA_VERSION) is already installed."
fi
