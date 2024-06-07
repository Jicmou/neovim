-- leader key is space bar.
vim.g.mapleader = " "

-- Remove all windows except the current one.
vim.keymap.set("n", "<leader>o", vim.cmd.only)

-- Toggles search highlighting.
vim.keymap.set("n", "<leader>t", function()
	vim.cmd.set("hlsearch!")
end)

-- Remap window related moves.
vim.keymap.set("n", "<leader>hh", "<C-w>h")
vim.keymap.set("n", "<leader>l", "<C-w>l")
vim.keymap.set("n", "<leader>j", "<C-w>j")
vim.keymap.set("n", "<leader>k", "<C-w>k")
vim.keymap.set("n", "<leader>H", "<C-w>H")
vim.keymap.set("n", "<leader>L", "<C-w>L")
vim.keymap.set("n", "<leader>J", "<C-w>J")
vim.keymap.set("n", "<leader>K", "<C-w>K")

-- Key bindings I was used to with netrw to open file explorer
vim.keymap.set("n", "<leader>e", vim.cmd.Explore)
vim.keymap.set("n", "<leader>ve", vim.cmd.Vexplore)
vim.keymap.set("n", "<leader>se", vim.cmd.Sexplore)

-- Allow moving selected parts ud and down with J and K.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")

-- Keep cursor at place when doing "J".
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor in the middle when scrolling half-pages.
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- <leader>y to copy into the system clipboard.
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')

-- <leader>p to paste without losing the unnamed register
vim.keymap.set("x", "<leader>p", '"_dP')

-- <leader>d to delete into the black-hole register
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

-- Navigate easily in the quickfix list
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprevious<CR>zz")

-- Format code with formatter
vim.keymap.set("n", "<leader>f", vim.cmd.Format, {})
vim.keymap.set("n", "<leader>F", vim.cmd.FormatWrite, {})

-- Fix all fixable eslint errors in file
vim.keymap.set("n", "<leader>es", vim.cmd.EslintFixAll, {})
