local terminal = "wezterm"
local file_manager = "dolphin"
local menu = "~/.config/rofi/launchers/type-2/launcher.sh || pkill rofi"

-- Open terminal
hl.bind("SUPER + Q", hl.dsp.exec_cmd(terminal))

-- Open terminal and connect to wezterm mux session
hl.bind("SUPER + A", function()
  hl.dispatch(hl.dsp.exec_cmd("wezterm connect unix", {
    float = true,
    size = { "monitor_w * 0.54", "monitor_h * 0.52" },
    -- move = { "cursor_x - (window_w * 0.5)", "cursor_y - (window_h * 0.5)" },
  }))
end)

-- Open file manager
hl.bind("SUPER + E", hl.dsp.exec_cmd(file_manager))

-- Close current window
hl.bind("SUPER + SHIFT + W", hl.dsp.window.close())

-- Close hyprland
hl.bind("SUPER + SHIFT + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))

-- Open wlogout
hl.bind("SUPER + M", hl.dsp.exec_cmd("~/.config/wlogout/wlogout.sh"))

-- Open swaync
hl.bind("SUPER + N", hl.dsp.exec_cmd("swaync-client -t -sw"))

-- Open orbit
hl.bind("SUPER + B", hl.dsp.exec_cmd("orbit toggle"))

-- Toggle floating
hl.bind("SUPER + T", function()
  hl.dispatch(hl.dsp.window.resize({ x = 2800, y = 1600 }))
  -- hl.dispatch(hl.dsp.window.resize({ "monitor_w * 0.6", "monitor_h * 0.5" }))
  hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
  hl.dispatch(hl.dsp.window.center())
end)

-- Toggle fullscreen
hl.bind("SUPER + F", function()
  hl.dispatch(hl.dsp.window.fullscreen({
    mode = "fullscreen",
    action = "toggle",
  }))
  hl.dispatch(hl.dsp.exec_cmd("killall -SIGUSR1 waybar"))
end)

-- Open file picker
hl.bind("SUPER + space", hl.dsp.exec_cmd(menu))
hl.bind("ALT + space", hl.dsp.exec_cmd(menu))

-- Reload hyprland
hl.bind("SUPER + R", hl.dsp.exec_cmd("~/.config/hypr/scripts/reload.sh"))

-- Take screenshot
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh"))

-- Take full screenshot
hl.bind("SUPER + S", hl.dsp.exec_cmd("~/.config/hypr/scripts/full_screenshot.sh"))

-- Move focus with SUPER + vim motion
hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))

-- Move focus with SUPER + SHIFT + vim motion
hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

-- Adjust window size with SUPER + above vim motion
hl.bind("SUPER + U", hl.dsp.window.resize({ x = -25, y = 0, relative = true}))
hl.bind("SUPER + I", hl.dsp.window.resize({ x = 0, y = -25, relative = true}))
hl.bind("SUPER + O", hl.dsp.window.resize({ x = 0, y = 25, relative = true}))
hl.bind("SUPER + P", hl.dsp.window.resize({ x = 25, y = 0, relative = true}))

for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0

  -- Switch workspaces with SUPER + [0-9]
  hl.bind("SUPER + " .. key,             hl.dsp.focus({ workspace = i}))

  -- Move active window to a worspace with SUPER + SHIFT + [0-9]
  hl.bind("SUPER + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces with SUPER + scroll
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("mouse:275", hl.dsp.exec_cmd("~/.config/hypr/scripts/volume.sh down"), { locked = true, repeating = true })
hl.bind("mouse:276", hl.dsp.exec_cmd("~/.config/hypr/scripts/volume.sh up"), { locked = true, repeating = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("~/.config/hypr/scripts/volume.sh up"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("~/.config/hypr/scripts/volume.sh down"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 4%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 4%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Trackpad gestures
hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace",
})

hl.gesture({
  fingers = 3,
  direction = "up",
  action = "float",
  mode = "float",
})

hl.gesture({
  fingers = 3,
  direction = "down",
  action = "float",
  mode = "tile",
})
