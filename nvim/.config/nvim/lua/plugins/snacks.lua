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
    },
    scroll = {
      enabled = true,
    },
    statuscolumn = {
      enabled = true,
    },
  },
  keys = {
    { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
    { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
    { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
  },
}
