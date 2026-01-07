-- Neovim options configuration
local opt = vim.opt
local g = vim.g

-- Disable netrw (for nvim-tree)
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- File encoding
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- Line numbers
opt.number = true
opt.relativenumber = true
opt.numberwidth = 4
opt.signcolumn = "yes"

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- UI/UX
opt.termguicolors = true
opt.cursorline = true
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
local function tabline()
  local s = ""
  for i = 1, vim.fn.tabpagenr("$") do
    local w = vim.fn.tabpagewinnr(i)
    local b = vim.fn.tabpagebuflist(i)[w]
    local name = vim.fn.bufname(b)
    name = (name == "") and "[No Name]" or vim.fn.fnamemodify(name, ":t")
    local hl = (i == vim.fn.tabpagenr()) and "%#TabLineSel#" or "%#TabLine#"
    s = s .. hl .. " " .. name .. " "
  end
  return s .. "%#TabLineFill#"
end
vim.o.showtabline = 2
vim.o.tabline = "%!v:lua.tabline()"
_G.tabline = tabline

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Clipboard
opt.clipboard:append({ "unnamed", "unnamedplus" })

-- Backup and swap
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- Performance
opt.updatetime = 250
opt.timeoutlen = 300

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }
opt.pumheight = 10

-- Mouse
opt.mouse = "a"

-- Miscellaneous
opt.hidden = true
opt.showmode = false
opt.conceallevel = 0
opt.fileformat = "unix"
