-- keybinds haha
-- ~~~~~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~
local awful = require("awful")
local bling = require("mods.bling")
local helpers = require("helpers")
local hotkeys_popup = require("awful.hotkeys_popup")
local lain = require("lain")
local lmachi = require("mods.layout-machi")
local misc = require("misc")

-- modkey
local modkey = "Mod4"

-- modifer keys
local shift = "Shift"
local ctrl = "Control"
local alt = "Mod1"

-- Configurations
-- ~~~~~~~~~~~~~~

-- NOTE: we do not want scroll behaviour
-- mouse keybindings
-- awful.mouse.append_global_mousebindings({
--     awful.button({}, 4, awful.tag.viewprev),
--     awful.button({}, 5, awful.tag.viewnext),
-- })

-- launchers
awful.keyboard.append_global_keybindings({

    awful.key({ modkey }, "Return", function()
        awful.spawn(USER_PREF.term)
    end, { description = "open terminal", group = "launcher" }),

    awful.key({ modkey }, "i", function()
        awful.spawn.with_shell(USER_PREF.web)
    end, { description = "open web browser", group = "launcher" }),

    awful.key({ modkey }, "b", function()
        awful.spawn.with_shell(USER_PREF.files)
    end, { description = "open file browser", group = "launcher" }),

    awful.key({ modkey }, "r", function()
        awful.spawn.with_shell("rofi -show drun")
    end, { description = "open rofi", group = "launcher" }),

    awful.key({ modkey }, "a", function()
        cc_toggle(screen.primary)
    end, { description = "toggle control center", group = "launcher" }),

    awful.key({ modkey, ctrl }, "o", function()
        awesome.emit_signal("open::notif_center")
    end, { description = "Open Notification Center", group = "launcher" }),

    -- Take a screenshot
    awful.key({ modkey, "Shift" }, "s", function()
        awful.util.spawn("flameshot gui -p " .. os.getenv("HOME") .. "/Pictures/screenshots/")
    end, { description = "take a screenshot", group = "utils" }),

    awful.key({ modkey, "Shift" }, "p", function()
        awful.util.spawn("flameshot gui --clipboard")
    end, { description = "take a screenshot", group = "utils" }),

    awful.key({ modkey }, "F3", function()
        awful.spawn.with_shell("autorandr --load default")
        -- awful.spawn.with_shell("nitrogen --restore")
    end, { description = "Turn on the secondary monitor", group = "utils" }),

    awful.key({ modkey }, "F4", function()
        awful.spawn.with_shell("autorandr --load secoff")
        -- awful.spawn.with_shell("nitrogen --restore")
    end, { description = "turn off secondary monitor", group = "utils" }),

    awful.key({ modkey }, "p", function()
        awful.spawn.with_shell("rofi-pactl-output")
    end, { description = "show audio output", group = "launcher" }),

    awful.key({ modkey }, "z", function()
        awful.spawn.with_shell("rofi-zathura")
    end, { description = "show pdf picker", group = "launcher" }),

    -- awful.key({ modkey }, "s", function()
    -- 	awful.spawn(user_likes.music)
    -- end,
    --    { description = "launch music client", group = "launcher" }),

    -- awful.key({ modkey }, "r", function()
    --        awful.spawn(home_var .. "/.scripts/picker", false)
    -- end,
    --    { description = "exec color picker", group = "launcher" }),
})

