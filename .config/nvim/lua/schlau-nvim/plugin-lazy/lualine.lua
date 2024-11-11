return {
        "nvim-lualine/lualine.nvim",
        dependencies = {
                'nvim-tree/nvim-web-devicons'
        },

        config = function ()
                require("lualine").setup {
                        options = {
                                icon_enabled = true,
                                theme = 'horizon',
                                component_separators = { left = '', right = ''},
                                section_separators = { left = '', right = ''},
                                disabled_filetypes = {
                                        statusline = {},
                                        winbar = {},
                                },
                                ignore_focus = {},
                                always_divide_middle = true,
                                always_show_tabline = true,
                                globalstatus = true,
                                refresh = {
                                        statusline = 50,
                                        tabline = 50,
                                        winbar = 50,
                                }
                        },
                        sections = {
                                lualine_a = {'mode'},
                                lualine_b = {'branch', 'diff', 'diagnostics'},
                                lualine_c = {'filename','filesize'},
                                lualine_x = {'encoding', 'fileformat', 'filetype'},
                                lualine_y = {'progress'},
                                lualine_z = {'location'}
                        },
                        inactive_sections = {
                                lualine_a = {},
                                lualine_b = {},
                                lualine_c = {'filename'},
                                lualine_x = {'location'},
                                lualine_y = {},
                                lualine_z = {}
                        },
                        tabline = {},
                        winbar = {},
                        inactive_winbar = {},
                        extensions = {}
                }
        end

}
