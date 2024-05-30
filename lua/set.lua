-- Set columns with relative numbers, and current line shows line number.
-- Sign comlumn is fixed to avoid flickering when appearing/disappearing.
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

-- Tab/indentation settings
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Faster updatetime
vim.opt.updatetime = 50

-- Color line 80 as visual mark to avoid long lines.
vim.opt.colorcolumn = "80"

-- Keep 2 lines up and down when scrolling
vim.opt.scrolloff = 2