-- control/media
awful.keyboard.append_global_keybindings({

    awful.key({}, "XF86MonBrightnessUp", function()
        if os.getenv("HOSTNAME") == "fedoraarmin" then
            -- This is the Dell monitor
            -- awful.spawn.with_shell('ddccontrol -r 0x10 -W +10 dev:/dev/i2c-7')
            -- This is the LG monitor
            awful.spawn.with_shell("ddccontrol -r 0x10 -W +10 dev:/dev/i2c-6")
        else -- Laptop or general control
            awful.spawn.with_shell("light -A 5")
        end
    end, { description = "increase brightness", group = "control" }),

    awful.key({}, "XF86MonBrightnessDown", function()
        if os.getenv("HOSTNAME") == "fedoraarmin" then
            -- This is the dell monitor
            -- awful.spawn.with_shell('ddccontrol -r 0x10 -W -10 dev:/dev/i2c-7')
            -- This is the LG monitor
            awful.spawn.with_shell("ddccontrol -r 0x10 -W -10 dev:/dev/i2c-6")
        else -- Laptop or general control
            awful.spawn.with_shell("light -U 5")
        end
    end, { description = "decrease brightness", group = "control" }),

    awful.key({}, "XF86AudioRaiseVolume", function()
        -- awful.spawn("amixer -D pulse set Master 5%+", false)
        awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")
    end, { description = "increase volume", group = "control" }),

    awful.key({}, "XF86AudioLowerVolume", function()
        -- awful.spawn("amixer -D pulse set Master 5%-", false)
        awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")
    end, { description = "decrease volume", group = "control" }),

    awful.key({}, "XF86AudioMute", function()
        -- awful.spawn("amixer -D pulse set Master 1+ toggle", false)
        awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")
    end, { description = "mute volume", group = "control" }),

    awful.key({}, "XF86AudioMicMute", function()
        awful.spawn("pactl set-source-mute @DEFAULT_SOURCE@")
    end, { description = "Toggle Mic Mute", group = "audio" }),

    awful.key({}, "XF86AudioPlay", function()
        awful.spawn("playerctl play-pause")
    end, { description = "Play/Pause", group = "media" }),

    awful.key({}, "XF86AudioNext", function()
        awful.spawn("playerctl next")
    end, { description = "Next", group = "media" }),

    awful.key({}, "XF86AudioPrev", function()
        awful.spawn("playerctl previous")
    end, { description = "Previous", group = "media" }),

    awful.key({ modkey }, "F2", function()
        misc.musicMenu()
    end, { description = "music menu", group = "control" }),
})

