
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"

vim.opt.clipboard = "unnamedplus"

vim.o.hlsearch = false
vim.o.incsearch = true

vim.o.scrolloff = 10
vim.opt.clipboard = "unnamedplus"
vim.updatetime = 50

vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4

vim.o.termguicolors = true

vim.api.nvim_set_hl(0, 'StatusLine', { bg = '#090909', blend = 1 })

--theme toggle


local function set_transparent_theme()
    local transparent_groups = {
        'Normal',
        'NormalNC',
        'NormalFloat',
        'FloatBorder',
        'TelescopeNormal',
        'TelescopeBorder',
        'TelescopePromptNormal',
        'TelescopeResultsNormal',
        'TelescopePreviewNormal',
        'WhichKeyFloat',
        'BufferLineBackground',
        'BufferLineFill',
        'LineNr',
        'SignColumn',
        'StatusLine',
        'TabLine',
    }

    for _, group in ipairs(transparent_groups) do
        vim.api.nvim_set_hl(0, group, { bg = 'NONE' })
    end

    -- change text color for selected lines
    vim.api.nvim_set_hl(0, 'TelescopeSelection', { fg = '#00ff00', bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'CursorLine', { bg = 'NONE' })

    -- set text color for the cmp selection
    vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { fg = '#00FF00', bg = 'NONE' })

    -- color fidget notifications
    vim.api.nvim_set_hl(0, "FidgetTitle", { fg = "#00ff00", bg = "NONE" })
    vim.api.nvim_set_hl(0, "FidgetTask",  { fg = "#aaaaaa", bg = "NONE" })
end


local function set_default_theme()
    vim.cmd("highlight clear")
    set_colorscheme()
end

local transparent = false

local function toggle_theme()
    if transparent then
        set_default_theme()
    else
        set_transparent_theme()
    end
    transparent = not transparent
end

vim.keymap.set("n", "<leader>tt", toggle_theme, { desc = "Toggle theme transparency" })



