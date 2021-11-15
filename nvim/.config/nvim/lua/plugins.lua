local utils = require('utils')

vim.cmd [[packadd packer.nvim]]
local autocmds = {
	packer = {
		{ "BufWritePost", "plugins.lua", "source <afile> | PackerCompile" }
	};
}

utils.nvim_create_augroups(autocmds)

return require('packer').startup(function()
	-- lsp
	use 'neovim/nvim-lspconfig'

	-- telescope
	use {
		'nvim-telescope/telescope.nvim',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	-- treesitter
	use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

    -- doom-one theme
	use 'NTBBloodbath/doom-one.nvim'

    -- completion
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-buffer' }
    use { 'hrsh7th/cmp-path' }
    use { 'hrsh7th/cmp-cmdline' }
    use { 'hrsh7th/nvim-cmp' }

    -- For luasnip users.
    use { 'L3MON4D3/LuaSnip' }
    use { 'saadparwaiz1/cmp_luasnip' }
end)
