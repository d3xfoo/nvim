return {
	{
		"github/copilot.vim",
		lazy = false, -- Load immediately
		config = function()
			-- Disable Copilot by default (optional)
			vim.g.copilot_enabled = 1

			-- Suggested keybindings
			vim.keymap.set(
				"i",
				"<C-j>",
				'copilot#Accept("<CR>")',
				{ expr = true, silent = true, replace_keycodes = false }
			)
			vim.keymap.set("i", "<C-k>", "<Plug>(copilot-dismiss)", { silent = true })
			vim.keymap.set("i", "<C-l>", "<Plug>(copilot-next)", { silent = true })
			vim.keymap.set("i", "<C-h>", "<Plug>(copilot-previous)", { silent = true })

			-- Set Copilot filetypes (optional)
			vim.g.copilot_filetypes = {
				markdown = true,
				txt = false,
                text = false,
				gitcommit = true,
				lua = false,
				javascript = false,
				typescript = false,
				javascriptreact = false,
				typescriptreact = false,
				html = false,
				css = true,
				sh = false,
                go = false,
			}
		end,
	},
}
