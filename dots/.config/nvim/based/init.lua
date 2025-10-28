vim.o.number = true
vim.o.relativenumber = false
vim.o.wrap = true
vim.o.tabstop = 4
vim.o.signcolumn = "yes"
vim.o.swapfile = false
vim.g.mapleader = ","
vim.o.winborder = "rounded"

vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set('n', '<leader>e', ':Oil<CR>')

vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')

vim.pack.add({
		{src = "https://github.com/vague2k/vague.nvim"},
		{src = "https://github.com/stevearc/oil.nvim"},
		{src = "https://github.com/nvim-mini/mini.pick"},
		{src = "https://github.com/neovim/nvim-lspconfig"},
})

require "mini.pick".setup()
require "oil".setup()

vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")

vim.lsp.enable({"lua_ls", "tinymist"})

vim.keymap.set('n', '<leader>f', ':Pick files<CR>')

vim.api.nvim_create_autocmd('LspAttach', {
		callback = function(ev)
				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				if client:supports_method('textDocument/completion') then
						vim.lsp.completion.enabled(true, client.id, ev.buf, {autotrigger = true})
				end
		end,
})
vim.cmd("set completeopt+=noselect")
