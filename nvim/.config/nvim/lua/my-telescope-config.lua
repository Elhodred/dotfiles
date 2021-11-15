local utils = require('utils')

local opts = { noremap=true, silent=true }
utils.map_lua('n', '<Leader>pf', "require('telescope.builtin').find_files()", opts)
utils.map_lua('n', '<Leader>ps', "require('telescope.builtin').grep_string({ search = vim.fn.input('Grep For > ')})", opts)
utils.map_lua('n', '<Leader>pb', "require('telescope.builtin').buffers()", opts)
