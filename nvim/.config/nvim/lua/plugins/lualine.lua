-- Lualine statusline for a clean, informative bar
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- Custom component for worktree indicator
    local worktree_indicator = function()
      local bufpath = vim.api.nvim_buf_get_name(0)
      if bufpath:match("wt/") then
        return "worktree"
      end
      return ""
    end

    require('lualine').setup({
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
    })

    -- Override the tabline fill color without affecting the statusline.
    -- Lualine uses the same lualine_c_<mode> highlight for both statusline
    -- and tabline fill areas. We intercept the tabline string and swap in
    -- a custom highlight group so only the tabline is affected.
    local tabfill_bg = "#282828" -- gruvbox-material dark medium bg0

    local function create_tabfill_hl()
      local c_hl = vim.api.nvim_get_hl(0, { name = "lualine_c_normal", link = false })
      vim.api.nvim_set_hl(0, "LualineTabFill", { bg = tabfill_bg, fg = c_hl.fg })
    end

    create_tabfill_hl()

    local augroup = vim.api.nvim_create_augroup("LualineTabFill", { clear = true })

    vim.api.nvim_create_autocmd("OptionSet", {
      group = augroup,
      pattern = "tabline",
      callback = function()
        local tl = vim.v.option_new
        if tl and tl:find("lualine_c_") then
          local new_tl = tl:gsub("%%#lualine_c_%w+#", "%%#LualineTabFill#")
          if new_tl ~= tl then
            vim.o.tabline = new_tl
          end
        end
      end,
    })

    vim.api.nvim_create_autocmd("ColorScheme", {
      group = augroup,
      callback = function()
        vim.schedule(create_tabfill_hl)
      end,
    })
  end,
}
