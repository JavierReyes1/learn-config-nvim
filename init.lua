--
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.signcolumn = "yes"
vim.o.winborder = "rounded"
vim.o.swapfile = false
vim.g.mapleader = " "
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>o', ':update <CR> :source<CR>')


--Packer manager
vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
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

--mini.pick & oil setups
require "mini.pick".setup()
require "oil".setup()

vim.keymap.set('n', '<leader>f', ':Pick files<CR>')
vim.keymap.set('n', '<leader>h', ':Pick help<CR>')
vim.keymap.set('n', '<leader>e', ':Oil<CR>')
vim.keymap.set({'n', 'v', 'x'}, '<leader>y', '"+y<CR')
vim.keymap.set({'n', 'v', 'x'}, '<leader>d', '"+d<CR')

--Enable Lsp
vim.lsp.enable({ "lua_ls", "svelte-language-server", "tinymist" })
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")
