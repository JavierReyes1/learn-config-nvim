--require "after" folder, this is where all my configurations will be stored
--
--
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 2
vim.o.signcolumn = "yes"
vim.o.winborder = "rounded"
vim.o.cursorcolumn = false
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.swapfile = false
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.g.mapleader = " "
local map = vim.keymap.set --I created a variable called map, i was tired of typing vim.keymap.set for each new keymap
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>o', ':update <CR> :source<CR>')
--compile java file
map('n', '<leader>ca', ':!javac % <CR>')

vim.cmd("iabbr sysout System.out.println();<Esc>hi")
vim.cmd("iabbr psvm main public static void main(String[]args)")
--Packer manager
vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/m4xshen/autoclose.nvim" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvimtools/none-ls.nvim" },
	{ src = "https://github.com/Jezda1337/nvim-html-css" },
	{ src = "https://github.com/windwp/nvim-ts-autotag" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvimtools/none-ls-extras.nvim" },
	 -- Snippet engine
  { src = "https://github.com/L3MON4D3/LuaSnip" },
	  -- Prebuilt snippets (VS Code / Sublime–style)
  { src ="https://github.com/rafamadriz/friendly-snippets" },

	  -- Completion (needed for Tab integration)
  { src = "https://github.com/hrsh7th/nvim-cmp" },
  { src = "https://github.com/saadparwaiz1/cmp_luasnip" },
  { src = "https://github.com/brianhuster/live-preview.nvim" },

})

--AutoCompletion
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})
vim.cmd("set completeopt+=noselect")

--mini.pick, oil, mason setups
require "mason".setup()
require "mini.pick".setup()
require "oil".setup()
require "autoclose".setup()
require "plenary.async"
require "nvim-ts-autotag".setup()
require('livepreview.config').set()

--Lua Snippets

local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()

luasnip.config.set_config({
	history = true,
 	updateevents = "TextChanged, TextChangedI",
})

--cmp


--None-ls configuration
local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.completion.spell,
		require("none-ls.diagnostics.eslint"), --Requires none-ls extras
	},
})

vim.lsp.enable({ "lua_ls", "jdtls", "php", "html", "typescript", "javascript"})
--treesitter
require "nvim-treesitter.configs".setup({
	ensure_installed = { "svelte", "typescript", "javascript", "java", "php", "html" },
	highlight = { enable = true }
})

vim.keymap.set('n', '<leader>f', ':Pick files<CR>')
vim.keymap.set('n', '<leader>h', ':Pick help<CR>')
vim.keymap.set('n', '<leader>e', ':Oil<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>S', ':sf #<CR>')
map('n', '<leader>q', ':wq <CR>')

vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")
