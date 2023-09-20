-- Required libraries
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, 'luarocks.loader')
local awful = require('awful')
local myutils = require('myutils')
require('awful.autofocus')
local beautiful = require('beautiful')
local bling = require('bling')
local freedesktop = require('freedesktop')
local gears = require('gears')
local hotkeys_popup = require('awful.hotkeys_popup')
local lain = require('lain')
local naughty = require('naughty')
local wibox = require('wibox')
-- local menubar       = require("menubar")
-- local vicious       = require('vicious') -- needed to install this via package manager ]]
-- require("awful.hotkeys_popup.keys.vim") ]]

-- NOTE: Set more specific and efficient GC

---@diagnostic disable-next-line: param-type-mismatch
collectgarbage('setpause', 160)
---@diagnostic disable-next-line: param-type-mismatch
collectgarbage('setstepmul', 400)
gears.timer.start_new(10, function()
    collectgarbage('step', 20000)
    return true
end)

local mappings = require('mappings')
local mytable = mappings.mytable
local globalkeys = mappings.globalkeys
local dpi = require('beautiful.xresources').apply_dpi

-- Notification configuration
naughty.config.defaults.border_width = dpi(2)
naughty.config.spacing = dpi(8)
naughty.config.padding = dpi(8)
naughty.config.defaults.margin = dpi(8)
naughty.config.defaults.timeout = 5

-- {{{ Error handling

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = 'Oops, there were errors during startup!',
        text = awesome.startup_errors,
    })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal('debug::error', function(err)
        if in_error then
            return
        end
        in_error = true
        naughty.notify({
            preset = naughty.config.presets.critical,
            title = 'Oops, an error happened!',
            text = tostring(err),
        })
        in_error = false
    end)
end

-- }}}

-- or use universal shell script
awful.spawn.with_shell('~/.config/awesome/autorun.sh')

-- {{{ Variable definitions

local themes = {
    'default', -- 1
    'multicolor', -- 2
}

local chosen_theme = themes[2]
local modkey = 'Mod4'
local altkey = 'Mod1'
local terminal = 'kitty'
local editor = os.getenv('EDITOR') or 'nvim'

awful.util.terminal = terminal
awful.util.tagnames = { 'code', 'www', 'res', 'mus', 'mail', 'game', 'tor', 'vm', 'msg' }

awful.layout.layouts = {
    awful.layout.suit.tile.right,
    lain.layout.centerwork,
    awful.layout.suit.max,
    -- awful.layout.suit.spiral.dwindle,
}

awful.util.taglist_buttons = mytable.join(
    awful.button({}, 1, function(t)
        t:view_only()
    end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({}, 4, function(t)
        awful.tag.viewnext(t.screen)
    end),
    awful.button({}, 5, function(t)
        awful.tag.viewprev(t.screen)
    end)
)

awful.util.tasklist_buttons = mytable.join(
    awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal('request::activate', 'tasklist', { raise = true })
        end
    end),
    awful.button({}, 3, function()
        awful.menu.client_list({ theme = { width = 250 } })
    end),
    awful.button({}, 4, function()
        awful.client.focus.byidx(1)
    end),
    awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
    end)
)

beautiful.init(
    string.format('%s/.config/awesome/themes/%s/theme.lua', os.getenv('HOME'), chosen_theme)
)
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
local myawesomemenu = {
    {
        'Hotkeys',
        function()
            hotkeys_popup.show_help(nil, awful.screen.focused())
        end,
    },
    { 'Manual', string.format('%s -e man awesome', terminal) },
    { 'Edit config', string.format('%s -e %s %s', terminal, editor, awesome.conffile) },
    { 'Restart', awesome.restart },
    {
        'Quit',
        function()
            awesome.quit()
        end,
    },
}

awful.util.mymainmenu = freedesktop.menu.build({
    before = {
        { 'Awesome', myawesomemenu, beautiful.awesome_icon },
        -- other triads can be put here
    },
    after = {
        { 'Open terminal', terminal },
        -- other triads can be put here
    },
})

-- Hide the menu when the mouse leaves it
awful.util.mymainmenu.wibox:connect_signal('mouse::leave', function()
    if
        not awful.util.mymainmenu.active_child
        or (
            awful.util.mymainmenu.wibox ~= mouse.current_wibox
            and awful.util.mymainmenu.active_child.wibox ~= mouse.current_wibox
        )
    then
        awful.util.mymainmenu:hide()
    else
        awful.util.mymainmenu.active_child.wibox:connect_signal('mouse::leave', function()
            if awful.util.mymainmenu.wibox ~= mouse.current_wibox then
                awful.util.mymainmenu:hide()
            end
        end)
    end
end)

-- Set the Menubar terminal for applications that require it
--menubar.utils.terminal = terminal

-- }}}

-- {{{ Screen
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
-- NOTE: Just do this in the autorun file
-- screen.connect_signal('property::geometry', function()
--     awful.spawn.with_shell('nitrogen --restore')
-- end)

-- WARN: add borders for all clients, so we really know who is in focus in case of multiple monitors

-- No borders when rearranging only 1 non-floating or maximized client
-- screen.connect_signal('arrange', function(s)
--     local only_one = #s.tiled_clients == 1
--     for _, c in pairs(s.clients) do
--         if only_one and not c.floating or c.maximized or c.fullscreen then
--             c.border_width = 0
--         else
--             c.border_width = beautiful.border_width
--         end
--     end
-- end)

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s)
    require('bars').at_screen_connect(s)
end)

-- }}}

