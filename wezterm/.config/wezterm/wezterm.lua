--[[
-- More about the configuration ca be found here:
-- https://wezfurlong.org/wezterm/config/files.html
--]]
local wezterm = require 'wezterm'

return {
    enable_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,
    color_scheme = "Gruvbox dark, hard (base16)",
    window_background_opacity = 0.95,

    font = wezterm.font_with_fallback {
        {
            family = 'TamzenForPowerline',
            weight = 'Medium',
            -- disable ligatures for Tamzen since it lacks them
            harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
        },
    },
    underline_position = "-3", -- fix underline for tamzen, otherwise too high
    font_size = 8,

    -- font = wezterm.font 'Terminus',
    -- font = wezterm.font('DinaRemasterII'),
    -- font_size = 12.0,
    -- font = wezterm.font({ family = 'Hack Nerd Font Mono' }),
    -- font = wezterm.font({ family = 'RobotoMono Nerd Font Mono' }),
    -- font = wezterm.font({ family = 'NotoSansMono Nerd Font Mono' }),
    -- font_size = 10.0,
    -- font = wezterm.font({ family = 'IosevkaTerm Nerd Font' }),
    -- font_size = 11,
}
