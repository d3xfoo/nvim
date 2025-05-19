return {
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*", -- Use latest major release
        build = "make install_jsregexp",

        dependencies = { "rafamadriz/friendly-snippets" },

        config = function()
            local ls = require("luasnip")

            -- Load VSCode-style snippets (including React)
            require("luasnip.loaders.from_vscode").lazy_load()

            -- Extend filetypes
            ls.filetype_extend("javascript", { "jsdoc" })
            ls.filetype_extend("javascriptreact", { "javascript" })               -- Ensure React snippets work
            ls.filetype_extend("typescriptreact", { "typescript", "javascript" }) -- Ensure React TS snippets work

            -- Keymaps
            vim.keymap.set({ "i" }, "<C-s>e", function() ls.expand() end, { silent = true })
            vim.keymap.set({ "i", "s" }, "<C-s>;", function() ls.jump(1) end, { silent = true })
            vim.keymap.set({ "i", "s" }, "<C-s>,", function() ls.jump(-1) end, { silent = true })

            vim.keymap.set({ "i", "s" }, "<C-E>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end, { silent = true })
        end,
    }
}
