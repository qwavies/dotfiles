-- -------------------------------------------------
-- Wezterm Config
-- https://github.com/qwavies
-- (Hopefully someday wezterm will add smear cursor 🙏)
-- -------------------------------------------------

local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- -------------------------------------------------
--
-- Fast Access Tweaks
--
-- -------------------------------------------------

-- 0 is fully transparent
-- 1 is not transparent
local transparency_value = 0.57

config.font = wezterm.font_with_fallback({
  -- "Monocraft",
  "CaskaydiaMono Nerd Font",
  -- "FiraCode Nerd Font",
  -- "JetBrainsMono Nerd Font",
  -- "Adwaita Mono",
})
config.pane_focus_follows_mouse = true
-- config.default_cursor_style = "BlinkingBlock"
config.default_cursor_style = "SteadyBlock"
config.adjust_window_size_when_changing_font_size = false
config.window_padding = {
  left = 4,
  right = 0,
  top = 3,
  bottom = 0,
}

config.window_decorations = "RESIZE|NONE"
config.term = "xterm-256color"
config.front_end = "OpenGL"
config.enable_wayland = true
config.warn_about_missing_glyphs = true
config.prefer_egl = true
config.font_size = 36
config.max_fps = 144
config.animation_fps = 1
config.cursor_blink_rate = 600
config.initial_cols = 80
config.initial_rows = 20
config.cell_width = 0.9 -- can look better/worse depending on font

config.window_background_opacity = transparency_value

-- -------------------------------------------------
--
-- Terminal Background and Accent Colors
--
-- -------------------------------------------------

local color_accent = "rgb(196, 200, 255)" -- hex: #cfd3ff
local darken_color = "rgb(12, 11, 15)" -- hex: #0c0b0f
local select_color = "rgb(192, 192, 192)" -- hex: #c0c0c0
-- local solid_background_color = "rgb(48, 52, 70)" -- hex: #303446 (only used when background opacity is turned off)
local solid_background_color = "rgb(41, 45, 61)" -- hex: #292D3D (only used when background opacity is turned off)

local color_accent_transparent = color_accent:gsub(
  "rgb%((.*)%)",
  string.format("rgba(%%1, %s)", transparency_value)
)

-- -------------------------------------------------
--
-- Base Color scheme for Terminal
--
-- -------------------------------------------------

-- config.color_scheme = "Atlas (base16)"
-- config.color_scheme = "Banana Blueberry"
-- config.color_scheme = "Belge (terminal.sexy)"
-- config.color_scheme = "Blazer" -- greyscaled
-- config.color_scheme = "BlueDolphin"
-- config.color_scheme = "Ayu Mirage"
config.color_scheme = "Bim (Gogh)" -- fav

-- -------------------------------------------------
--
-- Setting Colors
--
-- -------------------------------------------------

config.colors = {
  background = darken_color,
  cursor_border = color_accent,
  -- cursor_fg = "#333333",
  cursor_bg = color_accent,
  split = color_accent_transparent,
  -- split = color_accent,

  tab_bar = {
    background = "None",
    active_tab = {
      bg_color = "None",
      fg_color = color_accent,
      intensity = "Bold",
      underline = "None",
    },
    inactive_tab = {
      bg_color = "None",
      fg_color = select_color,
      intensity = "Normal",
      underline = "None",
    },
    inactive_tab_hover = {
      bg_color = "None",
      fg_color = select_color,
      intensity = "Normal",
      underline = "None",
    },
    new_tab = {
      bg_color = "None",
      fg_color = select_color,
      intensity = "Half",
    },
    new_tab_hover = {
      bg_color = "None",
      fg_color = select_color,
      intensity = "Normal",
    },
  }
}

-- -------------------------------------------------
--
-- Transparency Toggle
--
-- -------------------------------------------------

wezterm.on("toggle-transparency",  function(window, _)
  local overrides = window:get_config_overrides() or {}
  overrides.colors = config.colors

  if (overrides.window_background_opacity == transparency_value) or (overrides.window_background_opacity == nil) then
    overrides.window_background_opacity = 999
    overrides.colors.background = solid_background_color
  else
    overrides.window_background_opacity = transparency_value
    overrides.colors.background = darken_color
  end

  window:set_config_overrides(overrides)
end)

