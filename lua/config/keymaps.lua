local Util = require "util"

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- better up/down
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<c-h>", "<c-w>h", { desc = "Go to left window" })
map("n", "<c-j>", "<c-w>j", { desc = "Go to lower window" })
map("n", "<c-k>", "<c-w>k", { desc = "Go to upper window" })
map("n", "<c-l>", "<c-w>l", { desc = "Go to right window" }) -- Resize with arrows

-- Move Lines
map("n", "<a-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<a-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<a-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<a-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<a-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<a-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- buffers
map("n", "<s-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<s-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })

map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })
map("n", "<c-s>", ":w<cr>", { desc = "Save buffer" })
map("n", "bd", ":bd<cr>", { desc = "Delete buffer" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- find file
map("n", "<leader><leader>", "<cmd>Telescope find_files<cr>", { desc = "Find File" })

-- lazy
map("n", "<leader>L", "<cmd>:Lazy<cr>", { desc = "Lazy" })

if not Util.has "trouble.nvim" then
  map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
  map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })
end

-- toggle options
map("n", "<leader>uf", require("plugins.lsp.format").toggle, { desc = "Toggle format on Save" })
map("n", "<leader>us", function()
  Util.toggle "spell"
end, { desc = "Toggle Spelling" })
map("n", "<leader>uw", function()
  Util.toggle "wrap"
end, { desc = "Toggle Word Wrap" })
map("n", "<leader>ul", function()
  Util.toggle("relativenumber", true)
  Util.toggle "number"
end, { desc = "Toggle Line Numbers" })
if vim.lsp.inlay_hint then
  map("n", "<leader>uh", function()
    vim.lsp.inlay_hint(0, nil)
  end, { desc = "Toggle Inlay Hints" })
end

-- windows
map("n", "<leader>ww", "<c-w>p", { desc = "Other window" })
map("n", "<leader>wd", "<c-w>c", { desc = "Delete window" })
map("n", "<leader>w-", "<c-w>s", { desc = "Split window below" })
map("n", "<leader>w|", "<c-w>v", { desc = "Split window right" })
map("n", "<leader>-", "<c-w>s", { desc = "Split window below" })
map("n", "<leader>|", "<c-w>v", { desc = "Split window right" })

-- window resize
map("n", "<a-up>", "<cmd>resize -2<cr>", { desc = "Decrease the window height" })
map("n", "<a-down>", "<cmd>resize +2<cr>", { desc = "Increase the window height" })
map("n", "<a-left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease the window width" })
map("n", "<a-right>", "<cmd>vertical resize +2<cr>", { desc = "Increase the window width" })

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
