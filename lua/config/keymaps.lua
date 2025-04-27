

vim.g.mapleader = " "

-- move a selection up and down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '>-2<CR>gv=gv")

-- keep cursor in the same position when moving up and down with CTRL U/D
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('n', '<leader>R', ':!odin run . -debug<CR>')

local autocmd = vim.api.nvim_create_autocmd

autocmd('LspAttach', {
    group = serpens_group,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    end
})

autocmd('BufWritePre', {
    group = serpens_group,
    pattern = '*',
    callback = function(args)
        require('conform').format({ bufnr = args.buf })
    end
})
