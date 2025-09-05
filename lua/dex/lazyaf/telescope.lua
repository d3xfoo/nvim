return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({
            pickers = {
                find_files = {
                    hidden = false
                }
            }
        })

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>fo', builtin.find_files, {})
        vim.keymap.set('n', '<leader>cm', builtin.git_commits, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set("n", "<leader>fs", builtin.live_grep, { silent = true })
        -- vim.keymap.set('n', '<leader>fs', function()
        --     builtin.grep_string({ search = vim.fn.input("Grep > ") })
        -- end)
        vim.keymap.set('n', '<leader>fws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>fWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
    end
}
