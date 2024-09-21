local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local gears = require("gears")
local helpers = require("helpers")
local theme = require("theme.colors.dark")
local wibox = require("wibox")

local tasklist_buttons = gears.table.join(
    awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal("request::activate", "tasklist", { raise = true })
        end
    end),
    awful.button({}, 3, function()
        awful.menu.client_list({ theme = { width = 250, font = "Roboto Bold 10" } })
    end),
    awful.button({}, 4, function()
        awful.client.focus.byidx(1)
    end),
    awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
    end)
)
return function(s)
    local tasklist = awful.widget.tasklist({
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        style = {
            shape_border_width = dpi(1),
            shape_border_color = theme.bg_color,
            shape_border_color_focus = theme.accent,
            shape = helpers.rrect(4),
        },
        layout = {
            spacing = dpi(10),
            layout = wibox.layout.flex.vertical,
            max_widget_size = 100,
        },
    })
    return tasklist
end
