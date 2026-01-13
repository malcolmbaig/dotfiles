-- Lualine statusline for a clean, informative bar
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = function()
    -- Custom component for worktree indicator
    local worktree_indicator = function()
      local bufpath = vim.api.nvim_buf_get_name(0)
      if bufpath:match("wt/") then
        return "worktree"
      end
      return ""
    end

    return {
      options = {
        theme = "auto",
        icons_enabled = true,
        globalstatus = true,
        section_separators = "",
        component_separators = "",
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {
        lualine_a = {},
        lualine_b = {
          {
            "tabs",
            mode = 2, -- 0: shows tab number, 1: shows tab name, 2: shows both
            max_length = vim.o.columns,
          },
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {
          {
            worktree_indicator,
            color = { fg = "#282828", bg = "#fabd2f", gui = "bold" },
            cond = function()
              local bufpath = vim.api.nvim_buf_get_name(0)
              return bufpath:match("wt/") ~= nil
            end,
          },
        },
        lualine_z = {},
      },
    }
  end,
}
