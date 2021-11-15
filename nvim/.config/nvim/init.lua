local o = vim.o
local w = vim.wo
local b = vim.bo

utils = require('utils')

vim.g.mapleader = ' '

-- sane indentation
o.autoindent = true
o.expandtab = true
o.softtabstop = 4
o.shiftwidth = 4
o.tabstop = 4
o.smartindent = true

o.exrc = true
o.guicursor = ''

o.backspace = [[indent,eol,start]]
o.hidden = true
o.hlsearch = false

o.splitbelow = true
o.splitright = true

w.cursorline = true

w.number = true
w.relativenumber = true

o.swapfile = false
o.backup = false
o.undodir = vim.fn.getenv("HOME").. '/.vim/undodir'
o.undofile = true

o.incsearch = true

if vim.fn.has('multi_byte') == 1 and vim.o.encoding == 'utf-8' then
  o.listchars = [[tab:▸ ,extends:❯,precedes:❮,nbsp:±,trail:…]]
else
  o.listchars = [[tab:> ,extends:>,precedes:<,nbsp:.,trail:_]]
end

w.colorcolumn = [[100]]
w.wrap = false
w.signcolumn = 'yes'

o.termguicolors = true

o.clipboard = [[unnamed,unnamedplus]]

o.scrolloff = 8

o.mouse = 'a'

o.showmode = false
o.completeopt = [[menuone,noinsert,noselect]]

packer = require('packer').startup(function()
        require('plugins')

        if packer_bootstrap then
            require('packer').sync()
        end
end)

local opts = { noremap=true, silent=true }
utils.map('n', 'J', ":m .+1<CR>==", opts)
utils.map('n', 'K', ":m .-2<CR>==", opts)
utils.map('v', 'J', ":m '>+1<CR>gv=gv", opts)
utils.map('v', 'K', ":m '<-2<CR>gv=gv", opts)

require('doom-one-config')
require('treesitter')
require('my-telescope-config')
require('lsp_config')

local autocmds = {
    trimwhite = {
        { 'BufWritePre', '*', 'lua require("utils").preserve("%s/\\\\s\\\\+$//ge")' }
    };
}

utils.nvim_create_augroups(autocmds)
