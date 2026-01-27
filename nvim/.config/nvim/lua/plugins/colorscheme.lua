local scheme = "gruvbox"

local function set_transparent_floats()
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "FloatTitle", { bg = "NONE" })
end

return {
  {
    "sainnhe/gruvbox-material",
    enabled = scheme == "gruvbox",
    lazy = false,
    priority = 1000,
    init = function()
      vim.o.background = "dark"
      vim.g.gruvbox_material_background = "medium"
      vim.g.gruvbox_material_transparent_background = 1
    end,
    config = function()
      vim.cmd("colorscheme gruvbox-material")
      set_transparent_floats()
    end,
  }
}