bling.widget.window_switcher.enable({
    type = 'thumbnail', -- set to anything other than "thumbnail" to disable client previews
    -- keybindings (the examples provided are also the default if kept unset)
    hide_window_switcher_key = 'Escape', -- The key on which to close the popup
    minimize_key = 'n', -- The key on which to minimize the selected client
    unminimize_key = 'N', -- The key on which to unminimize all clients
    kill_client_key = 'q', -- The key on which to close the selected client
    cycle_key = 'Tab', -- The key on which to cycle through all clients
    previous_key = 'Left', -- The key on which to select the previous client
    next_key = 'Right', -- The key on which to select the next client
    vim_previous_key = 'l', -- Alternative key on which to select the previous client
    vim_next_key = 'h', -- Alternative key on which to select the next client

    -- cycleClientsByIdx = awful.client.focus.global_bydirection, -- The function to cycle the clients
    -- filterClients = awful.widget.tasklist.filter.allscreen,
})

-- {{{ Mouse bindings
root.buttons(mytable.join(
    awful.button({}, 3, function()
        awful.util.mymainmenu:toggle()
    end)
    -- NOTE: This got quite annoying when accidentally scrolling on the desktop.
    --     awful.button({}, 4, awful.tag.viewnext),
    --     awful.button({}, 5, awful.tag.viewprev)
))

-- }}}

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = mytable.join(
        globalkeys,
        -- View tag only.
        awful.key({ modkey }, '#' .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
                tag:view_only()
            end
        end, { description = 'view tag #' .. i, group = 'tag' }),
        -- Toggle tag display.
        awful.key({ modkey, 'Control' }, '#' .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end, { description = 'toggle tag #' .. i, group = 'tag' }),
        -- Move client to tag.
        awful.key({ modkey, 'Shift' }, '#' .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end, { description = 'move focused client to tag #' .. i, group = 'tag' }),
        -- Toggle tag on focused client.
        awful.key({ modkey, 'Control', 'Shift' }, '#' .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end, { description = 'toggle focused client on tag #' .. i, group = 'tag' })
    )
end

clientbuttons = mytable.join(
    awful.button({}, 1, function(c)
        c:emit_signal('request::activate', 'mouse_click', { raise = true })
    end),
    awful.button({ modkey }, 1, function(c)
        c:emit_signal('request::activate', 'mouse_click', { raise = true })
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function(c)
        c:emit_signal('request::activate', 'mouse_click', { raise = true })
        awful.mouse.client.resize(c)
    end),
    awful.button({}, 1, function(c)
        client.focus = c
        c:raise()

        if not c.floating then
            return
        end
        -- Only use bottom left/right corner, because dragging titlebar is already mapped to move
        local corners = {
            { c.x + c.width, c.y + c.height },
            { c.x, c.y + c.height },
        }
        local m = mouse.coords()
        local distance = 20
        for _, pos in ipairs(corners) do
            if math.sqrt((m.x - pos[1]) ^ 2 + (m.y - pos[2]) ^ 2) <= distance then
                awful.mouse.client.resize(c)
                break
            end
        end
    end)
)

-- Set keys
root.keys(globalkeys)

-- {{{ Signals

-- Signal function to execute when a new client appears.
client.connect_signal('manage', function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

client.connect_signal('request::titlebars', function(c)
    -- Custom
    if beautiful.titlebar_fun then
        beautiful.titlebar_fun(c)
        return
    end

    -- Default
    -- buttons for the titlebar
    local buttons = mytable.join(
        awful.button({}, 1, function()
            c:emit_signal('request::activate', 'titlebar', { raise = true })
            awful.mouse.client.move(c)
        end),
        awful.button({}, 3, function()
            c:emit_signal('request::activate', 'titlebar', { raise = true })
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, { size = 16 }):setup({
        {
            -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout = wibox.layout.fixed.horizontal,
        },
        {
            -- Middle
            {
                -- Title
                align = 'center',
                widget = awful.titlebar.widget.titlewidget(c),
            },
            buttons = buttons,
            layout = wibox.layout.flex.horizontal,
        },
        {
            -- Right
            awful.titlebar.widget.floatingbutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton(c),
            awful.titlebar.widget.ontopbutton(c),
            awful.titlebar.widget.closebutton(c),
            layout = wibox.layout.fixed.horizontal(),
        },
        layout = wibox.layout.align.horizontal,
    })
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal('mouse::enter', function(c)
    c:emit_signal('request::activate', 'mouse_enter', { raise = vi_focus })
end)

-- tag layout changed
tag.connect_signal('property::layout', function(c)
    myutils.mw_fact_mgr()
end)

-- tag select, e.g., when concatenated
tag.connect_signal('property::selected', function(c)
    myutils.mw_fact_mgr()
end)

client.connect_signal('property::floating', function(c)
    myutils.mw_fact_mgr()
    if c.floating then
        awful.placement.centered(c)
    end
end)
client.connect_signal('focus', function(c)
    myutils.mw_fact_mgr()
    c.border_color = beautiful.border_focus
end)
client.connect_signal('unfocus', function(c)
    myutils.mw_fact_mgr()
    c.border_color = beautiful.border_normal
end)

-- NOTE: the `(un)manage` signal is emitted when a client is opened/closed, which is a better factor
-- for calling our manager function
client.connect_signal('manage', function(c)
    myutils.mw_fact_mgr()
end)
client.connect_signal('unmanage', function(c)
    myutils.mw_fact_mgr()
end)

-- }}}

-- {{{ Rules
require('myrules')
-- }}}
