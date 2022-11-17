local gears = require('gears')
local M = {}

M.custom_rounded = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 2)
end

return M