config.keys = {
  -- -------------------------------------------------
  -- Toggle transparency
  --
  -- CTRL + ALT + b
  -- -------------------------------------------------
  {
    key = "b",
    mods = "CTRL|ALT",
    action = wezterm.action.EmitEvent("toggle-transparency"),
  },

  -- -------------------------------------------------
  -- Create new panes using vim directions h,j,k,l
  --
  -- CTRL + ALT + DIRECTION
  -- -------------------------------------------------
  {
    key = "h",
    mods = "CTRL|ALT",
    action = wezterm.action.SplitPane({
      direction = "Left",
      size = { Percent = 50 },
    }),
  },
  {
    key = "j",
    mods = "CTRL|ALT",
    action = wezterm.action.SplitPane({
      direction = "Down",
      size = { Percent = 50 },
    }),
  },
  {
    key = "k",
    mods = "CTRL|ALT",
    action = wezterm.action.SplitPane({
      direction = "Up",
      size = { Percent = 50 },
    }),
  },
  {
    key = "l",
    mods = "CTRL|ALT",
    action = wezterm.action.SplitPane({
      direction = "Right",
      size = { Percent = 50 },
    }),
  },

  -- -------------------------------------------------
  -- Resize panes using keys above the vim keys u,i,o,p
  --
  -- CTRL + ALT + DIRECTION
  -- -------------------------------------------------
  { key = "u", mods = "CTRL|ALT", action = wezterm.action.AdjustPaneSize({ "Left", 3 }) },
  { key = "i", mods = "CTRL|ALT", action = wezterm.action.AdjustPaneSize({ "Down", 2 }) },
  { key = "o", mods = "CTRL|ALT", action = wezterm.action.AdjustPaneSize({ "Up", 2 }) },
  { key = "p", mods = "CTRL|ALT", action = wezterm.action.AdjustPaneSize({ "Right", 3 }) },

  -- -------------------------------------------------
  -- Move to new pane using vim directions h,j,k,l
  --
  -- ALT + DIRECTION
  -- -------------------------------------------------
  { key = "h", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "j", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Down") },
  { key = "k", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Up") },
  { key = "l", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Right") },

  -- -------------------------------------------------
  -- Select Specific Pane
  --
  -- CTRL + '
  -- -------------------------------------------------
  {
    key = "'",
    mods = "CTRL",
    action = wezterm.action.PaneSelect
  },

  -- -------------------------------------------------
  -- Select Tab
  --
  -- CTRL + SHIFT + '
  -- -------------------------------------------------
  {
    key = "\"",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ShowTabNavigator
  },

  -- -------------------------------------------------
  -- Select Numbered Tab
  --
  -- CTRL + NUMBER
  -- -------------------------------------------------
  { key = "1", mods = "CTRL", action = wezterm.action.ActivateTab(0) },
  { key = "2", mods = "CTRL", action = wezterm.action.ActivateTab(1) },
  { key = "3", mods = "CTRL", action = wezterm.action.ActivateTab(2) },
  { key = "4", mods = "CTRL", action = wezterm.action.ActivateTab(3) },
  { key = "5", mods = "CTRL", action = wezterm.action.ActivateTab(4) },
  { key = "6", mods = "CTRL", action = wezterm.action.ActivateTab(5) },
  { key = "7", mods = "CTRL", action = wezterm.action.ActivateTab(6) },
  { key = "8", mods = "CTRL", action = wezterm.action.ActivateTab(7) },
  { key = "9", mods = "CTRL", action = wezterm.action.ActivateTab(8) },
  -- { key = "0", mods = "CTRL", action = wezterm.action.ActivateTab(9) },

  -- -------------------------------------------------
  -- New Tab
  --
  -- CTRL + t
  -- -------------------------------------------------
  {
    key = "t",
    mods = "CTRL",
    action = wezterm.action.SpawnTab("CurrentPaneDomain"),
  },

  -- -------------------------------------------------
  -- Close current pane
  --
  -- CTRL + SHIFT + w
  -- -------------------------------------------------
  {
    key = "w",
    mods = "CTRL|SHIFT",
    action = wezterm.action.CloseCurrentPane({ confirm = false }),
  },

  -- -------------------------------------------------
  -- Rename current tab
  --
  -- CTRL + SHIFT + r
  -- -------------------------------------------------
  {
    key = "r",
    mods = "CTRL|SHIFT",
    action = wezterm.action.PromptInputLine({
      description = "Enter new name for tab",
      action = wezterm.action_callback(
        function(window, _, line)
          if line then
            window:active_tab():set_title(line)
          end
        end
      )
    })
  },
}

-- -------------------------------------------------
--
-- Tab related settings
--
-- -------------------------------------------------

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_max_width = 22
-- makes fancy tab bar transparent
config.window_frame = {
  active_titlebar_bg = "None",
}

-- -------------------------------------------------
--
-- Pane related settings
--
-- -------------------------------------------------

config.inactive_pane_hsb = {
  -- brightness = 1.0,
  -- brightness = 0.8,
  brightness = 0.45,
  -- brightness = 0.2,
}

-- -------------------------------------------------
--
-- Pane related settings
--
-- -------------------------------------------------

config.unix_domains = {
  { name = "unix" },
}

-- -------------------------------------------------
--
-- Startup sequence
--
-- -------------------------------------------------

-- some examples. It (probably) makes sense to not use this when possible

-- config.default_prog = { "zsh" }
-- config.default_prog = { "powershell", "-NoLogo", "-NoExit", "-Command", "fastfetch" }
-- config.default_prog = { "powershell", "-NoLogo", "-NoExit" }
-- config.default_prog = { "wsl", "-NoLogo", "-Command", 'neofetch' }

return config
