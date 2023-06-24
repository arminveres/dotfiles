local awful = require('awful')
local beautiful = require('beautiful')
local clientkeys = require('mappings').clientkeys

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            -- sets the slave as the new window
            -- callback = awful.client.setslave,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen,
            size_hints_honor = false,
        },
    },

    -- Floating clients.
    {
        rule_any = {
            instance = {
                'DTA',   -- Firefox addon DownThemAll.
                'copyq', -- Includes session name in class.
                'pinentry',
            },
            class = {
                'Arandr',
                'gnome-calculator',
                'nm-connection-editor',
                'Gpick',
                'Kruler',
                'MessageWin',  -- kalarm.
                'Sxiv',
                'Tor Browser', -- Needs a fixed window size to avoid fingerprinting by screen size.
                'Wpa_gui',
                'veromix',
                'xtightvncviewer',
                'origin.exe',
                'zoom',
                'Cisco AnyConnect Secure Mobility Client',
                'Matplotlib',
                'matplotlib',
                'Gnome-Pomodoro',
            },
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
                'Event Tester', -- xev.
            },
            role = {
                'AlarmWindow',   -- Thunderbird's calendar.
                'ConfigManager', -- Thunderbird's about:config.
                'pop-up',        -- e.g. Google Chrome's (detached) Developer Tools.
                'Network Connections',
            },
        },
        properties = {
            floating = true,
        },
    },

    -- Add titlebars to normal clients and dialogs
    {
        rule_any = { type = { 'normal', 'dialog' } },
        properties = { titlebars_enabled = false },
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- {
    --     rule_any = { class = { 'Firefox', 'firefox' } },
    --     properties = { screen = 1, tag = awful.util.tagnames[2] },
    -- },
    {
        rule_any = { class = { 'microsoft teams - preview', 'Microsoft Teams - Preview' } },
        properties = { tag = awful.util.tagnames[3], minimized = false },
    },
    {
        rule_any = { class = { 'Blueman-manager', 'easyeffects' } },
        properties = { tag = awful.util.tagnames[4], minimized = true },
    },
    {
        rule_any = { class = { 'Spotify' } },
        properties = { tag = awful.util.tagnames[4], minimized = false },
    },
    {
        rule_any = { class = { 'Geary', 'thunderbird', 'mail' } },
        properties = { tag = awful.util.tagnames[5] },
    },
    {
        rule_any = { class = { 'Steam', 'Lutris' } },
        properties = { tag = awful.util.tagnames[6] },
    },
    {
        rule_any = { class = { 'qBittorrent', 'qbittorrent' } },
        properties = { tag = awful.util.tagnames[7] },
    },
    {
        rule_any = { class = { 'corectrl', 'virt-manager', 'Virt-manager' } },
        properties = { tag = awful.util.tagnames[8] },
    },
    {
        rule_any = { class = { 'discord', 'Signal', 'Slack' } },
        properties = { tag = awful.util.tagnames[9] },
    },
}
