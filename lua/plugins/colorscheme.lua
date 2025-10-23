return{
    {
        "maxmx03/fluoromachine.nvim",
        name = "fluoromachine",
        config = function()
            require('fluoromachine').setup{
                transparent = false,
            }

            _G.set_colorscheme = function()
                vim.cmd("colorscheme fluoromachine")
                vim.api.nvim_set_hl(0, "TabLine", { fg = "#57367c", bg = "#18072b" })
                vim.api.nvim_set_hl(0, "StatusLine", { fg = "#57367c", bg = "#18072b" })
            end

            set_colorscheme()


        end
    },
}
