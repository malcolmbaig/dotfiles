return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  opts = {
    formatters_by_ft = {
      jinja = { "djlint" },
    },
    format_on_save = {
      timeout_ms = 1000,
    },
    formatters = {
      djlint = {
        command = function()
          local venv = vim.fn.finddir(".venv", vim.fn.getcwd() .. ";")
          if venv ~= "" then
            return venv .. "/bin/djlint"
          end
          return "djlint"
        end,
      },
    },
  },
}
