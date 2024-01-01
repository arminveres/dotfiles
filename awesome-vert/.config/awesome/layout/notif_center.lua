local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local helpers = require("helpers")
local lain = require("lain")
local naughty = require("naughty")
local rubato = require("mods.rubato")
local wibox = require("wibox")

local markup = lain.util.markup

-- TODO: (aver) Add rubato animation

-- notification list --

local notifs_count = 0
awesome.emit_signal("notifs::count", notifs_count)

local label = wibox.widget({
    text = "Notifications",
    align = "center",
    widget = wibox.widget.textbox,
})

local notifs_clear = wibox.widget({
    markup = markup.fg.color(beautiful.red_color, ""),
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox,
})

notifs_clear:buttons(gears.table.join(awful.button({}, 1, function()
    _G.notif_center_reset_notifs_container()
    notifs_count = 0
    awesome.emit_signal("notifs::count", notifs_count)
end)))

local notifs_empty = wibox.widget({
    forced_height = 300,
    widget = wibox.container.background,
    {
        layout = wibox.layout.flex.vertical,
        {
            markup = markup.fg.color("No notifications", beautiful.bg_urgent),
            font = beautiful.font,
            align = "center",
            valign = "center",
            widget = wibox.widget.textbox,
        },
    },
})

local notifs_container = wibox.widget({
    forced_height = 715,
    layout = require("mods.overflow").vertical,
    scrollbar_enabled = false,
    spacing = 10,
    step = 80,
})

local remove_notifs_empty = true

notif_center_reset_notifs_container = function()
    notifs_container:reset(notifs_container)
    notifs_container:insert(1, notifs_empty)
    remove_notifs_empty = true
end

notif_center_remove_notif = function(box)
    notifs_container:remove_widgets(box)

    if #notifs_container.children == 0 then
        notifs_container:insert(1, notifs_empty)
        remove_notifs_empty = true
    end
end

local create_notif = function(icon, n, width)
    local time = os.date("%H:%M:%S")

    local icon_widget = wibox.widget({
        widget = wibox.container.constraint,
        {
            widget = wibox.container.margin,
            margins = 20,
            {
                widget = wibox.widget.imagebox,
                image = icon,
                clip_shape = gears.shape.circle,
                halign = "center",
                valign = "center",
            },
        },
    })

    local title_widget = wibox.widget({
        widget = wibox.container.scroll.horizontal,
        step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
        speed = 50,
        forced_width = 200,
        {
            widget = wibox.widget.textbox,
            text = n.title,
            align = "left",
            forced_width = 200,
        },
    })

    local time_widget = wibox.widget({
        widget = wibox.container.margin,
        margins = { right = 4 },
        {
            widget = wibox.widget.textbox,
            text = time,
            align = "right",
            valign = "bottom",
        },
    })

    local text_notif = wibox.widget({
        markup = n.message,
        align = "left",
        forced_width = 165,
        widget = wibox.widget.textbox,
    })

    local box = wibox.widget({
        widget = wibox.container.background,
        forced_height = 120,
        bg = beautiful.bg_alt,
        {
            layout = wibox.layout.align.horizontal,
            icon_widget,
            {
                widget = wibox.container.margin,
                margins = 10,
                {
                    layout = wibox.layout.align.vertical,
                    {
                        layout = wibox.layout.fixed.vertical,
                        expand = "none",
                        spacing = 10,
                        {
                            layout = wibox.layout.align.horizontal,
                            title_widget,
                            nil,
                            time_widget,
                        },
                        text_notif,
                    },
                },
            },
        },
    })

    box:buttons(gears.table.join(awful.button({}, 1, function()
        _G.notif_center_remove_notif(box)
        notifs_count = notifs_count - 1
        awesome.emit_signal("notifs::count", notifs_count)
    end)))

    return box
end

notifs_container:insert(1, notifs_empty)

naughty.connect_signal("request::display", function(n)
    if #notifs_container.children == 1 and remove_notifs_empty then
        notifs_container:reset(notifs_container)
        remove_notifs_empty = false
    end

    local appicon = n.icon or n.app_icon
    if not appicon then
        appicon = beautiful.notification_icon
    end

    notifs_container:insert(1, create_notif(appicon, n, width))
    notifs_count = notifs_count + 1
    awesome.emit_signal("notifs::count", notifs_count)
end)

local notifs_count_widget = wibox.widget.textbox()

awesome.connect_signal("notifs::count", function(count)
    if count == 0 then
        notifs_count_widget.text = ""
    else
        notifs_count_widget.text = "(" .. count .. ")"
    end
end)

local notifs = wibox.widget({
    spacing = 10,
    layout = wibox.layout.fixed.vertical,
    {
        widget = wibox.container.margin,
        margins = 10,
        {
            layout = wibox.layout.align.horizontal,
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = 10,
                label,
                notifs_count_widget,
            },
            nil,
            notifs_clear,
        },
    },
    notifs_container,
})

-- main window --

local main = wibox.widget({
    widget = wibox.container.background,
    bg = beautiful.bg,
    {
        widget = wibox.container.margin,
        margins = 10,
        {
            layout = wibox.layout.fixed.vertical,
            spacing = 10,
            notifs,
        },
    },
})

local notif_center = awful.popup({
    visible = false,
    ontop = true,
    border_width = beautiful.border_width,
    border_color = beautiful.border_color_normal,
    minimum_height = 585,
    maximum_height = 585,
    minimum_width = 490,
    maximum_width = 490,
    placement = function(d)
        awful.placement.bottom_right(d, {
            honor_workarea = true,
            margins = beautiful.useless_gap * 4 + beautiful.border_width * 2,
        })
    end,
    widget = main,
    shape = helpers.rrect(beautiful.rounded),
})

-- summon functions --

awesome.connect_signal("open::notif_center", function()
    awesome.emit_signal("bar::notif_center")
    notif_center.visible = not notif_center.visible
end)

-- hide on click --

client.connect_signal("button::press", function()
    if notif_center.visible == true then
        awesome.emit_signal("open::notif_center")
    end
end)

awful.mouse.append_global_mousebinding(awful.button({}, 1, function()
    if notif_center.visible == true then
        awesome.emit_signal("open::notif_center")
    end
end))
