-- Which-key for keymap discovery
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    delay = function(ctx)
      return ctx.plugin and 0 or 200
    end,
    triggers = {
      { "<auto>", mode = "nxso" },
    },
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = true,
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
    win = {
      no_overlap = true,
      padding = { 1, 2 },
      title = true,
      title_pos = "center",
      border = "single",
      zindex = 1000,
    },
    sort = { "local", "order", "group", "alphanum", "mod" },
    icons = {
      breadcrumb = "»",
      separator = "➜",
      group = "+",
      mappings = true,
      colors = true,
    },
    spec = {
      -- Leader key groups for better organization
      { "<leader>b", group = "Buffer" },
      { "<leader>s", group = "Search" },
      { "<leader>t", group = "Tab" },
    },
  },
}
