function Themes(color)
    color = color or "vague"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {

    {
        "vague2k/vague.nvim",
        config = function()
            require("vague").setup({
                transparent = true,
            })
            vim.cmd("colorscheme vague")
            vim.cmd(":hi statusline guibg=#232136")
        end
    },


    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require('rose-pine').setup({
                disable_background = true,
                styles = {
                    italic = false,
                },
            })
        end
    },


}

