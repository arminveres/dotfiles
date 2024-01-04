--[[
    Adapted from: https://github.com/saimoomedits/dotfiles
]]

pcall(require, "luarocks.loader")

USER_PREF = {
    -- aplications
    term = "alacritty",
    editor = "alacritty -e " .. "nvim",
    web = "firefox",
    files = "thunar",
    -- your profile
    username = os.getenv("USER"),
    userdesc = "@AwesomeWM",
}

require("theme")
require("config")
require("misc")
require("signal")
require("layout")

require("mods.bling").widget.window_switcher.enable({
    vim_previous_key = "l", -- Alternative key on which to select the previous client
    vim_next_key = "h", -- Alternative key on which to select the next client
})
