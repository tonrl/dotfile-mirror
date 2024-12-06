return {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy", -- Or `LspAttach`
        priority = 1000, -- needs to be loaded in first
        config = function()
                require('tiny-inline-diagnostic').setup({
                        preset = "powerline",
                        options = {
                                multilines = false,
                                enable_on_insert = true,
                                use_icons_from_diagnostic = false,


                        },
                })
        end
}
