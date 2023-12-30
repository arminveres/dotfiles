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
local awful = require("awful")
local beautiful = require("beautiful")
local helper = require("helpers")
local lain = require("lain")

-- tag layout changed
tag.connect_signal("property::layout", helper.mw_fact_mgr)
-- tag select, e.g., when concatenated
tag.connect_signal("property::selected", helper.mw_fact_mgr)

tag.connect_signal("property::floating", function(c)
    helper.mw_fact_mgr()
    if c.floating then
        awful.placement.centered(c)
    end
end)

client.connect_signal("focus", function(c)
    helper.mw_fact_mgr()
    c.border_color = beautiful.border_focus
end)

client.connect_signal("unfocus", function(c)
    helper.mw_fact_mgr()
    c.border_color = beautiful.border_normal
end)

-- NOTE: the `(un)manage` signal is emitted when a client is opened/closed, which is a better factor
-- for calling our manager function
client.connect_signal("manage", helper.mw_fact_mgr)
client.connect_signal("unmanage", helper.mw_fact_mgr)

-- awful.screen.connect_for_each_screen(function(s)
--     -- Set bottom layout for screens with higher height than width
--     -- if s.geometry.width < s.geometry.height then
--     local tag = screen.selected_tag
--     if s.index == 2 then
--         awful.layout.set(awful.layout.suit.tile.bottom, tag)
--     else
--         awful.layout.set(awful.layout.layouts[1], tag)
--     end
-- end)
