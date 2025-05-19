return {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require('Comment').setup({
            -- Optional configuration can go here
            toggler = {
                line = '<leader>/',    -- Toggle comment for current line
                block = '<leader>?'   -- Toggle comment for current block
            },
            opleader = {
                line = '<leader>/',    -- Comment motion linewise
                block = '<leader>?'   -- Comment motion blockwise
            },
            extra = {
                -- Optional: Add extra mappings
                above = '<leader>cO',
                below = '<leader>co',
                eol = '<leader>cA'
            }
        })
    end,
    keys = {
        -- { '<leader>/', mode = { 'n', 'x' }, desc = 'Toggle comment' },
        -- { '<leader>?', mode = { 'n', 'x' }, desc = 'Toggle block comment' }
    }
}

