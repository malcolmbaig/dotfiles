require 'lualine' .setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {{'filename', path = 1}},
    lualine_x = {},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {{'filename', path = 1}},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {
      {
        'tabs',
        -- 0: Shows tab_nr
        -- 1: Shows tab_name
        -- 2: Shows tab_nr + tab_name
        mode = 1,
        max_length = 1000,
        tabs_color = {
          -- Same values as the general color option can be used here.
          active = 'lualine_a_normal',     -- Color for active tab.
          inactive = 'lualine_a_inactive', -- Color for inactive tab.
        },
      }
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  extensions = {}
}
