return {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function ()
                local harpoon = require("harpoon")
                -- REQUIRED
                harpoon:setup()
                -- REQUIRED

                -- Telescope Config
                local conf = require("telescope.config").values
                local function toggle_telescope(harpoon_files)
                        local file_paths = {}
                        for _, item in ipairs(harpoon_files.items) do
                                table.insert(file_paths, item.value)
                        end

                        local make_finder = function()
                                local paths = {}
                                for _, item in ipairs(harpoon_files.items) do
                                        table.insert(paths, item.value)
                                end
                                return require("telescope.finders").new_table(
                                {
                                        results = paths
                                }
                                )
                        end


                        require("telescope.pickers").new({}, {
                                prompt_title = "Harpoon",
                                finder = require("telescope.finders").new_table({
                                        results = file_paths,
                                }),
                                previewer = conf.file_previewer({}),
                                sorter = conf.generic_sorter({}),
                                layout_config = {
                                        height = 0.3,
                                        width = 0.6,
                                        prompt_position = "top",
                                        preview_cutoff = 120,
                                },

                                attach_mappings = function(prompt_buffer_number, map)
                                        -- Delete selected entry from the list
                                        map(
                                        "i",
                                        "<C-d>",
                                        function()
                                                local state = require("telescope.actions.state")
                                                local selected_entry = state.get_selected_entry()
                                                local current_picker = state.get_current_picker(prompt_buffer_number)

                                                harpoon:list():remove_at(selected_entry.index)
                                                current_picker:refresh(make_finder())
                                        end
                                        )

                                        return true
                                end
                        }):find()
                end

                -- Use Telescope to show the list
                vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
                { desc = "Open harpoon window" })

                -- Keymap for Harpoon
                vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
                -- vim.keymap.set("n", "<leader>d", function() harpoon:list():remove() end)
                vim.keymap.set("n", "<C-n>", function() harpoon:list():select(1) end)
                vim.keymap.set("n", "<C-s>", function() harpoon:list():select(2) end)
                vim.keymap.set("n", "<C-h>", function() harpoon:list():select(3) end)
                vim.keymap.set("n", "<C-t>", function() harpoon:list():select(4) end)

                -- Toggle previous & next buffers stored within Harpoon list
                vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
                vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
        end
}
