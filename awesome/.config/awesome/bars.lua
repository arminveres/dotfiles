local gears = require('gears')
local lain = require('lain')
local awful = require('awful')
local wibox = require('wibox')
local bling = require('bling')
local dpi = require('beautiful.xresources').apply_dpi
local theme = require('beautiful')
theme.init(string.format('%s/.config/awesome/themes/%s/theme.lua', os.getenv('HOME'), 'multicolor'))
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility
local markup = lain.util.markup
local myutils = require('myutils')

-- Textclock
os.setlocale(os.getenv('LANG')) -- to localize the clock

local mytextclock = wibox.widget.textclock(
    markup('#7788af', '%A %d %B ') .. markup('#ab7367', '>') .. markup('#de5e1e', ' %H:%M ')
)
mytextclock.font = theme.font

-- Calendar
theme.cal = lain.widget.cal({
    attach_to = { mytextclock },
    notification_preset = {
        font = theme.font,
        fg = theme.fg_normal,
        bg = theme.bg_normal,
    },
})

-- Weather
--[[ to be set before use
local weathericon = wibox.widget.imagebox(theme.widget_weather)
theme.weather = lain.widget.weather({
    city_id = 2643743, -- placeholder (London)
    notification_preset = { font = "Terminus 10", fg = theme.fg_normal },
    weather_na_markup = markup.fontfg(theme.font, "#eca4c4", "N/A "),
    settings = function()
        descr = weather_now["weather"][1]["description"]:lower()
        units = math.floor(weather_now["main"]["temp"])
        widget:set_markup(markup.fontfg(theme.font, "#eca4c4", descr .. " @ " .. units .. "°C "))
    end
})
--]]

-- / fs
--[[ commented because it needs Gio/Glib >= 2.54 ]]
--[[ local fsicon = wibox.widget.imagebox(theme.widget_fs) ]]
--TODO: create issue on lain for fedora
local fs = lain.widget.fs({
    timeout = 60,
    notification_preset = { font = theme.font, fg = theme.fg_normal },
    settings = function()
        widget:set_markup(
            markup.fontfg(
                theme.font,
                '#80d9d8',
                string.format(' %.1f', fs_now['/'].percentage) .. '% '
            )
        )
    end,
})

-- Mail IMAP check
--[[ to be set before use
local mailicon = wibox.widget.imagebox()
theme.mail = lain.widget.imap({
    timeout  = 180,
    server   = "server",
    mail     = "mail",
    password = "keyring get mail",
    settings = function()
        if mailcount > 0 then
            mailicon:set_image(theme.widget_mail)
            widget:set_markup(markup.fontfg(theme.font, "#cccccc", mailcount .. " "))
        else
            widget:set_text("")
            --mailicon:set_image() -- not working in 4.0
            mailicon._private.image = nil
            mailicon:emit_signal("widget::redraw_needed")
            mailicon:emit_signal("widget::layout_changed")
        end
    end
})
--]]

-- CPU
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(
            markup.fontfg(theme.font, '#e33a6e', cpu_now.usage .. '% ')
            -- markup.fontcolor(theme.font, '#e33a6e', '#ff8c00', cpu_now.usage .. '% ')
        )
    end,
})

-- Coretemp
local tempicon = wibox.widget.imagebox(theme.widget_temp)
local temploc = function()
    for idx = 1, 10, 1 do
        local loc = '/sys/devices/platform/coretemp.0/hwmon/hwmon' .. idx .. '/temp1_input'
        local f = io.open(loc, 'r')
        if f ~= nil then
            return loc
        end
    end
end
local temp_widget = lain.widget.temp({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, '#f1af5f', coretemp_now .. '°C '))
    end,
    tempfile = temploc(),
    timeout = 2,
})

-- Battery
local bat = lain.widget.bat({
    settings = function()
        if bat_now.perc == 'N/A' then
            return
        end

        local perc = bat_now.perc ~= 'N/A' and bat_now.perc .. '%' or bat_now.perc
        perc = perc .. ' ' .. bat_now.time .. ' '
        if bat_now.ac_status == 1 then
            perc = '  ' .. perc
        else
            perc = '  ' .. perc
        end

        if tonumber(bat_now.perc) <= 20 then
            widget:set_markup(markup.color('#000000', '#fb4934', perc))
        else
            widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, perc))
        end
    end,
})

-- ALSA volume
local volicon = wibox.widget.imagebox(theme.widget_vol)
theme.volume = lain.widget.alsa({
    settings = function()
        if volume_now.status == 'off' then
            volume_now.level = volume_now.level .. 'M'
        end
        widget:set_markup(markup.fontfg(theme.font, '#7493d2', volume_now.level .. '% '))
    end,
})

-- Net
local netdownicon = wibox.widget.imagebox(theme.widget_netdown)
local netdowninfo = wibox.widget.textbox()
local netupicon = wibox.widget.imagebox(theme.widget_netup)
local netupinfo = lain.widget.net({
    settings = function()
        --[[ uncomment if using the weather widget
        if iface ~= "network off" and
           string.match(theme.weather.widget.text, "N/A")
        then
            theme.weather.update()
        end
        --]]

        local sent = function()
            local sent_n = tonumber(net_now.sent)
            if sent_n > 1000000 then
                return string.format('%.1fGB/s ', sent_n / 1000000)
            elseif sent_n > 1000 then
                return string.format('%.1fMB/s ', sent_n / 1000)
            end
            return string.format('%.1fKB/s ', sent_n)
        end

        local received = function()
            local received_n = tonumber(net_now.received)
            if received_n > 1000000 then
                return string.format('%.1fGB/s ', received_n / 1000000)
            elseif received_n > 1000 then
                return string.format('%.1fMB/s ', received_n / 1000)
            end
            return string.format('%.1fKB/s ', received_n)
        end

        widget:set_markup(markup.fontfg(theme.font, '#e54c62', sent()))
        netdowninfo:set_markup(markup.fontfg(theme.font, '#87af5f', received()))
    end,
})

