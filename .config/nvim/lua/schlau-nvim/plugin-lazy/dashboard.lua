return {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        config = function()
                require('dashboard').setup {
                        thme = 'hyper',
                        config = {
                                header = {
                                        "",
                                        "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
                                        "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
                                        "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
                                        "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
                                        "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
                                        "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
                                        "                Der Beste Texteditor              ",
                                        "",

                                },
                                week_header = {
                                        enable = false,
                                        concat = ""

                                },
                                shortcut = {
                                        {
                                                desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u'
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
                                                desc = ' dotfiles',
                                                group = 'Number',
                                                action = 'Telescope dotfiles',
                                                key = 'd',
                                        },
                                },
                                packages = {
                                        enable = true
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
