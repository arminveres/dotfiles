local gears = require('gears')
local awful = require('awful')
local lain = require('lain')

local M = {}

local mwfact_change_requested = false
local mwfact_change_value = 0

--- @brief Hold current maginified client
M.magnified_client = nil

--- @brief returns a rounded gears shape
M.custom_rounded = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 2)
end

--- @brief returns the name of the current system i.e. node
M.get_nodename = function()
    local uname_handle = function()
        local handle = io.popen('uname --nodename')
        if handle ~= nil then
            return handle
        end
    end
    local nodename = uname_handle():read('*a')
    uname_handle:close()

    return nodename
end

--- @brief magnify selected client
--- @note Taken from `lain.utils` and adjusted for personal use
--- @type function
function M.mc(c, width_f, height_f)
    if c and not c.floating then
        M.magnified_client = c
        -- c = c or M.magnified_client

        if not c then return end

        c.floating  = true
        local s     = awful.screen.focused()
        local mg    = s.workarea
        local gtry  = {}

        -- local mwfact = width_f or s.selected_tag.master_width_factor or 0.5
        -- g.width      = math.sqrt(mwfact) * mg.width
        -- g.height     = math.sqrt(height_f or mwfact) * mg.height

        gtry.width  = mg.width * 0.6
        gtry.height = mg.height * 0.9
        gtry.x      = mg.x + (mg.width - gtry.width) / 2
        gtry.y      = mg.y + (mg.height - gtry.height) / 2

        if c then c:geometry(gtry) end -- if c is still a valid object
    else
        M.magnified_client = nil
        c.floating = false
    end
end

-- @brief adjusts the master_width_factor if we are using the lain layout, quite useful for ultrawide monitors
function M.mw_fact_mgr()
    local scr = awful.screen.focused()
    local tag = scr.selected_tag
    local layout = awful.layout.get(scr)

    -- skip if failure
    if not tag then return end
    -- don't do anything on Full HD monitors, TODO: add ratio as requirement
    if not (scr.geometry.width > 1920 and scr.geometry.height > 1080) then
        return
    end

    if layout == awful.layout.suit.tile.right then
        if #scr.tiled_clients == 1 then
            awful.layout.set(lain.layout.centerwork, tag)
            mwfact_change_value = 0.7
            mwfact_change_requested = true
        elseif #scr.tiled_clients > 2 then
            tag.column_count = 2
            mwfact_change_value = (1 / 3)
            mwfact_change_requested = true
        else
            mwfact_change_requested = false
        end
    elseif layout == lain.layout.centerwork then
        if #scr.tiled_clients > 1 then
            awful.layout.set(awful.layout.suit.tile.right, tag)
            mwfact_change_value = 0.5
            mwfact_change_requested = true
        elseif #scr.tiled_clients == 1 then
            mwfact_change_value = 0.7
            mwfact_change_requested = true
        else
            mwfact_change_value = 0.4
            mwfact_change_requested = true
        end
    elseif layout == awful.layout.suit.max then
        -- TODO: (aver) add focus by id in max layout
        -- local modkey = 'Mod4'
        -- awful.key({ modkey }, 'j', function()
        --     awful.client.focus.byidx(1)
        -- end, { description = 'focus next by index', group = 'client' }),
        -- awful.key({ modkey }, 'k', function()
        --     awful.client.focus.byidx(-1)
        -- end, { description = 'focus previous by index', group = 'client' }),
    else
        -- do nothing on other layouts
        mwfact_change_requested = false
    end

    if mwfact_change_requested then
        tag.master_width_factor = mwfact_change_value
    end
end

return M
