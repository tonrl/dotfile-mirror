return {
        "neovim/nvim-lspconfig",
        dependencies = {
                "williamboman/mason.nvim",
                "williamboman/mason-lspconfig.nvim",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-cmdline",
                "hrsh7th/nvim-cmp",
                "L3MON4D3/LuaSnip",
                "saadparwaiz1/cmp_luasnip",
                "j-hui/fidget.nvim",
                "jcha0713/cmp-tw2css", -- CSS support
                "jc-doyle/cmp-pandoc-references", --Markdown support
        },
        config = function()
                local cmp = require('cmp')
                local cmp_lsp = require("cmp_nvim_lsp")
                local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                cmp_lsp.default_capabilities())
                require("fidget").setup({})
                require("mason").setup({
                        ui = {
                                icons = {
                                        package_installed = "",
                                        package_pending = "",
                                        package_uninstalled = "",
                                },
                        }
                })
                require("mason-lspconfig").setup({
                        ensure_installed = {
                                "lua_ls",
                                "rust_analyzer",
                                "clangd",
                        },
                        handlers = {
                                function(server_name) -- Default handler (optional)
                                        if server_name ~= 'rust_analyzer' then
                                                require("lspconfig")[server_name].setup {
                                                        vim.keymap.set('n', 'K', vim.lsp.buf.hover, {}),
                                                        vim.keymap.set('n', 'dg', vim.lsp.buf.definition, {}),
                                                        vim.keymap.set({'n'},'<leader>ca', vim.lsp.buf.code_action, {}),
                                                        capabilities = capabilities
                                                }
                                        end
                                end,
                                ["lua_ls"] = function()
                                        local lspconfig = require("lspconfig")
                                        lspconfig.lua_ls.setup {
                                                capabilities = capabilities,
                                                settings = {
                                                        Lua = {
                                                                runtime = { version = "Lua 5.4" },
                                                                diagnostics = {
                                                                        globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                                                }
                                                        }
                                                }
                                        }
                                end,
                                ["clangd"] = function()
                                        local lspconfig = require("lspconfig")
                                        lspconfig.clangd.setup {
                                                capabilities = capabilities,
                                                settings = {
                                                        ['clangd'] = {},
                                                },
                                        }
                                end,
                        }
                })
                local cmp_select = { behavior = cmp.SelectBehavior.Select }

                cmp.setup({
                        snippet = {
                                expand = function(args)
                                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                                end,
                        },
                        window = {
                                completion = cmp.config.window.bordered(),
                                documentation = cmp.config.window.bordered(),
                        },
                        mapping = cmp.mapping.preset.insert({
                                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                                ["<C-Space>"] = cmp.mapping.complete(),
                                ['<C-a>'] = cmp.mapping.abort(),
                        }),
                        sources = cmp.config.sources({
                                { name = 'nvim_lsp' },
                                { name = 'luasnip' }, -- For Luasnip users.
                                { name = 'cmp-tw2css' },
                                { name = 'pandoc_references'},
                        },
                        {
                                { name = 'buffer' },
                        })
                })
                vim.diagnostic.config({
                        --update_in_insert = true,
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
}
