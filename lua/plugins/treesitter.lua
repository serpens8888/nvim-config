return{
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "c", "zig", "odin", "slang" },
                sync_install = true,
                auto_install = true,
                indent = {
                    enable = true,
                },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = { "markdown" },
                },

            })

            local treesitter_parser_configs = require("nvim-treesitter.parsers").get_parser_configs({})
            treesitter_parser_configs.templ = {
                install_info = {
                    url = "https://github.com/vrischmann/tree-sitter-templ.git",
                    files = {"src/parser.c", "src/scanner.c"},
                    branch = "master",
                },
            }
            vim.treesitter.language.register("templ", "templ")

        end
    },
}


