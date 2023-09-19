local M = {}

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
local bar_modules = require('bar-modules')

-- Textclock
os.setlocale(os.getenv('LANG')) -- to localize the clock

local mytextclock = wibox.widget.textclock(
    markup('#7788af', '%A %d %B ') .. markup('#ab7367', '>') .. markup('#de5e1e', ' %H:%M')
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

local brightness_widget = require('awesome-wm-widgets.brightness-widget.brightness')
local spotify_widget = require('awesome-wm-widgets.spotify-widget.spotify')

local space = wibox.widget.textbox()
space.forced_width = dpi(18)

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
            shape_border_color = '#000000',
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
            shape_border_color = theme.bg_focus,
            shape = myutils.custom_rounded,
        },
        layout = {
            spacing = dpi(10),
            layout = wibox.layout.flex.horizontal,
            max_widget_size = 200,
        },
    })

    local transparency = 'FF'
    -- Create the wibox
    s.mainbar = awful.wibar({
        position = 'bottom',
        screen = s,
        -- either increase height or add border for better distinction of tags
        height = dpi(21),
        border_width = dpi(5),
        border_color = '#000000' .. transparency,
        bg = theme.bg_normal .. transparency,
        fg = theme.fg_normal,
    })

    -- TODO: add fixed and centralized bar elements
    -- Add widgets to the wibox
    s.mainbar:setup({
        layout = wibox.layout.align.horizontal,
        {
            -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mylayoutbox,
            space,
            s.mytaglist,
            s.mypromptbox,
            space,
        },
        s.mytasklist, -- Middle widget
        -- wibox.container.place(mytextclock, 'center'),
        {
            -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            space,
            spotify_widget({
                play_icon = '/usr/share/icons/Papirus/24x24/categories/spotify.svg',
                pause_icon = '/usr/share/icons/Papirus/24x24/panel/spotify-indicator.svg',
                font = theme.font,
            }), -- playerctl_widget, --  NOTE: (aver) replaced with spotify widget
            space,
            bar_modules.volicon,
            theme.volume.widget,
            -- space,
            -- bar_modules.ip_widget,
            -- bar_modules.memicon,
            -- bar_modules.memory.widget,
            -- bar_modules.cpuicon,
            -- bar_modules.cpu.widget,
            -- bar_modules.fs.widget,
            -- bar_modules.tempicon,
            -- bar_modules.temp_widget.widget,
            space,
            mytextclock,
            space,
            wibox.widget.systray(),
            space,
        },
    })

    --[[
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
            spotify_widget({
                play_icon = '/usr/share/icons/Papirus/24x24/categories/spotify.svg',
                pause_icon = '/usr/share/icons/Papirus/24x24/panel/spotify-indicator.svg',
                font = theme.font,
            }), -- playerctl_widget, --  NOTE: (aver) replaced with spotify widget
            space,
            wibox.widget.systray(),
            space,
        },
    })
    -- s.mywibox = awful.wibox({ position = 'left', orientation = 'north', screen = s })
    -- NOTE: https://unix.stackexchange.com/questions/252301/can-a-wibox-in-awesome-wm-be-setup-vertically
    --]]
end
return M
