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
