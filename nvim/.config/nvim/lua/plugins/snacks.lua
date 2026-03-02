-- Snacks.nvim picker (fuzzy finder)
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    animate = {
      duration = { step = 10, total = 150 },
      easing = "outQuad",
      fps = 120,
    },
    dashboard = {
      enabled = true,
    },
    image = {
      enabled = true,
    },
    indent = {
      enabled = true,
    },
    gitbrowse = {
      enabled = true,
    },
    lazygit = {
      enabled = true,
      theme = {
        defaultFgColor = { fg = "Normal" },
        selectedLineBgColor = { bg = "Visual" },
        cherryPickedCommitBgColor = { bg = "Visual" },
        optionsTextColor = { fg = "Function" },
        inactiveBorderColor = { fg = "FloatBorder" },
        activeBorderColor = { fg = "MatchParen" },
      },
    },
    picker = {
      enabled = true,
      layout = {
        layout = {
          backdrop = false,
          box = "horizontal",
          width = 0.95,
          height = 0.9,
          border = "rounded",
          title = "{title} {live} {flags}",
          title_pos = "center",
          {
            box = "vertical",
            { win = "input", height = 1, border = "bottom" },
            { win = "list", border = "none" },
          },
          {
            win = "preview",
            title = "{preview}",
            title_pos = "center",
            width = 0.33,
            border = "left",
          },
        },
      },
    },
    scroll = {
      enabled = true,
    },
    statuscolumn = {
      enabled = true,
    },
  },
}
