local beautiful     = require("beautiful")
local naughty       = require("naughty")
local gears         = require("gears")
local awful         = require("awful")
local lain          = require("lain")
local hotkeys_popup = require("awful.hotkeys_popup")

local terminal = "kitty"
local modkey   = "Mod4"
local altkey   = "Mod1"

local M = {}

M.mytable = awful.util.table or gears.table -- 4.{0,1} compatibility
M.globalkeys = M.mytable.join(
-- Destroy all notifications
    awful.key({ "Control", }, "space", function() naughty.destroy_all_notifications() end,
        { description = "destroy all notifications", group = "hotkeys" }),

    awful.key({ modkey }, 'i', function()
        awful.spawn('firefox')
    end, { description = 'firefox', group = 'shortcuts' }),
    awful.key({ modkey }, 'b', function()
        awful.spawn('nautilus')
    end, { description = 'Gnome Filebrowser', group = 'shortcuts' }),
    awful.key({ modkey }, 'z', function()
        awful.spawn('zathura')
    end, { description = 'Zathura', group = 'shortcuts' }),
    awful.key({ modkey, 'Control' }, 'o', function()
        awful.spawn.with_shell('~/.local/bin/rofi-pactl-output')
    end, { description = 'select audio sink', group = 'shortcuts' }),
    awful.key({ modkey }, 'p', function()
        awful.spawn.with_shell('~/.local/bin/rofi-xrandr-displays')
    end, { description = 'select audio sink', group = 'shortcuts' }),

    -- Take a screenshot
    awful.key({ modkey, 'Shift' }, 's', function()
        awful.util.spawn('flameshot gui -p ' .. os.getenv('HOME') .. '/Pictures/screenshots')
    end, { description = 'take a screenshot', group = 'utils' }),
    awful.key({ modkey, 'Shift' }, 'p', function()
        awful.util.spawn('flameshot gui --clipboard')
    end, { description = 'take a screenshot', group = 'utils' }),

    -- Show help
    awful.key({ modkey, }, "s", hotkeys_popup.show_help,
        { description = "show help", group = "awesome" }),

    -- Tag browsing
    awful.key({ modkey, }, "Left", awful.tag.viewprev,
        { description = "view previous", group = "tag" }),
    awful.key({ modkey, }, "Right", awful.tag.viewnext,
        { description = "view next", group = "tag" }),
    awful.key({ modkey, }, "Escape", awful.tag.history.restore,
        { description = "go back", group = "tag" }),

    awful.key({ altkey }, "Escape", function()
        local locker = "i3lock-blur && xset dpms force off"
        awful.menu({
            { "Powermenu" },
            { "&l lock", function() awful.spawn.with_shell(locker) end },
            { "&e quit", function() awesome.quit() end },
            { "&s suspend", function() awful.spawn.with_shell(locker .. " && systemctl suspend") end },
            { "&h hibernate", function() awful.spawn.with_shell(locker .. " && systemctl hibernate") end },
            { "&r reboot", function() awful.spawn.with_shell("systemctl reboot") end },
            { "&p poweroff", function() awful.spawn.with_shell("systemctl poweroff") end },
        }):toggle()
    end,
        { description = "get powermenu", group = "awesome" }),

    -- Non-empty tag browsing
    awful.key({ altkey }, "Left", function() lain.util.tag_view_nonempty(-1) end,
        { description = "view  previous nonempty", group = "tag" }),
    awful.key({ altkey }, "Right", function() lain.util.tag_view_nonempty(1) end,
        { description = "view  previous nonempty", group = "tag" }),

    -- Default client focus
    awful.key({ modkey, }, "j",
        function()
            awful.client.focus.byidx(1)
        end,
        { description = "focus next by index", group = "client" }
    ),
    awful.key({ modkey, }, "k",
        function()
            awful.client.focus.byidx(-1)
        end,
        { description = "focus previous by index", group = "client" }
    ),

    -- By-direction client focus
    --[[
    awful.key({ modkey }, "j",
        function()
            awful.client.focus.global_bydirection("down")
            if client.focus then client.focus:raise() end
        end,
        { description = "focus down", group = "client" }),
    awful.key({ modkey }, "k",
        function()
            awful.client.focus.global_bydirection("up")
            if client.focus then client.focus:raise() end
        end,
        { description = "focus up", group = "client" }),
    awful.key({ modkey }, "h",
        function()
            awful.client.focus.global_bydirection("left")
            if client.focus then client.focus:raise() end
        end,
        { description = "focus left", group = "client" }),
    awful.key({ modkey }, "l",
        function()
            awful.client.focus.global_bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        { description = "focus right", group = "client" }),
        ]]

    -- Menu
    awful.key({ modkey, }, "w", function() awful.util.mymainmenu:show() end,
        { description = "show main menu", group = "awesome" }),

    awful.key({ modkey }, 'Tab', function()
        awesome.emit_signal('bling::window_switcher::turn_on')
    end, { description = 'Workspace local window switcher', group = 'client' }),
    awful.key({ altkey }, 'Tab', function()
        awful.spawn.with_shell('rofi -show window')
    end, { description = 'Global window switcher', group = 'client' }),

    -- Layout manipulation
    awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end,
        { description = "swap with next client by index", group = "client" }),
    awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end,
        { description = "swap with previous client by index", group = "client" }),
    --[[
    awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative(1) end,
        { description = "focus the next screen", group = "screen" }),
    awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end,
        { description = "focus the previous screen", group = "screen" }),
]]
    awful.key({ modkey, }, "u", awful.client.urgent.jumpto,
        { description = "jump to urgent client", group = "client" }),

    -- Show/hide wibox
    awful.key({ altkey }, "b", function()
        for s in screen do
            s.mywibox.visible = not s.mywibox.visible
            if s.mybottomwibox then
                s.mybottomwibox.visible = not s.mybottomwibox.visible
            end
        end
    end,
        { description = "toggle wibox", group = "awesome" }),

    -- Multi Monitor setup
    awful.key({ modkey }, 'o', function()
        awful.screen.focus_relative(1)
    end, { description = 'focus the next screen', group = 'screen' }),

    -- On-the-fly useless gaps change
    --[[
    awful.key({ altkey, "Control" }, "+", function() lain.util.useless_gaps_resize(1) end,
        { description = "increment useless gaps", group = "tag" }),
    awful.key({ altkey, "Control" }, "-", function() lain.util.useless_gaps_resize(-1) end,
        { description = "decrement useless gaps", group = "tag" }),
]]
    -- Dynamic tagging
    --[[
    awful.key({ modkey, "Shift" }, "n", function() lain.util.add_tag() end,
        { description = "add new tag", group = "tag" }),
    awful.key({ modkey, "Shift" }, "r", function() lain.util.rename_tag() end,
        { description = "rename tag", group = "tag" }),
    awful.key({ modkey, "Shift" }, "Left", function() lain.util.move_tag(-1) end,
        { description = "move tag to the left", group = "tag" }),
    awful.key({ modkey, "Shift" }, "Right", function() lain.util.move_tag(1) end,
        { description = "move tag to the right", group = "tag" }),
    awful.key({ modkey, "Shift" }, "d", function() lain.util.delete_tag() end,
        { description = "delete tag", group = "tag" }),
]]
    -- Standard program
    awful.key({ modkey, }, "Return", function() awful.spawn(terminal) end,
        { description = "open a terminal", group = "launcher" }),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
        { description = "reload awesome", group = "awesome" }),
    --[[
    awful.key({ modkey, "Shift" }, "q", awesome.quit,
        { description = "quit awesome", group = "awesome" }),
]]
    awful.key({ modkey }, 'l', function()
        awful.tag.incmwfact(0.05)
    end, { description = 'increase master width factor', group = 'layout' }),
    awful.key({ modkey }, 'h', function()
        awful.tag.incmwfact(-0.05)
    end, { description = 'decrease master width factor', group = 'layout' }),
    awful.key({ modkey, 'Shift' }, 'h', function()
        awful.tag.incnmaster(1, nil, true)
    end, { description = 'increase the number of master clients', group = 'layout' }),
    awful.key({ modkey, 'Shift' }, 'l', function()
        awful.tag.incnmaster(-1, nil, true)
    end, { description = 'decrease the number of master clients', group = 'layout' }),
    awful.key({ modkey, 'Control' }, 'h', function()
        awful.tag.incncol(1, nil, true)
    end, { description = 'increase the number of columns', group = 'layout' }),
    awful.key({ modkey, 'Control' }, 'l', function()
        awful.tag.incncol(-1, nil, true)
    end, { description = 'decrease the number of columns', group = 'layout' }),

    awful.key({ modkey, }, "space", function() awful.layout.inc(1) end,
        { description = "select next", group = "layout" }),
    awful.key({ modkey, "Shift" }, "space", function() awful.layout.inc(-1) end,
        { description = "select previous", group = "layout" }),

    awful.key({ modkey, "Control" }, "n", function()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
            c:emit_signal("request::activate", "key.unminimize", { raise = true })
        end
    end, { description = "restore minimized", group = "client" }),

    -- Dropdown application
    awful.key({ modkey, }, "z", function() awful.screen.focused().quake:toggle() end,
        { description = "dropdown application", group = "launcher" }),

    -- Widgets popups
    awful.key({ altkey, }, "c", function() if beautiful.cal then beautiful.cal.show(7) end end,
        { description = "show calendar", group = "widgets" }),
    awful.key({ altkey, }, "h", function() if beautiful.fs then beautiful.fs.show(7) end end,
        { description = "show filesystem", group = "widgets" }),
    awful.key({ altkey, }, "w", function() if beautiful.weather then beautiful.weather.show(7) end end,
        { description = "show weather", group = "widgets" }),

    awful.key({ modkey }, 'r', function()
        awful.spawn.with_shell('rofi -show drun')
    end, { description = 'rofi app launcher', group = 'awesome' }),

    --[[
    -- ALSA volume control
    awful.key({ altkey }, "Up",
        function()
            os.execute(string.format("amixer -q set %s 1%%+", beautiful.volume.channel))
            beautiful.volume.update()
        end,
        { description = "volume up", group = "hotkeys" }),
    awful.key({ altkey }, "Down",
        function()
            os.execute(string.format("amixer -q set %s 1%%-", beautiful.volume.channel))
            beautiful.volume.update()
        end,
        { description = "volume down", group = "hotkeys" }),
    awful.key({ altkey }, "m",
        function()
            os.execute(string.format("amixer -q set %s toggle",
                beautiful.volume.togglechannel or beautiful.volume.channel))
            beautiful.volume.update()
        end,
        { description = "toggle mute", group = "hotkeys" }),
    awful.key({ altkey, "Control" }, "m",
        function()
            os.execute(string.format("amixer -q set %s 100%%", beautiful.volume.channel))
            beautiful.volume.update()
        end,
        { description = "volume 100%", group = "hotkeys" }),
    awful.key({ altkey, "Control" }, "0",
        function()
            os.execute(string.format("amixer -q set %s 0%%", beautiful.volume.channel))
            beautiful.volume.update()
        end,
        { description = "volume 0%", group = "hotkeys" }),

    -- MPD control
    awful.key({ altkey, "Control" }, "Up",
        function()
            os.execute("mpc toggle")
            beautiful.mpd.update()
        end,
        { description = "mpc toggle", group = "widgets" }),
    awful.key({ altkey, "Control" }, "Down",
        function()
            os.execute("mpc stop")
            beautiful.mpd.update()
        end,
        { description = "mpc stop", group = "widgets" }),
    awful.key({ altkey, "Control" }, "Left",
        function()
            os.execute("mpc prev")
            beautiful.mpd.update()
        end,
        { description = "mpc prev", group = "widgets" }),
    awful.key({ altkey, "Control" }, "Right",
        function()
            os.execute("mpc next")
            beautiful.mpd.update()
        end,
        { description = "mpc next", group = "widgets" }),
    awful.key({ altkey }, "0",
        function()
            local common = { text = "MPD widget ", position = "top_middle", timeout = 2 }
            if beautiful.mpd.timer.started then
                beautiful.mpd.timer:stop()
                common.text = common.text .. lain.util.markup.bold("OFF")
            else
                beautiful.mpd.timer:start()
                common.text = common.text .. lain.util.markup.bold("ON")
            end
            naughty.notify(common)
        end,
        { description = "mpc on/off", group = "widgets" }),
]]

    -- Audio
    awful.key({}, 'XF86AudioRaiseVolume', function()
        awful.spawn('pactl set-sink-volume @DEFAULT_SINK@ +5%')

        beautiful.volume.update()
    end, { description = 'Raise Volume', group = 'audio' }),
    awful.key({}, 'XF86AudioLowerVolume', function()
        awful.spawn('pactl set-sink-volume @DEFAULT_SINK@ -5%')
        beautiful.volume.update()
    end, { description = 'Lower Volume', group = 'audio' }),
    awful.key({}, 'XF86AudioMute', function()
        awful.spawn('pactl set-sink-mute @DEFAULT_SINK@ toggle')
        beautiful.volume.update()
    end, { description = 'Toggle Mute', group = 'audio' }),
    awful.key({}, 'XF86AudioMicMute', function()
        awful.spawn('pactl set-source-mute @DEFAULT_SOURCE@')
    end, { description = 'Toggle Mic Mute', group = 'audio' }),
    awful.key({}, 'XF86AudioPlay', function()
        awful.spawn('playerctl play-pause')
    end, { description = 'Play/Pause', group = 'media' }),
    awful.key({}, 'XF86AudioNext', function()
        awful.spawn('playerctl next')
    end, { description = 'Next', group = 'media' }),
    awful.key({}, 'XF86AudioPrev', function()
        awful.spawn('playerctl previous')
    end, { description = 'Previous', group = 'media' }),

    -- Display brightness
    -- TODO: Add check for laptop
    -- awful.key({}, 'XF86MonBrightnessUp', function()
    --     awful.spawn.with_shell('ddccontrol -r 0x10 -W +10 dev:/dev/i2c-7')
    -- end, { description = 'Increase brightness on main display', group = 'display' }),
    -- awful.key({}, 'XF86MonBrightnessDown', function()
    --     awful.spawn.with_shell('ddccontrol -r 0x10 -W -10 dev:/dev/i2c-7')
    -- end, { description = 'Decrease brightness on main display', group = 'display' }),

    awful.key({}, 'XF86MonBrightnessUp', function()
        awful.spawn.with_shell('light -A 5')
    end, { description = 'Increase brightness on main display', group = 'display' }),
    awful.key({}, 'XF86MonBrightnessDown', function()
        awful.spawn.with_shell('light -U 5')
    end, { description = 'Decrease brightness on main display', group = 'display' }),

    -- Copy primary to clipboard (terminals to gtk)
    awful.key({ modkey }, "c", function() awful.spawn.with_shell("xsel | xsel -i -b") end,
        { description = "copy terminal to gtk", group = "hotkeys" }),
    -- Copy clipboard to primary (gtk to terminals)
    awful.key({ modkey }, "v", function() awful.spawn.with_shell("xsel -b | xsel") end,
        { description = "copy gtk to terminal", group = "hotkeys" }),

    -- Prompt
    --[[
    awful.key({ modkey }, "r", function() awful.screen.focused().mypromptbox:run() end,
        { description = "run prompt", group = "launcher" }),
]]

    awful.key({ modkey }, "x",
        function()
            awful.prompt.run {
                prompt       = "Run Lua code: ",
                textbox      = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval"
            }
        end,
        { description = "lua execute prompt", group = "awesome" })

