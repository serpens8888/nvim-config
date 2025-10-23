return{
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "j-hui/fidget.nvim",
            "scalameta/nvim-metals",
        },


        config = function()

            require("fidget").setup({})

            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "clangd", "zls", "ols", "jdtls",},
                handlers = {
                    function(server_name)
                        local capabilities = vim.tbl_deep_extend(
                            'force',
                            {},
                            vim.lsp.protocol.make_client_capabilities(),
                            require('cmp_nvim_lsp').default_capabilities()
                        )
                        require("lspconfig")[server_name].setup{
                            capabilities = capabilities
                        }
                    end,

                    ["lua_ls"] = function()
                        require("lspconfig").lua_ls.setup{
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = { "vim" }
                                    }
                                }
                            }
                        }
                    end,

                }
            })

            -- slang is not supported by mason lspconfig
            -- we must use :MasonInstall slang
            local lsp_configurations = require('lspconfig.configs')

            vim.filetype.add({
                extension = {
                    slang = 'slang',
                },
            })


            -- slang lsp
            if not lsp_configurations.slangd then
                lsp_configurations.slangd = {
                    default_config = {
                        cmd = {'slangd'},
                        filetypes = {'slang'},
                        root_dir = require('lspconfig.util').root_pattern('.git')
                    }
                }
            end

            require('lspconfig').slangd.setup{}


            -- scala lsp
            local metals = require("metals")
            local metals_config = metals.bare_config()
            metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
            metals_config.init_options.statusBarProvider = "on"
            metals_config.setting = {
                showImplicitArguments = true,
                superMethodLensesEnabled = true,
            }

            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "scala", "sbt" },
                callback = function()
                    metals.initialize_or_attach(metals_config)
                end,
            })


            -- cmp
            local cmp = require("cmp")
            local cmp_select = {behavior = cmp.SelectBehavior.Select}

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end
                },

                window = {
                    completion = cmp.config.window.bordered({
                        border = "double",
                    }),
                    documentation = cmp.config.disable,
                },


                experimental = {
                    ghost_text = true,  -- This enables the ghost text feature
                },

                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-Space>'] = cmp.mapping.complete(),
                }),

                sources = cmp.config.sources(
                    {
                        { name = 'nvim_lsp' },
                        { name = 'nvim_lsp_signature_help' },
                        { name = 'luasnip'  }, -- For luasnip users.
                    },
                    {
                        { name = 'buffer'   },
                    }
                ),

            })

            vim.diagnostic.config({
                virtual_text = true,
                update_in_insert = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            })



        end
    },

}

