--[[ Multicolor Awesome WM theme 2.0
    github.com/lcpz --]]

local dpi                                            = require("beautiful.xresources").apply_dpi
local gears                                          = require("gears")

local theme                                          = {}

theme.confdir                                        = os.getenv("HOME") .. "/.config/awesome/themes/multicolor"
-- NOTE: control wallpaper through nitrogen or feh
-- theme.wallpaper                                 = theme.confdir .. "/wall.png"
theme.systray_icon_spacing                           = dpi(7)
theme.font                                           = "Iosevka 12" -- "JetBrainsMono Nerd Font 10"
theme.bg_normal                                      = "#000000"
theme.fg_normal                                      = "#aaaaaa"
theme.bg_focus                                       = "#ff8c00"
theme.fg_focus                                       = "#000000"
theme.bg_urgent                                      = "#000000"
theme.fg_urgent                                      = "#af1d18"
theme.fg_minimize                                    = "#ffffff"
theme.border_width                                   = dpi(2)
theme.border_normal                                  = "#1c2022"
theme.border_focus                                   = "#b8bb26" -- "#606060"
theme.border_marked                                  = "#3ca4d8"
theme.menu_border_width                              = dpi(1)
theme.menu_border_color                              = "#000000"
theme.menu_width                                     = dpi(135)
theme.menu_height                                    = dpi(23)
theme.menu_submenu_icon                              = theme.confdir .. "/icons/submenu.png"
theme.menu_fg_normal                                 = "#aaaaaa"
theme.menu_bg_normal                                 = "#050505dd"
theme.menu_fg_focus                                  = "#000000"
theme.menu_bg_focus                                  = "#ff8c00"
theme.error                                          = "#fb4934"
theme.widget_temp                                    = theme.confdir .. "/icons/temp.png"
theme.widget_uptime                                  = theme.confdir .. "/icons/ac.png"
theme.widget_cpu                                     = theme.confdir .. "/icons/cpu.png"
theme.widget_weather                                 = theme.confdir .. "/icons/dish.png"
theme.widget_fs                                      = theme.confdir .. "/icons/fs.png"
theme.widget_mem                                     = theme.confdir .. "/icons/mem.png"
theme.widget_note                                    = theme.confdir .. "/icons/note.png"
theme.widget_note_on                                 = theme.confdir .. "/icons/note_on.png"
theme.widget_netdown                                 = theme.confdir .. "/icons/net_down.png"
theme.widget_netup                                   = theme.confdir .. "/icons/net_up.png"
theme.widget_mail                                    = theme.confdir .. "/icons/mail.png"
theme.widget_batt                                    = theme.confdir .. "/icons/bat.png"
theme.widget_clock                                   = theme.confdir .. "/icons/clock.png"
theme.widget_vol                                     = theme.confdir .. "/icons/spkr.png"
theme.taglist_squares_sel                            = theme.confdir .. "/icons/square_a.png"
theme.taglist_squares_unsel                          = theme.confdir .. "/icons/square_b.png"
theme.tasklist_plain_task_name                       = true
theme.tasklist_disable_icon                          = false
theme.useless_gap                                    = dpi(10)
theme.layout_tile                                    = theme.confdir .. "/icons/tile.png"
theme.layout_tilegaps                                = theme.confdir .. "/icons/tilegaps.png"
theme.layout_tileleft                                = theme.confdir .. "/icons/tileleft.png"
theme.layout_tilebottom                              = theme.confdir .. "/icons/tilebottom.png"
theme.layout_tiletop                                 = theme.confdir .. "/icons/tiletop.png"
theme.layout_fairv                                   = theme.confdir .. "/icons/fairv.png"
theme.layout_fairh                                   = theme.confdir .. "/icons/fairh.png"
theme.layout_spiral                                  = theme.confdir .. "/icons/spiral.png"
theme.layout_dwindle                                 = theme.confdir .. "/icons/dwindle.png"
theme.layout_max                                     = theme.confdir .. "/icons/max.png"
theme.layout_fullscreen                              = theme.confdir .. "/icons/fullscreen.png"
theme.layout_magnifier                               = theme.confdir .. "/icons/magnifier.png"
theme.layout_floating                                = theme.confdir .. "/icons/floating.png"
theme.titlebar_close_button_normal                   = theme.confdir .. "/icons/titlebar/close_normal.png"
theme.titlebar_close_button_focus                    = theme.confdir .. "/icons/titlebar/close_focus.png"
theme.titlebar_minimize_button_normal                = theme.confdir .. "/icons/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus                 = theme.confdir .. "/icons/titlebar/minimize_focus.png"
theme.titlebar_ontop_button_normal_inactive          = theme.confdir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive           = theme.confdir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active            = theme.confdir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active             = theme.confdir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive         = theme.confdir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive          = theme.confdir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active           = theme.confdir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active            = theme.confdir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive       = theme.confdir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive        = theme.confdir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active         = theme.confdir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active          = theme.confdir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive      = theme.confdir .. "/icons/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive       = theme.confdir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active        = theme.confdir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active         = theme.confdir .. "/icons/titlebar/maximized_focus_active.png"

