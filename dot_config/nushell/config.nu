source aliases.nu

# Path variables
$env.PATH = $"($env.PATH):/opt/nvim-linux-x86_64/bin"
$env.PATH = $"($env.PATH):($env.HOME):/bin"
$env.PATH = $"($env.HOME):/.local/bin:($env.PATH)"
$env.PATH =  $"/usr/share/maven/bin:($env.PATH)"
$env.SDKMAN_DIR = $"($env.HOME)/.sdkman"
# # [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
$env.PATH = $"($env.HOME)/.sdkman/candidates/java/current/bin:($env.PATH)"
$env.PATH = $"($env.HOME)/.sdkman/candidates/gradle/current/bin:($env.PATH)"
$env.PATH = $"($env.PATH):($env.HOME)/bin"


def chm [path] {
    chmod +x $path
}

def chadd [] {
    chezmoi add ~/.aliases
    chezmoi add ~/.tmux.conf
    chezmoi add -r ~/.config/nvim
}


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
