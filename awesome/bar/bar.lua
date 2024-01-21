local gears  = require("gears")
local lain   = require("lain")
local awful  = require("awful")
local wibox  = require("wibox")
local dpi    = require("beautiful.xresources").apply_dpi
local markup = lain.util.markup

local bar = function(s, theme)
   local barheight = dpi(22)
   local separator = wibox.container.margin(
      wibox.widget{
         markup  = '|',
         align   = 'center',
         valign  = 'center',
         opacity = 0.3,
         widget  = wibox.widget.textbox
      }
      , dpi(6), dpi(6)
   )

   local clock = wibox.widget({
         {
            format = '%d %b %a, %I:%M ',
            widget = wibox.widget.textclock
         },
         fg = theme.fg_main,
         widget = wibox.container.background
   })

   local battery = lain.widget.bat({
         settings = function()
            if bat_now.ac_status == 1 then
               bat_header = " ↑ "
               -- bat_header = " "
            else
               bat_header = ""
            end
            -- bat_p = " " .. bat_now.perc
            bat_p = "B " .. bat_now.perc
            widget:set_markup(
               markup.font(theme.font, markup(theme.fg_main, bat_p .. bat_header))
            )
         end
   })

   local volume = lain.widget.alsa({
         settings = function()
            -- header = "   "
            header = "V "
            vlevel = volume_now.level

            if volume_now.status == "off" then
               vlevel = vlevel .. "M"
            else
               vlevel = vlevel .. ""
            end

            widget:set_markup(
               markup.font(theme.font, markup(theme.fg_main, header .. vlevel))
            )
         end
   })

   local taglist_buttons = gears.table.join(
      awful.button({ }, 1, function(t) t:view_only() end),
      awful.button({ modkey }, 1, function(t)
            if client.focus then
               client.focus:move_to_tag(t)
            end
      end),
      awful.button({ }, 3, awful.tag.viewtoggle),
      awful.button({ modkey }, 3, function(t)
            if client.focus then
               client.focus:toggle_tag(t)
            end
      end),
      awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
      awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
   )

   local mytaglist = awful.widget.taglist(
      s, awful.widget.taglist.filter.all, taglist_buttons
   )

   local clocker = awful.widget.watch(
      { awful.util.shell, "-c", "bash ~/.config/clocker/check.sh" },
      40,
      function(widget, stdout)
         local msg = "Clocked-In"
         local font_color = theme.fg_main
         if string.find(stdout, "Need") then
            font_color = theme.red
            msg = "Need to Clock-In right fucking now !!"
         end
         -- customize here
         widget:set_markup(
            markup.font(theme.font, markup(font_color, msg))
         )
      end
   )
   clocker:buttons(gears.table.join(
                      clocker:buttons(),
                      awful.button({}, 1, nil, function()
                            awful.spawn("alacritty -e '/mnt/projects/Selenium/clocker/run.sh'")
                      end)
   ))

   local lollypop = awful.widget.watch(
      "/home/krishna/.config/myshell/scripts/get-lollypop-title",
      1,
      function(widget, stdout)
         local font_color = theme.fg_main
         -- customize here
         widget:set_markup(
            markup.font(theme.font, markup(font_color, awful.util.escape(stdout)))
         )
      end
   )
   lollypop:buttons(gears.table.join(
                      lollypop:buttons(),
                      awful.button({}, 1, nil, function()
                            awful.spawn("lollypop -t")
                      end)
   ))

   -- Create the wibox
   -- Name is later used to toggle the bar visiblity
   s.mywibar = awful.wibar({
         position = "bottom", screen = s, height = barheight, bg = theme.barcolor
   })

   -- Add widgets to the wibox
   s.mywibar:setup {
      layout = wibox.layout.align.horizontal,
      expand = "none",
      { -- Left widgets
         layout = wibox.layout.fixed.horizontal,
         mytaglist,
      },
      clock,
      { -- Right widgets
         layout = wibox.layout.fixed.horizontal,
         wibox.widget.systray(),
         separator,
         clocker,
         separator,
         volume,
         separator,
         battery,
         separator,
         lollypop,
      },
   }
end

return bar
