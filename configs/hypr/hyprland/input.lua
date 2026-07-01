hl.config({
  input = {
    kb_layout  = "us",
    kb_variant = "",
    kb_model   = "",
    kb_options = "caps:escape",
    kb_rules   = "",

    -- Specify if and how cursor movement should affect window focus
    follow_mouse = 1,

    sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

    -- sensitivity = 0.2, -- for trackpad
    -- sensitivity = -0.7, -- for mouse (razer deatheradder v2)

    touchpad = {
      natural_scroll = true,
      scroll_factor = 0.45,
    },
  },
})

-- hl.device({
--   -- doesnt seem to work :(
--     name = "razer-razer-deathadder-v2-x-hyperspeed-mouse",
--     sensitivity = 1,
--   })