-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local memory = lain.widget.mem({
    settings = function()
        local mem_gb
        if mem_now.used >= 1000 then
            mem_gb = string.format('%.1fG ', mem_now.used / 1000)
        else
            mem_gb = mem_now.used .. ' M '
        end
        widget:set_markup(markup.fontfg(theme.font, '#e0da37', mem_gb .. mem_now.perc .. '% '))
    end,
})

-- PlayerCTL
local playerctl_widget = wibox.widget({
    markup = '',
    align = 'center',
    valign = 'center',
    font = theme.font,
    widget = wibox.widget.textbox,
})

-- call the lib with protective wrapper, otherwise it crashes the config
local pctl_ok, playerctl = pcall(bling.signal.playerctl.lib)
if pctl_ok then
    -- Get Song Info
    playerctl:connect_signal(
        'metadata',
        function(_, title, artist, album_path, album, new, player_name)
            -- Set player name, title and artist widgets
            if player_name == 'spotify' then
                player_name = ' '
            end
            playerctl_widget:set_markup(
                markup.fontfg(theme.font, '#e0da37', player_name .. ' ' .. title .. ' - ' .. artist)
            )
        end
    )
else -- try the cli if the lib fails
    pctl_ok, playerctl = pcall(bling.signal.playerctl.cli)
    if pctl_ok then
        -- Get Song Info
        playerctl:connect_signal(
            'metadata',
            function(_, title, artist, album_path, album, new, player_name)
                -- Set player name, title and artist widgets
                if player_name == 'spotify' then
                    player_name = ' '
                end
                playerctl_widget:set_markup(
                    markup.fontfg(
                        theme.font,
                        '#e0da37',
                        player_name .. ' ' .. title .. ' - ' .. artist
                    )
                )
            end
        )
    end
end

local space = wibox.widget.textbox()
space.forced_width = dpi(18)

local M = {}
M.at_screen_connect = function(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == 'function' then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
        awful.button({}, 1, function()
            awful.layout.inc(1)
        end),
        awful.button({}, 2, function()
            awful.layout.set(awful.layout.layouts[1])
        end),
        awful.button({}, 3, function()
            awful.layout.inc(-1)
        end),
        awful.button({}, 4, function()
            awful.layout.inc(1)
        end),
        awful.button({}, 5, function()
            awful.layout.inc(-1)
        end)
    ))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist({
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = awful.util.taglist_buttons,
        style = {
            shape_border_width = dpi(0),
            -- shape_border_color = '#000000',
            shape = myutils.custom_rounded,
        },
        -- layout = {
        --     spacing = dpi(7),
        --     layout = wibox.layout.flex.horizontal,
        -- },
    })

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist({
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = awful.util.tasklist_buttons,
        style = {
            shape_border_width = dpi(1),
            shape_border_color = '#ff8c00',
            shape = myutils.custom_rounded,
        },
        layout = {
            spacing = dpi(5),
            layout = wibox.layout.flex.horizontal,
        },
    })

    -- Create the wibox
    s.topwibar = awful.wibar({
        position = 'top',
        screen = s,
        -- either increase height or add border for better distinction of tags
        height = dpi(21),
        -- border_width = dpi(1),
        -- border_color = '#000000',
        bg = theme.bg_normal,
        fg = theme.fg_normal,
    })

    -- TODO: add fixed and centralized bar elements
    -- Add widgets to the wibox
    s.topwibar:setup({
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mylayoutbox,
            space,
            s.mytaglist,
            s.mypromptbox,
        },
        --s.mytasklist, -- Middle widget
        wibox.container.place(mytextclock, 'center'),
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            --mailicon,
            --theme.mail.widget,
            -- netdownicon,
            -- netdowninfo,
            -- netupicon,
            -- netupinfo.widget,
            volicon,
            theme.volume.widget,
            memicon,
            memory.widget,
            cpuicon,
            cpu.widget,
            fs.widget,
            tempicon,
            temp_widget.widget,
            bat.widget,
        },
    })

    -- Create the bottom wibox
    s.bottomwibar = awful.wibar({
        position = 'bottom',
        screen = s,
        height = dpi(21),
        border_width = dpi(1),
        border_color = '#000000',
        bg = theme.bg_normal,
        fg = theme.fg_normal,
    })

    -- Add widgets to the bottom wibox
    s.bottomwibar:setup({
        layout = wibox.layout.align.horizontal,
        space,
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            space,
            playerctl_widget,
            space,
            wibox.widget.systray(),
            space,
        },
    })
    -- s.mywibox = awful.wibox({ position = 'left', orientation = 'north', screen = s })
    -- NOTE: https://unix.stackexchange.com/questions/252301/can-a-wibox-in-awesome-wm-be-setup-vertically
end
return M
