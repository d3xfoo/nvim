return {
    "epwalsh/obsidian.nvim",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require("obsidian").setup({
            workspaces = {
                {
                    name = "bashneko",
                    path = "~/SecondBrain/",
                },
            },
            notes_subdir = "inbox",
            new_notes_location = "notes_subdir",
            disable_frontmatter = true,
            templates = {
                subdir = "templates",
                date_format = "%Y-%m-%d",
                time_format = "%H:%M:%S",
            },
            mappings = {
                ["gf"] = {
                    action = function()
                        return require("obsidian").util.gf_passthrough()
                    end,
                    opts = { noremap = false, expr = true, buffer = true },
                },
            },
            completion = {
                nvim_cmp = true,
                min_chars = 2,
            },

        --     ui = {
        --         enable = false,
        --         checkboxes = {},
        --         bullets = {},
        --     },
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "markdown",
            callback = function()
                vim.opt.conceallevel = 0
            end,
        })

        -- Keymaps for Obsidian
        vim.keymap.set("n", "<leader>oo", ":cd ~/secondBrain/<CR>")
        vim.keymap.set("n", "<leader>on", ":ObsidianTemplate note<CR>:lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<CR>")
        vim.keymap.set("n", "<leader>of", ":s/^#\\s*\\([^_]*\\)_\\d\\{4\\}-\\d\\{2\\}-\\d\\{2\\}$/# \\1/<CR>")
        vim.keymap.set("n", "<leader>ok", ":silent! !mv '%:p' ~/SecondBrain/reviewed/<CR>:bd<CR>")
        vim.keymap.set("n", "<leader>odd", ":silent! !rm -f '%:p'<CR>:bd<CR>")
    end
}
