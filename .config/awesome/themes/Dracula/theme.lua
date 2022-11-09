local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local naughty = require("naughty")

local filesystem = require("gears.filesystem")
local themes_path = filesystem.get_configuration_dir() .. "themes/Dracula/"

local theme = {}

-- Fonts.
local font = "Ubuntu"

theme.font  = font .. " 14"
theme.taglist_font  = "Font Awesome 6 Free 15" 

-- Colors.
theme.fg_normal = "#9E9E9E"
theme.bg_normal = "#1e1e28"

theme.fg_focus = "#EBEBFF"
theme.bg_focus = "#242424"

theme.fg_urgent = "#000000"
theme.bg_urgent = "#FFFFFF"

theme.taglist_fg_focus = "#EDEFFF"
theme.taglist_bg_focus = theme.bg_normal

theme.bg_systray = theme.bg_normal

-- Border. 
theme.useless_gap = 0
theme.border_width = 0

-- Bar.
theme.bar_height = dpi(26)

-- Wallpaper.
theme.wallpaper = themes_path .. "background"

-- Notification manager.
theme.notification_font = font
theme.notification_width = dpi(400)
theme.notification_height = dpi(100)
theme.notification_icon_size = dpi(100)
theme.notification_border_width = 0

-- Layout icons.
theme.layout_tile       = themes_path .. "layouts/tilew.png"
theme.layout_tileleft   = themes_path .. "layouts/tileleftw.png"
theme.layout_tilebottom = themes_path .. "layouts/tilebottomw.png"
theme.layout_tiletop    = themes_path .. "layouts/tiletopw.png"
theme.layout_floating   = themes_path .. "layouts/floatingw.png"

return theme
