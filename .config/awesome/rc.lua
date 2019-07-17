-- Theme Handling Library
local beautiful = require("beautiful")
beautiful.init("~/.config/awesome/theme.lua")
beautiful.get().wallpaper="~/.config/awesome/background.png"

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

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
-- }}}

-- {{{ Variable definitions
terminal = "termite"
browser = "brave"
filemanager = "nemo"
editor = "vim" 
editor_cmd = terminal .. " -e " .. editor .. " "

screen_width = awful.screen.focused().geometry.width
screen_height = awful.screen.focused().geometry.height

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Notifications
-- Icon size
naughty.config.defaults['icon_size'] = beautiful.notification_icon_size

-- Timeouts
naughty.config.defaults.timeout = 5
naughty.config.presets.low.timeout = 2
naughty.config.presets.critical.timeout = 10

-- Themeing variables
naughty.config.padding = beautiful.notification_padding
naughty.config.spacing = beautiful.notification_spacing
naughty.config.spacing.defaults.margin = beautiful.notification_margin
naughty.config.defaults.border_width = beautiful.notification_border_width

naughty.config.presets.normal = {
    font = beautiful.notification_font,
    fg = beautiful.notification_fg,
    bg = beautiful.notification_bg,
    border_width = beautiful.notification_border_width,
    margin = beautiful.notification_margin,
    position = beautiful.notification_position
}

naughty.config.presets.low = {
    font = beautiful.notification_font,
    fg = beautiful.notifcation_fg,
    bg = beautiful.notifcation_bg,
    border_width = beautiful.notification_border_width,
    margin = beautiful.notification_margin,
    position = beautiful.notification_position
}

naughty.config.presets.ok = naughty.config.presets.low
naughty.config.presets.info = naughty.config.presets.low
naughty.config.presets.warn = naughty.config.presets.normal

naughty.config.presets.critical = {
    font = beautiful.notification_font,
    fg = beautiful.notification_crit_fg,
    bg = beautiful.notification_crit_bg,
    border_width = beautiful_border_width,
    margin = beautiful.notification_margin,
    position = beautiful.notification_position
}


-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() return false, hotkeys_popup.show_help() end, beautiful.keyboard_icon },
   { "restart", awesome.restart, beautiful.reboot_icon },
   { "quit", function() exit_screen_show() end, beautiful.poweroff_icon },
}

mymainmenu = awful.menu({ 
    items = { 
        { "awesome", myawesomemenu, beautiful.awesome_icon },
        { "brave", browser, beautiful.browser_icon },
        { "terminal", terminal, beautiful.terminal_icon }, 
        { "files", filemanager, beautiful_files_icon },
        { "search", "rofi -show combi", beautiful.search_icon },
        { "discord", 
            function()
               local matcher = function(c)
                    return awful.rules.match(c, {class = 'discord'})
                end
                awful.client.run_or_raise("discord", matcher)
            end, beautiful.discord_icon }                                  
    }
})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        awful.spawn.with_shell("feh --bg-fill " .. wallpaper)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.

    local layout = awful.layout.suit
    local layouts = {
        layout.tile,
        layout.max,
        layout.tile,
        layout.max,
        layout.max,
        layout.max,
        layout.max,
        layout.max,
        layout.max,
        layout.max
    }


    local tagnames = beautiful.tagnames or { "", "", "", "", "5", "6", "7", "8", "" }

    awful.tag.add(tagnames[1], {
        layout = layouts[1],
        screen = s,
        selected = true,
    })
    awful.tag.add(tagnames[2], {
        layout = layouts[2],
        screen = s
    })
    awful.tag.add(tagnames[3], {
        layout = layouts[3],
        screen = s
    })
    awful.tag.add(tagnames[4], {
        layout = layouts[4],
        screen = s,
        master_width_factor = 0.65
    })
    awful.tag.add(tagnames[5], {
        layout = layouts[5],
        screen = s
    })
    awful.tag.add(tagnames[6], {
        layout = layouts[6],
        screen = s
    })
    awful.tag.add(tagnames[7], {
        layout = layouts[7],
        screen = s
    })
    awful.tag.add(tagnames[8], {
        layout = layouts[8],
        screen = s
    })
    awful.tag.add(tagnames[9], {
        layout = layouts[9],
        screen = s,
        master_width_factor = 0.65
    })
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { 
        border_width = beautiful.border_width,
        border_color = beautiful.border_normal,
        focus = awful.client.focus.filter,
        raise = true,
        keys = keys.clientkeys,
        buttons = keys.clientbuttons,
        screen = awful.screen.preferred,
        size_hints_honor = false,
        honor_workarea = true,
        honor_padding = true,
        placement = awful.placement.no_overlap+awful.placement.no_offscreen
       }
    },
    
    -- Add titlebars
    { rule_any = {
        type = { "normal", "dialog" }
      },
      properties = { titlebars_enabled = true }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
            "mpv",
            "Gpick",
            "Lxappearnace",
            "Nm-connection-editor",
            "File-roller",
            "fst",
        },
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
