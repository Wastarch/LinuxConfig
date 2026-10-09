local wezterm = require 'wezterm'
local config = {}
-- ====================== 基础外观设置 ======================
config.font = wezterm.font("0xProto Nerd Font Mono")
config.font_size = 14
config.color_scheme = 'Catppuccin Mocha'
config.window_background_opacity = 0.50
config.win32_system_backdrop = 'Acrylic'
config.initial_cols = 120
config.initial_rows = 32
config.default_domain = 'WSL:Ubuntu-24.04'
config.audible_bell = "Disabled"
config.adjust_window_size_when_changing_font_size = false

-- -- -- ========== Tabbar核心配置 ==========
-- config.hide_tab_bar_if_only_one_tab = true
-- config.use_fancy_tab_bar = false
-- config.tab_bar_at_bottom = false
-- config.show_tabs_in_tab_bar = false  -- 配合 fancy 才生效
-- config.show_new_tab_button_in_tab_bar = false


config.status_update_interval = 1000

-- ====================== 自定义快捷键 ======================
config.keys = {
    {
        key = 'v',
        mods = 'CTRL',
        action = wezterm.action.PasteFrom 'Clipboard'
    },
    {
        key = 'c',
        mods = 'CTRL',
        action = wezterm.action.CopyTo 'Clipboard'
    },

    {
        key = 'v',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.SplitHorizontal,
    },
    {
        key = 'h',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.SplitVertical,
    },
    {
        key = 'w',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.CloseCurrentPane { confirm = false },
    },
    { key = 'LeftArrow', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Left' },
    { key = 'RightArrow', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Right' },
    { key = 'UpArrow', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Up' },
    { key = 'DownArrow', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Down' },
    { key = 't', mods = 'CTRL|SHIFT', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
    { key = 'r', mods = 'CTRL|SHIFT', action = wezterm.action.ReloadConfiguration },
    {key = '0', mods = 'CTRL', action = wezterm.action.ResetFontSize}
}
-- ====================== Ctrl+鼠标滚轮缩放字体 ======================
config.mouse_bindings = {
  {
    event = { Down = { streak = 1, button = { WheelUp = 1 } } },
    mods = 'CTRL',
    action = wezterm.action.IncreaseFontSize,
  },
  {
    event = { Down = { streak = 1, button = { WheelDown = 1 } } },
    mods = 'CTRL',
    action = wezterm.action.DecreaseFontSize,
  },
}
-- ====================== 状态栏内容======================
wezterm.on('update-status', function(window, pane)
    -- 获取当前时间
    local date = wezterm.strftime '%Y-%m-%d %H:%M:%S'
    local username = os.getenv('USER') or os.getenv('USERNAME') or '?'
    -- local mux_window = window:mux_window()
    local workspace = window:mux_window():get_workspace()
    -- local workspace = tostring(window:active_workspace() or '?')

    -- 设置右侧状态栏（右对齐，空间不足会从左侧裁剪）
    window:set_right_status(wezterm.format {
        { Background = { Color = '#585b70' } },
        { Foreground = { Color = '#88c0d0' } },
        { Text = ' ' .. username .. ' | ' .. workspace .. ' | ' .. date .. ' ' },
    })
end)


config.scrollback_lines = 5000
return config
