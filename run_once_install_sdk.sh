#!/bin/bash

if [ ! -d "$HOME/.sdkman" ]; then
	echo "Getting sdkman"
	sh -c "$(curl -s "https://get.sdkman.io" | bash 
else
	echo "sdkman already found, skipping."
fi
