local gears = require('gears')
local M = {}

-- @brief returns a rounded gears shape
M.custom_rounded = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 2)
end

-- @brief returns the name of the current system i.e. node
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

return M