-- notification
theme.notification_bg                                = "#ff8c00"
theme.notification_fg                                = "#000000"
theme.notification_border_color                      = "#000000"
theme.notification_icon_size                         = dpi(100)

-- playerctl signal
theme.playerctl_backend                              = "playerctl_lib" -- backend to use
theme.playerctl_ignore                               = { "firefox" } -- list of players to be ignored
theme.playerctl_player                               = {} -- list of players to be used in priority order
theme.playerctl_update_on_activity                   = true -- whether to prioritize the most recently active players or not
theme.playerctl_position_update_interval             = 1 -- the update interval for fetching the position from playerctl
-- tab switcher
theme.window_switcher_widget_bg                      = "#000000" -- The bg color of the widget
theme.window_switcher_widget_border_width            = 1 -- The border width of the widget
theme.window_switcher_widget_border_radius           = 10 -- The border radius of the widget
theme.window_switcher_widget_border_color            = theme.error -- The border color of the widget
theme.window_switcher_clients_spacing                = 20 -- The space between each client item
theme.window_switcher_client_icon_horizontal_spacing = 5 -- The space between client icon and text
theme.window_switcher_client_width                   = 150 -- The width of one client widget
theme.window_switcher_client_height                  = 250 -- The height of one client widget
theme.window_switcher_client_margins                 = 10 -- The margin between the content and the border of the widget
theme.window_switcher_thumbnail_margins              = 10 -- The margin between one client thumbnail and the rest of the widget
theme.thumbnail_scale                                = false -- If set to true, the thumbnails fit policy will be set to "fit" instead of "auto"
theme.window_switcher_name_margins                   = 10 -- The margin of one clients title to the rest of the widget
theme.window_switcher_name_valign                    = "center" -- How to vertically align one clients title
theme.window_switcher_name_forced_width              = 200 -- The width of one title
theme.window_switcher_name_font                      = theme.font -- The font of all titles
theme.window_switcher_name_normal_color              = "#ffffff" -- The color of one title if the client is unfocused
theme.window_switcher_name_focus_color               = theme.error -- The color of one title if the client is focused
theme.window_switcher_icon_valign                    = "center" -- How to vertically align the one icon
theme.window_switcher_icon_width                     = 40 -- The width of one icon

-- lain
theme.lain_icons                                     = os.getenv("HOME") .. "/.config/awesome/lain/icons/layout/zenburn/"
theme.layout_termfair                                = theme.lain_icons .. "termfair.png"
theme.layout_centerfair                              = theme.lain_icons .. "centerfair.png" -- termfair.center
theme.layout_cascade                                 = theme.lain_icons .. "cascade.png"
theme.layout_cascadetile                             = theme.lain_icons .. "cascadetile.png" -- cascade.tile
theme.layout_centerwork                              = theme.lain_icons .. "centerwork.png"
theme.layout_centerworkh                             = theme.lain_icons .. "centerworkh.png" -- centerwork.horizontal

return theme
