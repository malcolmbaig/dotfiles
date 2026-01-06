-- File explorer with icons
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    {
      "nvim-tree/nvim-web-devicons",
      opts = {
        color_icons = true,
        default = false,
        strict = false,
        variant = "auto",
      },
    },
  },
  opts = {
    sort = {
      sorter = "case_sensitive",
    },
    view = {
      width = 50,
    },
    renderer = {
      group_empty = true,
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
      },
    },
    filters = {
      dotfiles = false,
      custom = { "^.git$" },
    },
    git = {
      enable = true,
      ignore = false,
    },
    actions = {
      open_file = {
        quit_on_open = false,
      },
    },
  },
}
