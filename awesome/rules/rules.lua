local awful = require("awful")
local beautiful = require("beautiful")

-- Make sure you require("rules.rules") after beautiful.init
local tagnames = awful.util.tagnames

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
myrules = {
   -- All clients will match this rule.
   { rule = { },
     properties = { border_width = beautiful.border_width,
		    border_color = beautiful.border_normal,
		    focus = awful.client.focus.filter,
		    raise = true,
		    keys = clientkeys,
		    buttons = clientbuttons,
		    size_hints_honor = false, -- Remove gaps between terminals
		    screen = awful.screen.preferred,
		    callback = awful.client.setslave,
		    placement = awful.placement.no_overlap + awful.placement.no_offscreen
     }
   },
   -- Floating clients.
   { rule_any = {
	instance = {
	   "DTA", -- Firefox addon DownThemAll.
	   "copyq", -- Includes session name in class.
	},
	class = {
	   "Arandr",
	   "Gpick",
	   "Gcolor3",
	   "Kruler",
	   "MessageWin", -- kalarm.
	   -- "Sxiv",
	   -- "feh",
	   "Wpa_gui",
	   "pinentry",
	   "veromix",
	   "xtightvncviewer"
	},
	name = {
	   "Event Tester", -- xev.
	},
	role = {
	   "AlarmWindow", -- Thunderbird's calendar.
	   "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
	}
   }, properties = { floating = true }},

   -- Add titlebars to normal clients and dialogs
   { rule_any = {type = { "normal", "dialog" } },
     properties = { titlebars_enabled = true }
   },

   -- Set Lollypop to always map on the tag named tagnames[3] on screen 1.
   { rule = { class = "Lollypop" },
     properties = { screen = 1, tag = tagnames[3] },
     callback = function ()
        local screen = awful.screen.focused()
        local tag = screen.tags[3]
        if tag then
           tag:view_only()
        end
     end
   },

   -- Set Quodlibet to always map on the tag named tagnames[3] on screen 1.
   { rule = { class = "Quodlibet" },
     properties = { screen = 1, tag = tagnames[3] },
     callback = function ()
        local screen = awful.screen.focused()
        local tag = screen.tags[3]
        if tag then
           tag:view_only()
        end
     end
   },

   -- Set Smplayer to always map on the tag named tagnames[3] on screen 1.
   { rule = { class = "smplayer" },
     properties = { screen = 1, tag = tagnames[3] },
   },

   -- -- Set Chromium to always map on the tag named "6" on screen 1.
   -- { rule = { class = "Chromium" },
   --   properties = { screen = 1, tag = "6" },
   -- },

   -- fix brave apps (lichess) floating mode
   -- lichess
   { rule = { instance = "crx_pdihgkikjgccndbckbcgjmcnpkockcjg" },
     properties = { floating = false },
   },
}
-- }}}

return myrules
