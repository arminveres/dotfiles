---------------------------------------------------------------------------------------------------
-- misc stuff, mostly autostart related and signal connections
---------------------------------------------------------------------------------------------------

local awful = require("awful")
local beautiful = require("beautiful")
local helper = require("helpers")

-- autostart
awful.spawn.with_shell(os.getenv("XDG_CONFIG_HOME") .. "/awesome/autorun.sh")

---------------------------------------------------------------------------------------------------
-- Signals to setup stuff
---------------------------------------------------------------------------------------------------
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

-- we need to let awesomewm repain the bar on screen change
screen.connect_signal("property::geometry", function(s)
    require("layout.bar").create_wibar(s)
    awful.spawn.with_shell("nitrogen --restore")
end)

-- theme applier
-- TODO: (aver) switch to other gtk theme
require("misc.scripts.theme-applier")

return {
    -- launchers
    musicMenu = require("misc.scripts.Rofi.music-pop").execute,
}
