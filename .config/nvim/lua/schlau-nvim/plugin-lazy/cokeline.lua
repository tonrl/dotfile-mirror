return {
        "willothy/nvim-cokeline",
        dependencies = {
                "nvim-lua/plenary.nvim",       -- Required for v0.4.0+
                "nvim-tree/nvim-web-devicons", -- Devicon support
                "stevearc/resession.nvim"      -- Optional, for persistent history
        },
        config = function ()
                local get_hex = require('cokeline.hlgroups').get_hl_attr
                local fg = "#E1E1E1"
                local bg = "#54487A"
                local inactive_fg = "#DDDFFF"
                local inactive_bg = "#111111"
                local yellow = "#ffc777"
                local green = "#3DEB63"
                local red = "#ff007c"
                local close = "#c0caf5"

                require('cokeline').setup({
                        default_hl = {
                                fg = function(buffer) return buffer.is_focused and fg or inactive_fg end,
                                bg = function(buffer) return buffer.is_focused and bg or inactive_bg end,
                        },
                        components = {
                                {
                                        text = function(buffer)
                                                local _text = ''
                                                if buffer.index > 1 then _text = '' end
                                                if buffer.is_focused or buffer.is_first then
                                                        _text = _text .. ''
                                                end
                                                return _text
                                        end,
                                        fg = function(buffer)
                                                if buffer.is_focused then
                                                        return bg
                                                elseif buffer.is_first then
                                                        return inactive_bg
                                                end
                                        end,
                                        bg = function(buffer)
                                                if buffer.is_focused then
                                                        if buffer.is_first then
                                                                return "#1f2335"
                                                        else
                                                                return inactive_bg
                                                        end
                                                elseif buffer.is_first then
                                                        return "#1f2335"
                                                end
                                        end
                                },

                                {
                                        text = '  ',
                                        fg = function(buffer)
                                                return
                                                buffer.is_modified and yellow or green
                                        end
                                },
                                {
                                        text = function(buffer)
                                                local status = ''
                                                if buffer.is_readonly then
                                                        status = ' '
                                                end
                                                return status
                                        end,
                                        fg = red
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
                                        text = function(buffer)
                                                local errors = buffer.diagnostics.errors
                                                if(errors <= 3) then
                                                        errors = ' '
                                                else
                                                        errors = "🙃"
                                                end
                                                return errors .. ' '
                                        end,
                                        fg = function(buffer)
                                                if buffer.diagnostics.errors == 0 then
                                                        return '#3DEB63'
                                                elseif buffer.diagnostics.errors <= 3 then
                                                        return '#DB121B'
                                                end
                                        end
                                },
                                {
                                        text = '',
                                        fg = close,
                                        delete_buffer_on_left_click = true
                                },
                                {
                                        text = ' '
                                },
                                {
                                        text = function(buffer)
                                                if buffer.is_focused or buffer.is_last then
                                                        return ''
                                                else
                                                        return ''
                                                end
                                        end,
                                        fg = function(buffer)
                                                if buffer.is_focused then
                                                        return bg
                                                elseif buffer.is_last then
                                                        return inactive_bg
                                                else
                                                        return bg
                                                end
                                        end,
                                        bg = function(buffer)
                                                if buffer.is_focused then
                                                        if buffer.is_last then
                                                                return "#1f2335"
                                                        else
                                                                return inactive_bg
                                                        end
                                                elseif buffer.is_last then
                                                        return "#1f2335"
                                                end
                                        end
                                }
                        },
                })
        end


}