--]]
)

M.clientkeys = M.mytable.join(
    awful.key({ altkey, "Shift" }, "m", lain.util.magnify_client,
        { description = "magnify client", group = "client" }),
    awful.key({ modkey, }, "f",
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        { description = "toggle fullscreen", group = "client" }),
    awful.key({ modkey, "Shift" }, "c", function(c) c:kill() end,
        { description = "close", group = "client" }),
    awful.key({ modkey, 'Shift' }, 'o', function(c)
        c:move_to_screen()
    end, { description = 'move to screen', group = 'client' }),
    awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle,
        { description = "toggle floating", group = "client" }),
    awful.key({ modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end,
        { description = "move to master", group = "client" }),
    awful.key({ modkey, }, "t", function(c) c.ontop = not c.ontop end,
        { description = "toggle keep on top", group = "client" }),
    awful.key({ modkey, }, "n",
        function(c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end,
        { description = "minimize", group = "client" }),
    awful.key({ modkey, }, "m",
        function(c)
            c.maximized = not c.maximized
            c:raise()
        end,
        { description = "(un)maximize", group = "client" }),
    awful.key({ modkey, "Control" }, "m",
        function(c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end,
        { description = "(un)maximize vertically", group = "client" }),
    awful.key({ modkey, "Shift" }, "m",
        function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end,
        { description = "(un)maximize horizontally", group = "client" })
)

return M
