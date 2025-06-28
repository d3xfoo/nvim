return {
	"hrsh7th/nvim-cmp",
	branch = "main",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
		"onsails/lspkind.nvim",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		-- Load vscode style snippets
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,noselect", -- Changed to noselect
			},
			window = {
				completion = {
					scrollbar = true,
					border = "rounded",
					winhighlight = "Normal:CmpNormal",
				},
				documentation = {
					scrollbar = true,
					border = "rounded",
					winhighlight = "Normal:CmpNormal",
				},
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			sources = cmp.config.sources({
				{ name = "luasnip" },
				{ name = "nvim_lsp" },
				{ name = "buffer" },
				{ name = "path" },
			}),
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-e>"] = cmp.mapping.abort(),
				["<C-y>"] = cmp.mapping.confirm({ select = true }), -- Only Ctrl+y confirms
				["<CR>"] = cmp.mapping(function(fallback)
					-- Enter key does NOT confirm completion, just fallback to normal behavior
					fallback()
				end, { "i", "s" }),
				["<Tab>"] = cmp.mapping(function(fallback)
					-- Tab does NOT confirm completion, just fallback to normal behavior
					fallback()
				end, { "i", "s" }),
			}),
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol_text",
					maxwidth = 50,
					ellipsis_char = "...",
					show_labelDetails = true,
				}),
			},
		})
	end,
}
