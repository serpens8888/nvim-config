return{
    {
        "maxmx03/fluoromachine.nvim",
        name = "fluoromachine",
        config = function()
            require('fluoromachine').setup{
                transparent = true,
            }
            vim.cmd("colorscheme fluoromachine")
        end
    },
}
