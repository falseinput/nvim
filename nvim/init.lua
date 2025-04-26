vim.g.mapleader = ' '
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "number"
require("config.lazy")
require("lazy").setup("plugins")
require("mason").setup()
require("mason-lspconfig").setup {
	ensure_installed = { "lua_ls", "ts_ls", "denols" }
}
require("toggleterm").setup {
	direction = "float"
}
vim.lsp.enable("ts_ls")
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local opts = { buffer = bufnr }

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'K',  vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  end
})

vim.opt.autoindent = true
vim.opt.smartindent = true
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit" })

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
require("flatten").setup({
  window = {
    open = "alternate", -- Open in the current window
  },
  block_on_open = true, -- Ensures Lazygit waits until you're done editing
})
vim.cmd.colorscheme "catppuccin"
