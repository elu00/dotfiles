-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font_with_fallback({
	"Iosevka Term SS04",
	{ family = "Symbols Nerd Font Mono", scale = 0.6 },
})
config.hide_tab_bar_if_only_one_tab = true

config.font_size = 18.0
config.default_prog = { "zsh" }

-- and finally, return the configuration to wezterm
return config
