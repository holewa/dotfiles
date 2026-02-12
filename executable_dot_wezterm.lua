-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- Spawn an Ubuntu shell in login mode
config.default_domain = 'WSL:Ubuntu'
config.color_scheme = 'Catppuccin Mocha'


config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 12.0

-- config.window_decorations = "NONE"

-- Check the platform or other conditions to decide whether to remove window decorations
if wezterm.target_triple == "x86_64-pc-linux-gnu" then
  -- For Linux, remove window decorations
  config.window_decorations = "NONE"
else
  -- Otherwise, let the window manager handle the decorations
  config.window_decorations = "RESIZE"
end

config.keys = {
    {
        key = 'Backspace',
        mods = 'CTRL',
        action = wezterm.action.SendKey {
            key = 'w',
            mods = 'CTRL',
        }
    },
  {key="v", mods="CTRL", action=wezterm.action.PasteFrom 'Clipboard'},
}


-- and finally, return the configuration to wezterm
return config
