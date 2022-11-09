local gears = require("gears")
local awful = require("awful")

local menubar = require("menubar")
menubar.show_categories = false

local terminal = "alacritty"
local modkey = "Mod4"

local keybinds = {}

keybinds.globalkeybinds = gears.table.join(
       -- Volume Keys
   awful.key({}, "XF86AudioLowerVolume", function ()
     awful.util.spawn("pactl set-sink-volume 0 -3%", false) end),
   awful.key({}, "XF86AudioRaiseVolume", function ()
     awful.util.spawn("pactl set-sink-volume 0 +3%", false) end),
   awful.key({}, "XF86AudioMute", function ()
     awful.util.spawn("pactl set-sink-mute 0 toggle", false) end),

   -- Media Keys
   awful.key({}, "XF86AudioPlay", function()
     awful.util.spawn("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause", false) end),
   awful.key({}, "XF86AudioNext", function()
     awful.util.spawn("playerctl next", false) end),
   awful.key({}, "XF86AudioPrev", function()
     awful.util.spawn("playerctl previous", false) end),


    -- Start a new terminal.
    awful.key({ modkey }, "Return",
        function() awful.spawn(terminal) end),

    -- Sreenshot
    awful.key ({}, "Print",
        function() awful.spawn("gnome-screenshot -a") end),


        -- Tag manipulation.
    -- Go back to previous tag.
    awful.key({ modkey }, "Tab",
        awful.tag.history.restore),
    -- Default apps per tag.
    awful.key({ modkey }, "d",
        function()
            local t = awful.screen.focused().selected_tag

            if t.name == "" then
                awful.spawn("emacs")
            elseif t.name == " " then
                awful.spawn("firefox")
            elseif t.name == "" then
                awful.spawn("atril")
            elseif t.name == "" then
                awful.spawn("discord")
            elseif t.name == "" then
                awful.spawn("spotify")
           end
        end),


        -- Window manipulation.
    -- Focus next window in the index.
    awful.key({ modkey }, "j",
        function() awful.client.focus.byidx(1) end),
    -- Focus previous window in the index.
    awful.key({ modkey }, "k",
        function() awful.client.focus.byidx(-1) end),
    -- Increase master width factor.
    awful.key({ modkey }, "l",
        function() awful.tag.incmwfact(0.05) end),
    -- Decrease master width factor.
    awful.key({ modkey }, "h",
        function() awful.tag.incmwfact(-0.05) end),


        -- Layout manipulation.
    -- Swap with next client by index.
    awful.key({ modkey, "Shift" }, "j",
        function() awful.client.swap.byidx(1) end),
    -- Swap with previous client by index.
    awful.key({ modkey, "Shift" }, "k",
        function() awful.client.swap.byidx(-1) end),
    -- Jump to urgent client
    awful.key({ modkey }, "u",
        awful.client.urgent.jumpto),
    -- Select next layout.
    awful.key({ modkey }, "space",
        function() awful.layout.inc(1) end),
    -- Select previous layout.
    awful.key({ modkey, "Shift" }, "space",
        function() awful.layout.inc(-1) end),


        -- Window manager keybinds.
    -- Reload awesome.
    awful.key({ modkey, "Control", "Shift" }, "r",
        awesome.restart),
    -- Kill awesome.
    awful.key({ modkey, "Control", "Shift" }, "q",
        awesome.quit),


        -- Runners.
    -- Executable run prompt.
    awful.key({ modkey }, "r",
        function() awful.screen.focused().promptbox:run() end),
    -- Run Lua code.
    awful.key({ modkey }, "x",
              function()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().promptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end),
    -- Menubar.
    awful.key({ modkey }, "p",
        function() menubar.show() end)
)

keybinds.clientkeybinds = gears.table.join(
    -- Kill client.
    awful.key({ modkey }, "q",
            function(c) c:kill() end)
)

keybinds.clientbuttons = gears.table.join(
    awful.button({ }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),

    awful.button({ modkey }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),

    awful.button({ modkey }, 3, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

for i = 1, 9 do
    keybinds.globalkeybinds = gears.table.join(keybinds.globalkeybinds,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end),

        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),

        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end),

        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end)
    )
end

root.keys(keybinds.globalkeybinds)

return keybinds
