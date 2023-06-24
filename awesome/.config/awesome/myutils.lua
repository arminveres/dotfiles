local gears = require('gears')
local awful = require('awful')

local M = {}

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

return M
