hl.window_rule({
  -- Ignore maximize requests from all apps. You'll probably like this.
  name  = "suppress-maximize-events",
  match = { class = ".*" },

  suppress_event = "maximize",
})

hl.window_rule({
  -- Fix some dragging issues with XWayland
  name  = "fix-xwayland-drags",
  match = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },

  no_focus = true,
})

hl.window_rule({
  name  = "move-hyprland-run",
  match = { class = "hyprland-run" },

  move  = "20 monitor_h-120",
  float = true,
})

hl.window_rule({
  name = "screenshot-float",
  match = { class = "^(org.kde.gwenview)$" },
  float = true,
  size = "{960, 540}",
  center = true,
})

hl.window_rule({
  name = "file-picker-float",
  match = { class = "^(xdg-desktop-portal-gtk)$" },
  float = true,
  size = "{960, 540}",
  center = true,
  opacity = "0.9",
})

-- make network manager float (nm-connection-editor)
hl.window_rule({
  name = "nm-float",
  match = { class = "^(nm-connection-editor)$" },
  float = true,
  size = "{1400, 800}",
  center = true,
  opacity = "0.85",
})

-- make blueman float
hl.window_rule({
  name = "blueman-float",
  match = { class = "^(blueman-manager)$" },
  float = true,
  size = "{1400, 800}",
  center = true,
  opacity = "0.85",
})

-- stop wezterm blur
hl.window_rule({
  name = "wezterm-no-blur",
  match = { class = "^(org.wezfurlong.wezterm)$" },
  no_blur = true,
})

-- disable rounding for fullscreen applications
hl.window_rule({
  name = "fullscreen-no-rounding",
  match = { fullscreen = true },
  rounding = 0,
})

hl.window_rule({
  name = "discord-popup",
  match = { initial_title = "^(Discord Popout)$" },
  float = true,
  size = "{640, 380}",
  center = true,
})

hl.layer_rule({
  name = "wlogout-blur",
  match = { namespace = "logout_dialog" },
  blur = true,
})
