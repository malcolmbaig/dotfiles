return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  ft = { "markdown" },
  opts = {
    render_modes = { "n", "c" },
    anti_conceal = { enabled = true },
  },
  config = function(_, opts)
    require("render-markdown").setup(opts)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.breakindent = true
      end,
    })
  end,
}
