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
    -- You can specify some parameters to influence the font selection;
    -- for example, this selects a Bold, Italic font variant.
    -- font = wezterm.font('JetBrains Mono', { weight = 'Bold', italic = true }),

    font = wezterm.font_with_fallback {
        {
            family = 'TamzenForPowerline',
            weight = 'Medium',
            -- disable ligatures for Tamzen since it lacks them
            harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
        },
    },
    font_size = 8,

    -- font = wezterm.font 'Terminus',
}
