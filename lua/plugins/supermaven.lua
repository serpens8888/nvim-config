return {

    "supermaven-inc/supermaven-nvim",
    config = function()
        require("supermaven-nvim").setup({
            disable_inline_completion = false, -- disables inline completion for use with cmp
            keymaps = {
                accept_suggestion = "<S-Tab>",
            },
        })
    end,
}
