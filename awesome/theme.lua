-- Entry point for themes

local bling                     = require("bling")
local gears                     = require("gears")
local awful                     = require("awful")
local dpi                       = require("beautiful.xresources").apply_dpi
local bar                       = require("bar.bar")
local naughty                   = require("naughty")

-- For changing themes
local chosen_theme              = "vivendi-tinted"
local colors                    = require("themes." .. chosen_theme .. ".colors")

local theme                     = colors
-- theme.font                      = "JetBrains Mono 10"
theme.font                      = "Iosevka Comfy 10"
-- theme.font                      = "Iosevka Term SS04 11"
theme.taglist_font              = theme.font
-- theme.taglist_font              = "awesomewm-font 13"

theme.notification_font         = "Iosevka Comfy 20"
-- theme.notification_font         = "Iosevka Term SS04 20"
theme.notification_max_width    = 450

theme.fg_normal                 = theme.fg_dim
theme.fg_focus                  = theme.fb_main
theme.bg_normal                 = theme.bg_dim
theme.bg_focus                  = theme.bg_dim
theme.fg_urgent                 = theme.red
theme.bg_urgent                 = theme.black
theme.border_normal             = theme.bg_main
theme.border_focus              = theme.bg_accent_alt

theme.taglist_fg_focus          = theme.fg_main
theme.taglist_bg_focus          = theme.bg_alt
theme.taglist_fg_occupied       = theme.fg_dim
theme.taglist_fg_empty          = theme.bg_active
theme.taglist_fg_urgent         = theme.red

theme.barcolor                  = theme.bg_main
theme.bg_systray                = theme.bg_main
theme.border_width              = dpi(2)
theme.useless_gap               = dpi(6)

theme.tasklist_plain_task_name  = true
theme.tasklist_disable_icon     = true

theme.notification_fg           = theme.fg_accent_alt
theme.notification_bg           = theme.bg_accent_alt
theme.notification_border_color = theme.bg_accent_alt
theme.notification_margin       = dpi(20)
naughty.config.defaults.margin  = theme.notification_margin

theme.menubar_fg_focus          = theme.fg_accent_alt
theme.menubar_bg_focus          = theme.bg_accent_alt
theme.menubar_fg_normal         = theme.fg_dim
theme.menubar_bg_normal         = theme.bg_dim

theme.tagnames             = { "1", "2", "3", "4", "5", "6", "7" }
-- theme.tagnames             = { "A", "W", "E", "S", "O", "M", "E" }
-- theme.tagnames             = { "a", "w", "e", "s", "o", "m", "e" }
awful.util.tagnames = theme.tagnames

function theme.at_screen_connect(s)

   -- if theme.wallpaper:match("^#") then
   --    gears.wallpaper.set(theme.wallpaper, s, true)
   -- else
   --    gears.wallpaper.maximized(theme.wallpaper, s, true)
   -- end
   -- local symbol = "∞"
   local symbol = "♥"
    bling.module.tiled_wallpaper(symbol, s, {
        fg = theme.bg_accent_alt, -- define the foreground color
        bg = theme.wallpaper, -- define the background color
        offset_y = 10,  -- set a y offset
        offset_x = 5,  -- set a x offset
        font = "Iosevka",  -- set the font (without the size)
        font_size = 25, -- set the font size
        padding = 100,  -- set padding (default is 100)
        zickzack = true -- rectangular pattern or criss cross
    })

   -- Tags
   awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

   bar(s, theme)
end

return theme
