local wezterm = require("wezterm")
local os = require("os")
local act = wezterm.action
local mux = wezterm.mux
local config = wezterm.config_builder()

-- ============================================================================
-- DEFAULT DOMAIN
-- ============================================================================
config.default_domain = "WSL:Ubuntu-24.04"

-- ============================================================================
-- COLOR SCHEME
-- ============================================================================
config.color_scheme = "Catppuccin Frappe"

-- ============================================================================
-- FONT CONFIGURATION
-- ============================================================================
config.font = wezterm.font("FiraCode Nerd Font", { weight = "Medium", stretch = "Expanded" })
config.font_size = 12.0
config.line_height = 1.2
config.cell_width = 1.0

-- ============================================================================
-- WINDOW GEOMETRY
-- ============================================================================
config.initial_cols = 120
config.initial_rows = 25

wezterm.on("gui-startup", function(cmd)
  local screen = wezterm.gui.screens().active
  local tab, pane, window = mux.spawn_window(cmd or {})
  local gui_window = window:gui_window()
  local dims = gui_window:get_dimensions()
  local x = (screen.width - dims.pixel_width) / 2
  local y = (screen.height - dims.pixel_height) / 2
  gui_window:set_position(x, y)
end)

-- ============================================================================
-- BACKGROUND
-- ============================================================================
local home_dir = os.getenv("USERPROFILE") or os.getenv("HOME")

config.background = {
  -- LAYER 1: the actual background image
  {
    source = {
      File = home_dir .. "/dotfiles/assets/background.jpg",
    },
    height = "Cover",
    width = "Cover",
    horizontal_align = "Center",
    vertical_align = "Middle",
    opacity = 1.0,
    hsb = {
      brightness = 0.2,
      hue = 1.0,
      saturation = 0.9,
    },
  },
  -- LAYER 2: a flat color tint/overlay
  {
    source = {
      Color = "rgba(30, 30, 46, 0.5)",
    },
    height = "100%",
    width = "100%",
  },
}

config.window_background_opacity = 1.0
config.text_background_opacity = 1.0

-- ============================================================================
-- WINDOW DECORATIONS
-- ============================================================================
config.window_padding = {
  left = 16,
  right = 16,
  top = 8,
  bottom = 8,
}

config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"

config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false

-- ============================================================================
-- CURSOR
-- ============================================================================
config.default_cursor_style = "BlinkingBar" -- "BlinkingBlock" | "BlinkingUnderline" | "SteadyBar" | "SteadyBlock" | "SteadyUnderline"
config.cursor_blink_rate = 600
config.cursor_thickness = 1
config.animation_fps = 60

-- ============================================================================
-- PERFORMANCE
-- ============================================================================
config.front_end = "WebGpu"
config.max_fps = 120
config.enable_kitty_graphics = true

-- ============================================================================
-- COLOR SCHEME PICKER (LEADER + c)
-- ============================================================================
local scheme_choices = {}
for name, _ in pairs(wezterm.get_builtin_color_schemes()) do
  table.insert(scheme_choices, { label = name })
end
table.sort(scheme_choices, function(a, b)
  return a.label < b.label
end)

local color_scheme_picker = {
  title = "Pick a Color Scheme",
  choices = scheme_choices,
  fuzzy = true,
  fuzzy_description = "Search color schemes: ",
  action = wezterm.action_callback(function(window, _pane, _id, label)
    if not label then
      return
    end
    local overrides = window:get_config_overrides() or {}
    overrides.color_scheme = label
    window:set_config_overrides(overrides)
  end),
}

-- ============================================================================
-- DYNAMIC TAB SWITCHING (LEADER + any digit 1-9)
-- ============================================================================
local tab_switch_keys = {}
for i = 1, 9 do
  table.insert(tab_switch_keys, {
    key = tostring(i),
    mods = "LEADER",
    action = act.ActivateTab(i - 1),
  })
end

-- ============================================================================
-- PANE RESIZING
-- "LEADER + ←" / "LEADER + →" shrink/grow the active pane horizontally.
-- "LEADER + ↓" / "LEADER + ↑" shrink/grow the active pane vertically.
-- ============================================================================
local RESIZE_STEP = 3

