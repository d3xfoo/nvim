return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }, -- Required dependency
        lazy = false, -- Load immediately
        config = function()
            local harpoon = require("harpoon")

            harpoon:setup() -- Initialize Harpoon

            -- Adding files
            vim.keymap.set("n", "<leader>A", function() harpoon:list():prepend() end, { desc = "Prepend to Harpoon List" })
            vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Add to Harpoon List" })
            vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Toggle Harpoon Menu" })

            -- Navigation
            vim.keymap.set("n", "<leader>j", function() harpoon:list():select(1) end, { desc = "Harpoon to 1" })
            vim.keymap.set("n", "<leader>k", function() harpoon:list():select(2) end, { desc = "Harpoon to 2" })
            vim.keymap.set("n", "<leader>l", function() harpoon:list():select(3) end, { desc = "Harpoon to 3" })
            vim.keymap.set("n", "<leader>i", function() harpoon:list():select(4) end, { desc = "Harpoon to 4" })

            -- Replace at specific index
            -- vim.keymap.set("n", "<leader><C-j>", function() harpoon:list():replace_at(1) end, { desc = "Replace Harpoon at 1" })
            -- vim.keymap.set("n", "<leader><C-k>", function() harpoon:list():replace_at(2) end, { desc = "Replace Harpoon at 2" })
            -- vim.keymap.set("n", "<leader><C-l>", function() harpoon:list():replace_at(3) end, { desc = "Replace Harpoon at 3" })
            -- vim.keymap.set("n", "<leader><C-i>", function() harpoon:list():replace_at(4) end, { desc = "Replace Harpoon at 4" })
        end
    }
}


