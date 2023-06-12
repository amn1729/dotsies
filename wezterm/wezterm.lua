local wezterm = require 'wezterm';
local keys = require 'keys';

wezterm.on(
   'bell',
   function(window, pane)
      -- wezterm.log_info('the bell was rung in pane ' .. pane:pane_id() .. '!')
      os.execute("notify-send 'Finished Task' 'Wezterm'")
      window:request_attention()
   end
)

return {
   font = wezterm.font_with_fallback({
         {
            family="Iosevka Comfy",
            -- family="Iosevka Term SS04",
            harfbuzz_features={"liga=1", "clig=1"},
         },
         "DejaVu Sans",
         "Hack",
         "Noto Sans Bamum",
         "Noto Sans Ol Chiki"
   }),
   font_size = 13.5,
   disable_default_key_bindings = true,
   enable_tab_bar = false,
   default_cursor_style = "BlinkingBar",
   keys = keys,
   adjust_window_size_when_changing_font_size = false,
   color_scheme = 'Ef-Cherie',
}
