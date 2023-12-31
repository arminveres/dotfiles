-- rules
-- ~~~~~

-- requirements
-- ~~~~~~~~~~~~
local awful = require("awful")
local beautiful = require("beautiful")
local ruled = require("ruled")

-- Configurations
-- ~~~~~~~~~~~~~~

-- connect to signal
ruled.client.connect_signal("request::rules", function()
    -- Global
    ruled.client.append_rule({
        id = "global",
        rule = {},
        properties = {
            focus = awful.client.focus.filter,
            raise = true,
            size_hints_honor = false,
            screen = awful.screen.preferred,
            titlebars_enabled = false,
            placement = awful.placement.centered
                + awful.placement.no_overlap
                + awful.placement.no_offscreen,
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
        },
    })

    -- tasklist order
    ruled.client.append_rule({
        id = "tasklist_order",
        rule = {},
        properties = {},
        callback = awful.client.setslave,
    })

    -- Floating
    ruled.client.append_rule({
        id = "floating",
        rule_any = {
            class = {
                "Sxiv",
                "Zathura",
                "Galculator",
                "Xarchiver",
                "gnome-calculator",
                "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                "origin.exe",
                "zoom",
                "Cisco AnyConnect Secure Mobility Client",
                "Matplotlib",
                "matplotlib",
                "Gnome-Pomodoro",
            },
            role = {
                "AlarmWindow", -- Thunderbird's calendar.
                "ConfigManager", -- Thunderbird's about:config.
                "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
                "Network Connections",
            },
            name = {
                "Event Tester", -- xev.
            },
            instance = {
                "spad",
                "music",
                -- "discord",
            },
        },
        properties = { floating = true, placement = awful.placement.centered },
    })

    -- Borders
    ruled.client.append_rule({
        id = "borders",
        rule_any = { type = { "normal", "dialog" } },
        except_any = {
            role = { "Popup" },
            type = { "splash" },
            name = { "^discord.com is sharing your screen.$" },
        },
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
        },
    })

    -- Center Placement
    ruled.client.append_rule({
        id = "center_placement",
        rule_any = {
            type = { "dialog" },
            class = { "Steam", "discord", "markdown_input", "nemo", "thunar" },
            instance = { "markdown_input" },
            role = { "GtkFileChooserDialog" },
        },
        properties = { placement = awful.placement.center },
    })

    -- Titlebar rules
    ruled.client.append_rule({
        id = "titlebars",
        rule_any = {
            type = {
                "dialog",
                "splash",
            },
            name = {
                "^discord.com is sharing your screen.$",
                "file_progress",
            },
        },
        properties = { titlebars_enabled = false },
    })
end)

-- applications
ruled.client.append_rules({
    {
        rule_any = { class = { "music" }, instance = { "music" } },
        properties = {
            floating = true,
            width = 700,
            height = 444,
        },
    },
    {
        rule_any = { class = { "Zotero" } },
        properties = { tag = "3", minimized = false },
    },
    {
        rule_any = { class = { "Spotify", "Blueman-manager", "easyeffects" } },
        properties = { tag = "4", minimized = false },
    },
    {
        rule_any = { class = { "Geary", "thunderbird", "mail" } },
        properties = { tag = "5" },
    },
    {
        rule_any = { class = { "steam", "Steam", "Lutris" } },
        properties = { tag = "6" },
    },
    {
        rule_any = { class = { "qBittorrent", "qbittorrent" } },
        properties = { tag = "7" },
    },
    {
        rule_any = { class = { "corectrl", "virt-manager", "Virt-manager" } },
        properties = { tag = "8" },
    },
    {
        rule_any = {
            class = { "discord", "Signal", "Slack", "threema-web" },
            name = { "Microsoft Teams*" },
        },
        properties = {
            fullscreen = false,
            maximized = false,
            floating = false,
            tag = "9",
        },
    },
})
