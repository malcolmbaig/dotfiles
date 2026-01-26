return {
  "sainnhe/gruvbox-material",
  lazy = false,
  priority = 1000,
  init = function()
    vim.o.background = "dark"
    vim.g.gruvbox_material_background = "medium"
    vim.g.gruvbox_material_transparent_background = 1
  end,
  config = function()
    vim.cmd("colorscheme gruvbox-material")
    -- Transparent floating windows, borders, and titles
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "FloatTitle", { bg = "NONE" })
  end,
}

-- return {
--   'everviolet/nvim',
--   name = 'evergarden',
--   lazy = false,
--   priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
--   config = function()
--     require("evergarden").setup(
--       {
--           theme = {
--             variant = 'fall', -- 'winter'|'fall'|'spring'|'summer'
--             accent = 'green',
--           },
--           editor = {
--             transparent_background = false,
--             sign = { color = 'none' },
--             float = {
--               color = 'mantle',
--               solid_border = false,
--             },
--             completion = {
--               color = 'surface0',
--             },
--           },
--       }
--     )
--     vim.cmd("colorscheme evergarden")
--   end,
-- }
