local nvim_lsp = require('lspconfig')
local utils = require('utils')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local on_attach = function(client, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  utils.map_lua_buf('n', 'gD', 'vim.lsp.buf.declaration()', opts)
  utils.map_lua_buf('n', 'gd', 'vim.lsp.buf.definition()', opts)
  utils.map_lua_buf('n', 'ga', 'vim.lsp.buf.code_action()', opts)
  utils.map_lua_buf('n', 'gh', 'vim.lsp.buf.hover()', opts)
  utils.map_lua_buf('n', 'gi', 'vim.lsp.buf.implementation()', opts)
  utils.map_lua_buf('n', '<C-k>', 'vim.lsp.buf.signature_help()', opts)
  utils.map_lua_buf('n', '<space>wa', 'vim.lsp.buf.add_workspace_folder()', opts)
  utils.map_lua_buf('n', '<space>wr', 'vim.lsp.buf.remove_workspace_folder()', opts)
  utils.map_lua_buf('n', '<space>wl', 'print(vim.inspect(vim.lsp.buf.list_workspace_folders()))', opts)
  utils.map_lua_buf('n', '<space>D', 'vim.lsp.buf.type_definition()', opts)
  utils.map_lua_buf('n', '<space>rn', 'vim.lsp.buf.rename()', opts)
  utils.map_lua_buf('n', 'gr', 'vim.lsp.buf.references()', opts)
  utils.map_lua_buf('n', '<space>e', 'vim.lsp.diagnostic.show_line_diagnostics()', opts)
  utils.map_lua_buf('n', '[d', 'vim.lsp.diagnostic.goto_prev()', opts)
  utils.map_lua_buf('n', ']d', 'vim.lsp.diagnostic.goto_next()', opts)
  utils.map_lua_buf('n', '<space>q', 'vim.lsp.diagnostic.set_loclist()', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'gopls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

--vim.lsp.set_log_level("debug")
