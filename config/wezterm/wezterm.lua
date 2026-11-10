local wezterm = require("wezterm")

local config = {}

config.color_scheme_dirs = { "/home/ula/.config/wezterm/colors/" }

config.color_scheme = "Noctalia"

config.window_background_opacity = 0.8

config.font = wezterm.font("Iosevka Nerd Font")

config.default_cursor_style = "BlinkingBar"

config.cursor_thickness = "2"

config.cursor_blink_rate = 600

config.cursor_blink_ease_in = "EaseIn"

config.cursor_blink_ease_out = "Constant"

return config
