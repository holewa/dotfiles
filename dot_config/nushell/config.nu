source aliases.nu

# Path variables
$env.PATH = $"($env.PATH):/opt/nvim-linux-x86_64/bin"
$env.PATH = $"($env.PATH):($env.HOME):/bin"
$env.PATH = $"($env.HOME):/.local/bin:($env.PATH)"

$env.SDKMAN_DIR = $"($env.HOME)/.sdkman"
$env.PATH = $"($env.HOME)/.sdkman/candidates/java/current/bin:($env.PATH)"
$env.PATH = $"($env.HOME)/.sdkman/candidates/maven/current/bin:($env.PATH)"
$env.PATH = $"($env.HOME)/.sdkman/candidates/gradle/current/bin:($env.PATH)"
$env.PATH = $"($env.PATH):($env.HOME)/bin"
$env.PATH = $"($env.PATH):($env.HOME)/.local/bin"
$env.PATH = $"($env.PATH):/usr/local/bin"
$env.PATH = $"($env.PATH):/bin"

source ~/.config/nushell/env-variables/set_env_variables_his.nu
source ~/.config/nushell/env-variables/api_keys.nu
source ~/.config/nushell/zoxide.nu
source ~/.config/nushell/carapace.nu
# TODO: run through folder instead of manually do every file
# for file in (ls ~/.config/nushell/.env-variables/*.nu) {
#     open $file.name | column | each { run $it }
# }

#Workaround to for adding ./ before scripts
$env.PATH = $env.PATH + ":."

#Add config files/folders to chezmoi
def chm [path] {
    chmod +x $path
}

def chadd [] {
    chezmoi add ~/.aliases
    chezmoi add ~/.tmux.conf
    chezmoi add -r ~/.config/nvim
    chezmoi add ~/.config/nushell/aliases.nu
    chezmoi add ~/.config/nushell/config.nu
}

# Hide the banner
$env.config.show_banner = false

## ${UserConfigDir}/nushell/env.nu
#mkdir $"($nu.cache-dir)"
#carapace _carapace nushell | save --force $"($nu.cache-dir)/carapace.nu"

# ${UserConfigDir}/nushell/config.nu
#source $"($nu.cache-dir)/carapace.nu"



# config.nu
#
# Installed by:
# version = "0.107.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R
