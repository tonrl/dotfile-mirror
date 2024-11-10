function MyColor(color)
        color = color or "rose-pine"
        vim.cmd.colorscheme(color)

        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
        {
                "rose-pine/neovim",
                name = "rose-pine",
                config = function()
                        require('rose-pine').setup({
                                variant = "moon",
                                dark_variant = "moon",
                                disable_background = true,
                                enable = {
                                        terminal = true,
                                        legacy_highlights = true,
                                        migrations = true,
                                },
                                styles = {
                                        bold = true,
                                        italic = false,
                                        transparency = true,
                                },
                        })
                end
        },
}
