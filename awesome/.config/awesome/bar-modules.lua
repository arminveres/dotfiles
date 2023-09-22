local awful = require('awful')
local lain = require('lain')
local theme = require('beautiful')
local wibox = require('wibox')
local markup = lain.util.markup

local M = {}

-- Net
M.netdownicon = wibox.widget.imagebox(theme.widget_netdown)
M.netdowninfo = wibox.widget.textbox()
M.netupicon = wibox.widget.imagebox(theme.widget_netup)
M.netupinfo = lain.widget.net({
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
        M.netdowninfo:set_markup(markup.fontfg(theme.font, '#87af5f', received()))
    end,
})

-- MEM
M.memicon = wibox.widget.imagebox(theme.widget_mem)
M.memory = lain.widget.mem({
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

-- Weather to be set before use
M.weathericon = wibox.widget.imagebox(theme.widget_weather)
theme.weather = lain.widget.weather({
    city_id = 2643743, -- placeholder (London)
    notification_preset = { font = 'Terminus 10', fg = theme.fg_normal },
    weather_na_markup = markup.fontfg(theme.font, '#eca4c4', 'N/A '),
    settings = function()
        descr = weather_now['weather'][1]['description']:lower()
        units = math.floor(weather_now['main']['temp'])
        widget:set_markup(markup.fontfg(theme.font, '#eca4c4', descr .. ' @ ' .. units .. '°C '))
    end,
})

-- CPU
M.cpuicon = wibox.widget.imagebox(theme.widget_cpu)
M.cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, '#ff3c3c', cpu_now.usage .. '% '))
    end,
})

-- Coretemp
M.tempicon = wibox.widget.imagebox(theme.widget_temp)
local temploc = function()
    for idx = 1, 10, 1 do
        local loc = '/sys/devices/platform/coretemp.0/hwmon/hwmon' .. idx .. '/temp1_input'
        local f = io.open(loc, 'r')
        if f ~= nil then
            return loc
        end
    end
end
M.temp_widget = lain.widget.temp({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, '#f1af5f', coretemp_now .. '°C '))
    end,
    tempfile = temploc(),
    timeout = 2,
})

-- TODO: (aver) add interface recognition, akin to what I did before `b3122db2f4df5a5056ff9518c6710571cb2e72e0`
local interface = 'wlp0s20f3'
M.ip_widget = awful.widget.watch(
    'bash -c "ifconfig '
        .. interface
        .. " | grep --extended-regexp --only-matching --max-count=1 '(([0-9]+)\\.){3}([0-9]+)'\"",
    60, -- only update every minute
    function(widget, stdout)
        if stdout ~= '' then
            widget:set_markup(markup.fontfg(theme.font, '#bbd800', 'E: ' .. stdout .. ' '))
        else
            widget:set_markup(markup.fontfg(theme.font, theme.error, 'offline '))
        end
    end
)

-- Battery
M.bat = lain.widget.bat({
    settings = function()
        if bat_now.perc == 'N/A' then
            return
        end

        local perc = bat_now.perc ~= 'N/A' and bat_now.perc .. '%' or bat_now.perc
        perc = perc .. ' ' .. bat_now.time
        if bat_now.ac_status == 1 then
            perc = ' 󰂏 ' .. perc
        else
            perc = ' 󰂌 ' .. perc
        end
        perc = perc .. ' '

        if tonumber(bat_now.perc) <= 20 then
            widget:set_markup(markup.color('#000000', '#fb4934', perc))
        else
            widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, perc))
        end
    end,
})

-- ALSA volume
M.volicon = wibox.widget.imagebox(theme.widget_vol)
theme.volume = lain.widget.alsa({
    settings = function()
        if volume_now.status == 'off' then
            volume_now.level = volume_now.level .. 'M'
        end
        widget:set_markup(markup.fontfg(theme.font, '#7493d2', volume_now.level .. '%'))
    end,
})

return M
