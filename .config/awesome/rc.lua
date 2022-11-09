-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
-- Keybinds
local keybinds = require("keybinds")

-- Themes define colours, icons, font and wallpapers
beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/Dracula/theme.lua")

-- Table of layouts to cover with awful.layout.inc, order matters
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.floating,
}

-- Create a wibox for each screen and add it
local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    local textclock = wibox.widget.textclock('%R ')

    
    -- Each screen has its own tag table
    awful.tag({ "", " ", "", "", "", "6", "7", "", "" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.promptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using
    -- We need one layoutbox per screen
    s.layoutbox = awful.widget.layoutbox(s)
    s.layoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))

    -- Create a taglist widget
    s.taglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.noempty,
        style = {
            shape = gears.shape.rounded_rect
        },
        layout = {
            spacing = 7,
            layout = wibox.layout.fixed.horizontal
        }
    }

    -- Create the wibox
    s.wibox = awful.wibar({ position = "bottom", screen = s, height = beautiful.bar_height})

    -- Add widgets to the wibox
    s.wibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.layoutbox,
            wibox.widget.systray(),
            s.promptbox,
        },
        expand = "none",
        s.taglist,
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            textclock,
        },
    }
end)

-- Rules to apply to new clients (through the "manage" signal)
awful.rules.rules = {
    -- All clients will match this rule
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = keybinds.clientkeybinds,
                     buttons = keybinds.clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     size_hints_honor = false
      }},

    -- Floating clients
    { rule_any = {
        instance = {
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size
          "Wpa_gui",
          "veromix",
          "matplotlib",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here
        name = {
          "Event Tester",  -- xev
          "Save File", -- browser save file popup
          "Choose save path",
          "Screenshot",
        },
        role = {
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools
        }
      }, properties = { floating = true, placement = awful.placement.centered }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" } },
        properties = { titlebars_enabled = false }},

    { rule = { class = "firefox" },
            properties = { screen = 1, tag = "" }},

    { rule = { class = "discord" },
            properties = { screen = 1, tag = "" }}
}

-- Stop any and all minimization of windows
client.connect_signal("property::minimized", function(c)
    c.minimized = false
end)

-- Signal function to execute when a new client appears
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Enable sloppy focus, so that focus follows mouse
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

-- Window transparency for inactive windows
client.connect_signal("focus", function(c)
                              c.opacity = 1
                           end)
client.connect_signal("unfocus", function(c)
                                c.opacity = 0.9
                             end)

-- Run garbage collector regularly to prevent memory leaks
gears.timer {
       timeout = 30,
       autostart = true,
       callback = function() collectgarbage() end
}

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
