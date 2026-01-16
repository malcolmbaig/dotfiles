-- Centralized keymaps configuration
-- ALL custom keybindings are defined here for easy management

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Helper function to merge opts with description
local function desc(description)
  return vim.tbl_extend("force", opts, { desc = description })
end

-- =============================================
-- General Editor Keymaps
-- =============================================

-- Better escape
keymap("i", "jk", "<ESC>", desc("Exit insert mode"))

-- Clear search highlighting
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", desc("Clear search highlight"))

-- Copy current file path to clipboard (or file + line range when visual)
keymap({ "n", "v" }, "<leader>yf", function()
  local path = vim.fn.expand("%:p")
  local mode = vim.fn.mode()
  if mode == "v" or mode == "V" or mode == "\22" then
    local start_line = vim.fn.line("v")
    local end_line = vim.fn.line(".")
    if start_line > end_line then
      start_line, end_line = end_line, start_line
    end
    vim.fn.setreg("+", string.format("%s#%d-%d", path, start_line, end_line))
  else
    vim.fn.setreg("+", path)
  end
end, desc("Yank current file path"))

-- =============================================
-- Window/Split Management
-- =============================================

-- Split creation
keymap("n", "<leader>-", "<cmd>split<CR>", desc("Horizontal split"))
keymap("n", "<leader>|", "<cmd>vsplit<CR>", desc("Vertical split"))

-- Split navigation
keymap("n", "<C-h>", "<C-w>h", desc("Go to left window"))
keymap("n", "<C-j>", "<C-w>j", desc("Go to lower window"))
keymap("n", "<C-k>", "<C-w>k", desc("Go to upper window"))
keymap("n", "<C-l>", "<C-w>l", desc("Go to right window"))

-- =============================================
-- Tab Management
-- =============================================

keymap("n", "<leader>tn", "<cmd>tabnew<CR>", desc("New tab"))
keymap("n", "<leader>tc", "<cmd>tabclose<CR>", desc("Close tab"))
keymap("n", "<leader>to", "<cmd>tabonly<CR>", desc("Close other tabs"))

-- =============================================
-- Buffer Management
-- =============================================

keymap("n", "<leader>bd", "<cmd>bdelete<CR>", desc("Delete buffer"))
keymap("n", "<leader>bn", "<cmd>bnext<CR>", desc("Next buffer"))
keymap("n", "<leader>bp", "<cmd>bprevious<CR>", desc("Previous buffer"))

-- =============================================
-- Text Manipulation
-- =============================================

-- Move lines up/down in visual mode
keymap("v", "J", ":m '>+1<CR>gv=gv", desc("Move line down"))
keymap("v", "K", ":m '<-2<CR>gv=gv", desc("Move line up"))

-- Better indenting
keymap("v", "<", "<gv", desc("Indent left"))
keymap("v", ">", ">gv", desc("Indent right"))

-- Keep cursor centered when scrolling
keymap("n", "<C-d>", "<C-d>zz", desc("Scroll down (centered)"))
keymap("n", "<C-u>", "<C-u>zz", desc("Scroll up (centered)"))

-- Keep search terms centered
keymap("n", "n", "nzzzv", desc("Next search result"))
keymap("n", "N", "Nzzzv", desc("Previous search result"))

-- =============================================
-- Plugin: hop.nvim
-- =============================================

keymap("n", "s", "<cmd>HopChar1<CR>", desc("Hop by 1 char"))

-- =============================================
-- Plugin: nvim-tree
-- =============================================

keymap("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", desc("Toggle file explorer"))
keymap("n", "<leader>E", "<cmd>NvimTreeFindFile<CR>", desc("Find current file in explorer"))

-- =============================================
-- Plugin: snacks.nvim (picker)
-- =============================================

keymap("n", "<leader><space>", function()
  require("snacks").picker.smart()
end, desc("Find files (smart)"))

keymap("n", "<leader>sb", function()
  require("snacks").picker.buffers()
end, desc("Switch buffers"))

keymap("n", "<leader>/", function()
  require("snacks").picker.grep()
end, desc("Grep search"))

keymap("n", "<leader>:", function()
  require("snacks").picker.command_history()
end, desc("Command history"))

keymap("n", "<leader>sh", function()
  require("snacks").picker.help()
end, desc("Help tags"))

keymap("n", "<leader>sf", function()
  require("snacks").picker.files()
end, desc("Find files"))

keymap("n", "<leader>sg", function()
  require("snacks").picker.git_files()
end, desc("Find git files"))

keymap("n", "<leader>sr", function()
  require("snacks").picker.recent()
end, desc("Recent files"))

-- =============================================
-- LSP
-- =============================================

-- Signature help (LSP) in insert mode
keymap("i", "<C-k>", function()
  vim.lsp.buf.signature_help()
end, desc("Signature help"))

-- =============================================
-- Git Operations
-- =============================================

-- Plugin: vim-fugitive
keymap("n", "<leader>gb", "<cmd>Git blame<CR>", desc("Git blame"))

-- Plugin: snacks.nvim (gitbrowse)
keymap("n", "<leader>go", function()
  require("snacks").gitbrowse()
end, desc("Open git link in browser"))

-- Plugin: snacks.nvim (lazygit)
keymap("n", "<leader>gg", function()
  require("snacks").lazygit()
end, desc("Open LazyGit"))
