--[[
-- More about the configuration ca be found here:
-- https://wezfurlong.org/wezterm/config/files.html
--]]

local wezterm = require 'wezterm'

return {
    -- You can specify some parameters to influence the font selection;
    -- for example, this selects a Bold, Italic font variant.
    -- font = wezterm.font('JetBrains Mono', { weight = 'Bold', italic = true }),

    -- font = wezterm.font 'Terminus',
    -- font = wezterm.font 'Tamzen',
    -- font_size = 14,
    font = wezterm.font('Iosevka'),
    font_size = 12,
}