-- awesome yeah!
awful.keyboard.append_global_keybindings({

    awful.key(
        { modkey },
        "F1",
        hotkeys_popup.show_help,
        { description = "show this help window", group = "awesome" }
    ),

    awful.key(
        { modkey, ctrl },
        "r",
        awesome.restart,
        { description = "reload awesome", group = "awesome" }
    ),

    awful.key(
        { modkey, shift },
        "e",
        awesome.quit,
        { description = "quit awesome", group = "awesome" }
    ),

    -- awful.key({ modkey }, "v", function()
    awful.key({ alt }, "Escape", function()
        require("mods.exit-screen")
        awesome.emit_signal("module::exit_screen:show")
    end, { description = "show exit screen", group = "modules" }),

    -- NOTE: duplicate
    -- awful.key(
    --     { modkey, shift },
    --     "c",
    --     awesome.restart,
    --     { description = "reload awesome", group = "awesome" }
    -- ),
})

-- Tags related keybindings
awful.keyboard.append_global_keybindings({
    awful.key(
        { modkey },
        "Escape",
        awful.tag.history.restore,
        { description = "go back", group = "tags" }
    ),
    -- Tag browsing
    awful.key(
        { modkey },
        "Left",
        awful.tag.viewprev,
        { description = "view previous", group = "tags" }
    ),
    awful.key(
        { modkey },
        "Right",
        awful.tag.viewnext,
        { description = "view next", group = "tags" }
    ),
    -- -- Non-empty tag browsing
    awful.key({ alt }, "Left", function()
        lain.util.tag_view_nonempty(-1)
    end, { description = "view  previous nonempty", group = "tag" }),

    awful.key({ alt }, "Right", function()
        lain.util.tag_view_nonempty(1)
    end, { description = "view  previous nonempty", group = "tag" }),
})

-- Focus related keybindings
awful.keyboard.append_global_keybindings({
    -- By-direction client focus but cycle if in maxxed layout
    awful.key({ modkey }, "j", function()
        local layout = awful.layout.get(awful.screen.focused())
        if layout == awful.layout.suit.max then
            awful.client.focus.byidx(1)
        else
            awful.client.focus.global_bydirection("down")
        end
        if client.focus then
            client.focus:raise()
        end
        bling.module.flash_focus.flashfocus(client.focus)
    end, { description = "focus down", group = "client" }),

    awful.key({ modkey }, "k", function()
        local layout = awful.layout.get(awful.screen.focused())
        if layout == awful.layout.suit.max then
            awful.client.focus.byidx(-1)
        else
            awful.client.focus.global_bydirection("up")
        end
        if client.focus then
            client.focus:raise()
        end
        bling.module.flash_focus.flashfocus(client.focus)
    end, { description = "focus up", group = "client" }),

    awful.key({ modkey }, "h", function()
        awful.client.focus.global_bydirection("left")
        if client.focus then
            client.focus:raise()
        end
        bling.module.flash_focus.flashfocus(client.focus)
    end, { description = "focus left", group = "client" }),

    awful.key({ modkey }, "l", function()
        awful.client.focus.global_bydirection("right")
        if client.focus then
            client.focus:raise()
        end
        bling.module.flash_focus.flashfocus(client.focus)
    end, { description = "focus right", group = "client" }),

    awful.key({ modkey }, "Tab", function()
        awesome.emit_signal("bling::window_switcher::turn_on")
    end, { description = "window switcher", group = "client" }),

    awful.key({ modkey, ctrl }, "n", function()
        local c = awful.client.restore()
        if c then
            c:activate({ raise = true, context = "key.unminimize" })
        end
    end, { description = "restore minimized", group = "client" }),

    -- Layout manipulation
    awful.key({ modkey, "Shift" }, "h", function()
        awful.client.swap.bydirection("left")
    end, { description = "swap client to the left", group = "client" }),

    awful.key({ modkey, "Shift" }, "j", function()
        awful.client.swap.bydirection("down")
    end, { description = "swap client downwars", group = "client" }),

    awful.key({ modkey, "Shift" }, "k", function()
        awful.client.swap.bydirection("up")
    end, { description = "swap client upwards", group = "client" }),

    awful.key({ modkey, "Shift" }, "l", function()
        awful.client.swap.bydirection("right")
    end, { description = "swap client to the right", group = "client" }),

    awful.key(
        { modkey },
        "u",
        awful.client.urgent.jumpto,
        { description = "jump to urgent client", group = "client" }
    ),

    -- Multi Monitor setup
    --
    --
    -- awful.key({ modkey, ctrl }, "j", function()
    --     awful.screen.focus_relative(1)
    -- end, { description = "focus the next screen", group = "screen" }),

    -- awful.key({ modkey, ctrl }, "k", function()
    --     awful.screen.focus_relative(-1)
    -- end, { description = "focus the previous screen", group = "screen" }),

    awful.key({ modkey }, "o", function()
        awful.screen.focus_relative(1)
    end, { description = "focus the next screen", group = "screen" }),
})

-- Layout related keybindings
awful.keyboard.append_global_keybindings({

    -- awful.key({ modkey }, "l", function()
    --     awful.tag.incmwfact(0.05)
    -- end, { description = "increase master width factor", group = "layout" }),

    -- awful.key({ modkey }, "h", function()
    --     awful.tag.incmwfact(-0.05)
    -- end, { description = "decrease master width factor", group = "layout" }),

    awful.key({ alt }, "l", function()
        awful.tag.incmwfact(0.05)
    end, { description = "increase master width factor", group = "layout" }),

    awful.key({ alt }, "h", function()
        awful.tag.incmwfact(-0.05)
    end, { description = "decrease master width factor", group = "layout" }),

    -- awful.key({ modkey, shift }, "h", function()
    --     awful.tag.incnmaster(1, nil, true)
    -- end, { description = "increase the number of master clients", group = "layout" }),

    -- awful.key({ modkey, shift }, "l", function()
    --     awful.tag.incnmaster(-1, nil, true)
    -- end, { description = "decrease the number of master clients", group = "layout" }),

    awful.key({ modkey, ctrl }, "h", function()
        awful.tag.incncol(1, nil, true)
    end, { description = "increase the number of columns", group = "layout" }),

    awful.key({ modkey, ctrl }, "l", function()
        awful.tag.incncol(-1, nil, true)
    end, { description = "decrease the number of columns", group = "layout" }),

    awful.key({ modkey }, "space", function()
        awful.layout.inc(1)
    end, { description = "select next", group = "layout" }),

    awful.key({ modkey, shift }, "space", function()
        awful.layout.inc(-1)
    end, { description = "select previous", group = "layout" }),

    -- layout machi
    awful.key({ modkey }, ".", function()
        lmachi.default_editor.start_interactive()
    end, { description = "edit current layout", group = "layout" }),

    awful.key({ modkey, shift }, ".", function()
        lmachi.switcher.start(client.focus)
    end, { description = "switch between windows for a machi layout", group = "layout" }),
})

-- tag related keys
awful.keyboard.append_global_keybindings({
    awful.key({
        modifiers = { modkey },
        keygroup = "numrow",
        description = "only view tag",
        group = "tag",
        on_press = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    }),

    awful.key({
        modifiers = { modkey, ctrl },
        keygroup = "numrow",
        description = "toggle tag",
        group = "tag",
        on_press = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    }),

    awful.key({
        modifiers = { modkey, shift },
        keygroup = "numrow",
        description = "move focused client to tag",
        group = "tag",
        on_press = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    }),

    awful.key({
        modifiers = { modkey, ctrl, shift },
        keygroup = "numrow",
        description = "toggle focused client on tag",
        group = "tag",
        on_press = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
    }),

    -- awful.key({
    --     modifiers = { modkey },
    --     keygroup = "numpad",
    --     description = "select layout directly",
    --     group = "layout",
    --     on_press = function(index)
    --         local t = awful.screen.focused().selected_tag
    --         if t then
    --             t.layout = t.layouts[index] or t.layout
    --         end
    --     end,
    -- }),
})

-- mouse mgmt
client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({

        awful.button({}, 1, function(c)
            c:activate({ context = "mouse_click" })
        end),

        awful.button({ modkey }, 1, function(c)
            c:activate({ context = "mouse_click", action = "mouse_move" })
        end),

        awful.button({ modkey }, 3, function(c)
            c:activate({ context = "mouse_click", action = "mouse_resize" })
        end),
    })
end)

-- client mgmt
client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        awful.key({ modkey }, "f", function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end, { description = "toggle fullscreen", group = "client" }),

        awful.key({ modkey, shift }, "c", function(c)
            c:kill()
        end, { description = "close", group = "client" }),

        awful.key(
            { modkey },
            "c",
            helpers.mc,
            { description = "magnify client", group = "client" }
        ),

        awful.key(
            { modkey },
            "x",
            awful.client.floating.toggle,
            { description = "toggle floating", group = "client" }
        ),

        awful.key({ modkey, ctrl }, "Return", function(c)
            c:swap(awful.client.getmaster())
        end, { description = "move to master", group = "client" }),

        awful.key({ modkey, shift }, "o", function(c)
            c:move_to_screen()
        end, { description = "move to screen", group = "client" }),

        awful.key({ modkey }, "t", function(c)
            c.ontop = not c.ontop
        end, { description = "toggle keep on top", group = "client" }),

        awful.key({ modkey }, "n", function(c)
            c.minimized = true
        end, { description = "minimize", group = "client" }),

        awful.key({ modkey }, "m", function(c)
            c.maximized = not c.maximized
            c:raise()
        end, { description = "(un)maximize", group = "client" }),
    })
end)
