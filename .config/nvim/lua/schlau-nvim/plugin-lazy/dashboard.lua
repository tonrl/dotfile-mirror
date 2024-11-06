return {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        config = function()
                require('dashboard').setup {
                        thme = 'hyper',
                        config = {
                                header = {
                                        "",
                                        "    ██████   █████                                ███                 ",
                                        "   ░░██████ ░░███                                ░░░                  ",
                                        "    ░███░███ ░███   ██████   ██████  █████ █████ ████  █████████████  ",
                                        "    ░███░░███░███  ███░░███ ███░░███░░███ ░░███ ░░███ ░░███░░███░░███ ",
                                        "    ░███ ░░██████ ░███████ ░███ ░███ ░███  ░███  ░███  ░███ ░███ ░███ ",
                                        "    ░███  ░░█████ ░███░░░  ░███ ░███ ░░███ ███   ░███  ░███ ░███ ░███ ",
                                        "    █████  ░░█████░░██████ ░░██████   ░░█████    █████ █████░███ █████",
                                        "   ░░░░░    ░░░░░  ░░░░░░   ░░░░░░     ░░░░░    ░░░░░ ░░░░░ ░░░ ░░░░░ ",
                                        "",
                                        "                     [The Texteditor dose not suck]                   ",
                                        "",
                                },
                                week_header = {
                                        enable = false,
                                        concat = ""

                                },
                                shortcut = {
                                        {
                                                icon = '󰊳 ',
                                                icon_hl = '@variable',
                                                desc = 'Update',
                                                group = '@property',
                                                action = 'Lazy update',
                                                key = 'u'
                                        },
                                        {
                                                icon = ' ',
                                                icon_hl = '@variable',
                                                desc = 'Files',
                                                group = 'Label',
                                                action = 'Telescope find_files',
                                                key = 'f',
                                        },
                                        {
                                                icon = '󰩉 ',
                                                icon_hl = '@variable',
                                                desc = 'Text',
                                                group = 'DiagnosticHint',
                                                action = 'Telescope live_grep',
                                                key = 'g',
                                        },
                                },
                                packages = {
                                        enable = false
                                },
                                footer = {
                                        "",
                                        " Emacs is an OS with bad editor, Vi is a masterpiece of elegance",
                                },
                        }
                }
        end,
        dependencies = { {'nvim-tree/nvim-web-devicons'}}
}
