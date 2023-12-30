-- sussy images
-- ~~~~~~~~~~~~

-- misc/vars
-- ~~~~~~~~~
local dir = os.getenv("XDG_CONFIG_HOME") .. "/awesome/images/sus/"
local ui_vars = require("theme.ui_vars")

-- init
-- ~~~~
return {

    -- images
    bell = dir .. "bell.png",
    profile = dir .. "profile.jpg",
    music_icon = dir .. "music.png",
    album_art = dir .. "album-art.png",
    awesome = dir .. "awesome.png",

    -- layouts
    layouts = {
        flair = dir .. "layouts/flair.png",
        floating = dir .. "layouts/floating.png",
        tile = dir .. "layouts/tile.png",
        layoutMachi = dir .. "layouts/layout-machi.png",
        centerwork = dir .. "layouts/centerwork.png",
    },

    -- wallpapers
    wall = dir .. "walls/" .. ui_vars.color_scheme .. ".png",
}
