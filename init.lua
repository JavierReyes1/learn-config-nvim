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
local map = vim.keymap.set 		--I created a variable called map, i was tired of typing vim.keymap.set for each new keymap
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>o', ':update <CR> :source<CR>')
vim.cmd('iabbr sysout System.out.println(\"\");<Esc>2hi')
map('n', '<leader>ca', ':!javac % <CR>')

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

vim.lsp.enable('java', {cmd = {true}})

--treesitter
require "nvim-treesitter.configs".setup({
  ensure_installed = {"svelte", "typescript", "javascript", "java"},
  highlight = {enable = true}
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