local function resize_active_pane(grow, axis)
  return wezterm.action_callback(function(window, pane)
    local tab = pane:tab()
    if not tab then
      return
    end

    local probe_dir, push_dir, opposite_push_dir
    if axis == "horizontal" then
      probe_dir, push_dir, opposite_push_dir = "Left", "Left", "Right"
    else
      probe_dir, push_dir, opposite_push_dir = "Up", "Up", "Down"
    end

    local has_neighbor_before = tab:get_pane_direction(probe_dir) ~= nil

    local direction
    if has_neighbor_before then
      direction = grow and push_dir or opposite_push_dir
    else
      direction = grow and opposite_push_dir or push_dir
    end

    window:perform_action(act.AdjustPaneSize({ direction, RESIZE_STEP }), pane)
  end)
end

-- ============================================================================
-- KEYBINDINGS
-- ============================================================================
config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
  -- ---------------------------------------------------------------------
  -- GENERAL
  -- ---------------------------------------------------------------------
  { key = "r", mods = "LEADER", action = act.ReloadConfiguration }, -- reload config
  { key = "p", mods = "CTRL|SHIFT", action = act.ActivateCommandPalette }, -- command palette
  { key = "o", mods = "LEADER", action = act.ShowLauncher }, -- launcher menu
  { key = "c", mods = "LEADER", action = act.InputSelector(color_scheme_picker) }, -- color scheme switcher
  { key = "F11", mods = "NONE", action = act.ToggleFullScreen }, -- toggle fullscreen
  { key = "F12", mods = "NONE", action = act.Hide }, -- hide window

  -- ---------------------------------------------------------------------
  -- FONT SIZE
  -- ---------------------------------------------------------------------
  { key = "=", mods = "CTRL", action = act.IncreaseFontSize }, -- increase font size
  { key = "-", mods = "CTRL", action = act.DecreaseFontSize }, -- decrease font size
  { key = "0", mods = "CTRL", action = act.ResetFontSize }, -- reset font size

  -- ---------------------------------------------------------------------
  -- CLIPBOARD
  -- ---------------------------------------------------------------------
  { key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") }, -- copy to clipboard
  { key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") }, -- paste from clipboard

  -- ---------------------------------------------------------------------
  -- WINDOW
  -- ---------------------------------------------------------------------
  { key = "n", mods = "LEADER", action = act.SpawnWindow }, -- new window

  -- ---------------------------------------------------------------------
  -- TABS
  -- ---------------------------------------------------------------------
  { key = "t", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") }, -- new tab
  { key = "q", mods = "LEADER", action = act.CloseCurrentTab({ confirm = false }) }, -- close tab
  { key = "[", mods = "LEADER", action = act.ActivateTabRelative(-1) }, -- previous tab
  { key = "]", mods = "LEADER", action = act.ActivateTabRelative(1) }, -- next tab
  {
    key = "e",
    mods = "LEADER",
    action = act.PromptInputLine({
      description = "Rename tab",
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    }),
  }, -- rename tab

  -- ---------------------------------------------------------------------
  -- PANES
  -- ---------------------------------------------------------------------
  { key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) }, -- split down
  { key = "\\", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) }, -- split right
  { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") }, -- move to left pane
  { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") }, -- move to right pane
  { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") }, -- move to upper pane
  { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") }, -- move to lower pane
  { key = "z", mods = "LEADER", action = act.TogglePaneZoomState }, -- toggle pane zoom
  { key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = false }) }, -- close pane
  {
    key = "w",
    mods = "LEADER",
    action = act.ActivateKeyTable({
      name = "resize_pane",
      one_shot = false,
      timeout_milliseconds = 3000,
    }),
  }, -- enter resize mode
}

-- ===========================================================================
-- KEY TABLES
-- ===========================================================================
local resize_pane_mode = {
  UpArrow = resize_active_pane(true, "vertical"),
  DownArrow = resize_active_pane(false, "vertical"),
  RightArrow = resize_active_pane(true, "horizontal"),
  LeftArrow = resize_active_pane(false, "horizontal"),
}

config.key_tables = {
  resize_pane = {
    { key = "UpArrow", action = resize_pane_mode.UpArrow },
    { key = "DownArrow", action = resize_pane_mode.DownArrow },
    { key = "RightArrow", action = resize_pane_mode.RightArrow },
    { key = "LeftArrow", action = resize_pane_mode.LeftArrow },
    { key = "Escape", action = "PopKeyTable" },
    { key = "Enter", action = "PopKeyTable" },
  },
}

for _, k in ipairs(tab_switch_keys) do
  table.insert(config.keys, k)
end

-- ============================================================================
-- MISC QUALITY-OF-LIFE
-- ============================================================================
config.automatically_reload_config = true
config.check_for_updates = false
 
config.audible_bell = "Disabled"
config.visual_bell = {
  fade_in_duration_ms = 75,
  fade_out_duration_ms = 75,
  target = "CursorColor",
}
 
return config
