return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
        ensure_installed = {
          "lua_ls",
          "pyright",
          "ruff"
        },
        handlers = {
          pyright = function()
            require("lspconfig").pyright.setup({
              settings = {
                python = {
                  analysis = {
                    typeCheckingMode = "off",
                  },
                },
              },
            })
          end,
        },
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
}
