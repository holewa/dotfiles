#!/bin/bash
# C02BD55869A3F052024E81935879C5E4FE180498
sudo apt update

install_if_not_installed() {
    local package_name="$1"
    local check_command="$2"
    local install_command="$3"

    if ! eval "$check_command"; then
        echo "$package_name not found, installing..."
        eval "$install_command"
    else
        echo "$package_name is already installed."
    fi
}

# Oh My Zsh directory
plugins_dir="$HOME/.oh-my-zsh/plugins"

# Define an array of packages to install
packages=(
    # Format: package_name check_command install_command 
    'Node' 'command -v node &> /dev/null' 'sudo apt install nodejs npm' 
    'Python' 'command -v python3 &> /dev/null' 'sudo apt install python3' 
    'NVM' '[ -d $HOME/.nvm ]' 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash' 

    # Oh My Zsh plugins
    'Powerlevel10k' '[ -d "$plugins_dir/themes/powerlevel10k" ]' 'git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $plugins_dir/themes/powerlevel10k' 
    'Zsh autosuggestions' '[ -d "$plugins_dir/zsh-autosuggestions" ]' 'git clone https://github.com/zsh-users/zsh-autosuggestions $plugins_dir/zsh-autosuggestions' 
    'You should use plugin' '[ -d "$plugins_dir/you-should-use" ]' 'git clone https://github.com/MichaelAquilina/zsh-you-should-use $plugins_dir/you-should-use' 
    'Zsh syntax highlighting plugin' '[ -d "$plugins_dir/zsh-syntax-highlighting" ]' 'git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $plugins_dir/zsh-syntax-highlighting' 
)

# Loop through the array and install each package
for ((i = 0; i < ${#packages[@]}; i+=3)); do
    install_if_not_installed "${packages[i]}" "${packages[i+1]}" "${packages[i+2]}"
done

Pip
curl -LO https://bootstrap.pypa.io/get-pip.py 
install_if_not_installed "command -v pip &> /dev/null" "sudo apt install python3-pip" "Pip"
rm get-pip.py
echo "Upgrading pip to the latest version..."
sudo pip install --upgrade pip

npm install -g neovim
sudo apt-get install tree-sitter-cli
