return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Custom LSP Handlers
		local l = vim.lsp
		l.handlers["textDocument/hover"] = function(_, result, ctx, config)
			if not (result and result.contents) then
				return
			end
			local markdown_lines = l.util.convert_input_to_markdown_lines(result.contents)
			markdown_lines = vim.tbl_filter(function(line)
				return line ~= ""
			end, markdown_lines)
			if vim.tbl_isempty(markdown_lines) then
				return
			end
			config = vim.tbl_deep_extend("force", {
				border = "rounded",
				focusable = true,
				-- max_width = 80,
				-- wrap = true,
				winhighlight = "Normal:CmpNormal,FloatBorder:FloatBorder",
			}, config or {})
			config.focus_id = ctx.method
			return l.util.open_floating_preview(markdown_lines, "markdown", config)
		end

		vim.diagnostic.config({
			virtual_text = true,
			underline = true,
			update_in_insert = false,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				header = "",
				prefix = "",
				max_width = 80,
				wrap = true,
			},
		})

		-- LSP Server Configurations
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					completion = {
						callSnippet = "Replace",
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})

		lspconfig.emmet_ls.setup({
			capabilities = capabilities,
			filetypes = {
				"html",
				"typescriptreact",
				"javascriptreact",
				"css",
				"sass",
			},
		})

		lspconfig.emmet_language_server.setup({
			capabilities = capabilities,
			filetypes = {
				"css",
				"html",
				"javascript",
				"javascriptreact",
				"typescriptreact",
			},
			init_options = {
				showAbbreviationSuggestions = true,
				showExpandedAbbreviation = "always",
				showSuggestionsAsSnippets = false,
			},
		})

		lspconfig.ts_ls.setup({
			capabilities = capabilities,
			root_dir = function(fname)
				local util = lspconfig.util
				return not util.root_pattern("deno.json", "deno.jsonc")(fname)
					and util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git")(fname)
			end,
			single_file_support = false,
			init_options = {
				preferences = {
					includeCompletionsWithSnippetText = true,
					includeCompletionsForImportStatements = true,
				},
			},
		})
	end,
}
