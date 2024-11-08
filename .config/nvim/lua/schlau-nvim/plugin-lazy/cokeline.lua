return{
        "willothy/nvim-cokeline",
        dependencies = {
                "nvim-lua/plenary.nvim",        -- Required for v0.4.0+
                "nvim-tree/nvim-web-devicons", -- If you want devicons
                "stevearc/resession.nvim"       -- Optional, for persistent history
        },
        config = function ()
                local get_hex = require('cokeline.hlgroups').get_hl_attr
                local fg = "#8864ce"
                local bg = "#383838"
                local inactive_fg = "#808080"
                local inactive_bg = "#211f1f"
                local yellow = "#c6ce14"
                local green = "#14ce5c"

                require('cokeline').setup({
                        default_hl = {
                                fg = function(buffer) return buffer.is_focused and fg or inactive_fg end,
                                bg = function(buffer) return buffer.is_focused and bg or inactive_bg end,
                        },
                        components = {
                                {
                                        text = ' Δ ',
                                        fg = function(buffer)
                                                return
                                                buffer.is_modified and yellow or green
                                        end
                                },
                                {
                                        text = function(buffer) return ' ' .. buffer.devicon.icon end,
                                        fg = function(buffer) return buffer.devicon.color end,
                                },
                                {
                                        text = function(buffer) return buffer.index .. ': ' end,
                                },
                                {
                                        text = function(buffer) return buffer.unique_prefix end,
                                        fg = get_hex('Comment', 'fg'),
                                        italic = true,
                                },
                                {
                                        text = function(buffer) return buffer.filename .. '  ' end,
                                        bold = function(buffer) return buffer.is_focused end
                                },
                                {
                                        text = '󰖭',
                                        fg = inactive_fg,
                                        on_click = function(_, _, _, _, buffer)
                                                buffer:delete()
                                        end
                                },
                                {
                                        text = '  ',
                                },

                        },
                })
        end


}

