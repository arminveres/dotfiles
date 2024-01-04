-- tags  / layouts
-- ~~~~~~~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~
local awful = require("awful")
local bling = require("mods.bling")
local lain = require("lain")
local lmachi = require("mods.layout-machi")

-- misc/vars
-- ~~~~~~~~~

-- bling layouts
local mstab = bling.layout.mstab
local equal = bling.layout.equalarea
local deck = bling.layout.deck

-- layout machi
lmachi.editor.nested_layouts = {
    ["0"] = deck,
    ["1"] = awful.layout.suit.spiral,
    ["2"] = awful.layout.suit.fair,
    ["3"] = awful.layout.suit.fair.horizontal,
}

-- names/numbers of layouts
local names = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
local l = awful.layout.suit

-- Configurations
-- **************

-- default tags
tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
        lain.layout.centerwork,
        l.tile,
        lmachi.default_layout,
        l.tile.bottom,
        equal,
        mstab,
        deck,
        -- l.floating,
    })
end)

-- set tags
screen.connect_signal("request::desktop_decoration", function(s)
    screen[s].padding = { left = 0, right = 0, top = 0, bottom = 0 }
    if s == screen.primary then
        awful.tag(names, s, awful.layout.layouts[1])
    else
        awful.tag(names, s, l.tile.bottom)
    end
end)