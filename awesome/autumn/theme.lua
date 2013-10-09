local awful = require("awful")

theme = {}

theme.name = "autumn"
theme.root = awful.util.getdir("config") .. "/" .. theme.name .. "/"
theme.icondir = theme.root .. "icons/"

theme.font          = "M+ 1p normal 9"

theme.purple_light  = "#9D6CBA" -- 133
theme.red_light     = "#BD6C93" -- 132
theme.blue_light    = "#6D85C7" -- 68
theme.teal_light    = "#5CBDB8" -- 73
theme.green_light   = "#6DC276" -- 72
theme.grey_light    = "#999999" -- 102

theme.purple_dark   = "#3D2657" -- 53
theme.red_dark      = "#4C1B37" -- 89
theme.blue_dark     = "#313F63" -- 24
theme.teal_dark     = "#1F5655" -- 27
theme.green_dark    = "#2C5E35" -- 29
theme.grey_dark     = "#444444" -- 59

theme.black         = "#222222" -- 59
theme.white         = "#DDDDDD" -- 188


theme.bg_normal     = "#B3B3B4"
theme.bg_focus      = "#743D33"
theme.bg_urgent     = "#FB7863"
theme.bg_minimize   = nil
theme.bg_systray    = nil

theme.fg_normal     = theme.bg_focus
theme.fg_focus      = theme.bg_normal
theme.fg_urgent     = "#F2B56B"
theme.fg_minimize   = "#30343A"
theme.fg_systray    = nil

theme.border_width  = 2
theme.border_normal = "#B3B3B4"
theme.border_focus  = "#743D33"
theme.border_marked = "#F2B56B"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = theme.root .. "taglist/squarefw.png"
theme.taglist_squares_unsel = theme.root .. "taglist/squarew.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = theme.root .. "submenu.png"
theme.menu_height = 15
theme.menu_width  = 100

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = theme.root .. "titlebar/close_normal.png"
theme.titlebar_close_button_focus  = theme.root .. "titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = theme.root .. "titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = theme.root .. "titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = theme.root .. "titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = theme.root .. "titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = theme.root .. "titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = theme.root .. "titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = theme.root .. "titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = theme.root .. "titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = theme.root .. "titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = theme.root .. "titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = theme.root .. "titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = theme.root .. "titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = theme.root .. "titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.root .. "titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = theme.root .. "titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = theme.root .. "titlebar/maximized_focus_active.png"

theme.wallpaper = theme.root .. "background.png"

-- You can use your own layout icons like this:
theme.layout_fairh = theme.root .. "layouts/fairh.png"
theme.layout_fairv = theme.root .. "layouts/fairv.png"
theme.layout_floating  = theme.root .. "layouts/floating_2.png"
theme.layout_magnifier = theme.root .. "layouts/magnifier.png"
theme.layout_max = theme.root .. "layouts/max.png"
theme.layout_fullscreen = theme.root .. "layouts/fullscreen.png"
theme.layout_tilebottom = theme.root .. "layouts/tilebottom.png"
theme.layout_tileleft   = theme.root .. "layouts/tileleft.png"
theme.layout_tile = theme.root .. "layouts/tile.png"
theme.layout_tiletop = theme.root .. "layouts/tiletop.png"
theme.layout_spiral  = theme.root .. "layouts/spiral.png"
theme.layout_dwindle = theme.root .. "layouts/dwindle.png"

-- theme.awesome_icon = "~/.config/awesome/icons/awesome16.png"

-- Define the icon theme for application icons. If not set then the icons 
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
-- theme.icon_theme = nil

theme.menu_terminal = theme.icondir .. "os/console.png"
theme.menu_config = theme.icondir .. "os/code.png"
theme.menu_shutdown = theme.icondir .. "os/shutdown.png"
theme.menu_lockscreen = theme.icondir .. "os/lock.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
