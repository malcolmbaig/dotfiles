-- Gruvbox Material colorscheme (dark hard)
return {
  "sainnhe/gruvbox-material",
  lazy = false,
  priority = 1000,
  init = function()
    vim.o.background = "dark"
    vim.g.gruvbox_material_background = "hard"
  end,
  config = function()
    vim.cmd("colorscheme gruvbox-material")
  end,
}
