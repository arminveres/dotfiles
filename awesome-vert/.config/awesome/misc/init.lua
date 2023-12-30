-- misc stuff
-- ~~~~~~~~~~
-- includes startup apps, theme changing and more

local awful = require("awful")
-- local gfs = require("gears").filesystem.get_configuration_dir()

-- autostart
awful.spawn.with_shell(os.getenv("XDG_CONFIG_HOME") .. "/awesome/autorun.sh")

-- theme applier
-- TODO: (aver) switch to other gtk theme
require("misc.scripts.theme-applier")

-- launchers
-- ~~~~~~~~~

return {
    musicMenu = require("misc.scripts.Rofi.music-pop").execute,
}
