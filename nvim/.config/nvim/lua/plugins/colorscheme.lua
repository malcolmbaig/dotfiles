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
--   "vague-theme/vague.nvim",
--   lazy = false, -- make sure we load this during startup if it is your main colorscheme
--   priority = 1000, -- make sure to load this before all the other plugins
--   config = function()
--     -- NOTE: you do not need to call setup if you don't want to.
--     require("vague").setup({
--       -- optional configuration here
--     })
--     vim.cmd("colorscheme vague")
--   end
-- }

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
