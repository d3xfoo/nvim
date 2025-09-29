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

		local emmet_enabled = true

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
				header = "",
				prefix = "",
				max_width = 80,
				wrap = true,
			},
		})

		-- Function to toggle emmet_ls
		local function toggle_emmet()
			local clients = vim.lsp.get_clients({ name = "emmet_ls" })

			if #clients > 0 then
				for _, client in ipairs(clients) do
					client.stop()
				end
				emmet_enabled = false
				vim.notify("Emmet LSP disabled", vim.log.levels.INFO)
			else
				if not emmet_enabled then
					lspconfig.emmet_ls.setup({
						capabilities = capabilities,
						filetypes = {
							"html",
							"typescriptreact",
							"javascriptreact",
							"html",
							"css",
							"sass",
						},
					})
					local filetype = vim.bo.filetype
					local emmet_filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass" }
					for _, ft in ipairs(emmet_filetypes) do
						if filetype == ft then
							vim.cmd("LspStart emmet_ls")
							break
						end
					end
					emmet_enabled = true
					vim.notify("Emmet LSP enabled", vim.log.levels.INFO)
				end
			end
		end
		vim.keymap.set("n", "<leader>em", toggle_emmet, {
			desc = "Toggle Emmet LSP",
			noremap = true,
			silent = true,
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

		lspconfig.tailwindcss.setup({
			capabilities = capabilities,
			filetypes = {
				"html",
				"typescriptreact",
				"javascriptreact",
				"css",
			},
		})

		lspconfig.ts_ls.setup({
			capabilities = capabilities,
			root_dir = function(fname)
				local util = lspconfig.util
				return not util.root_pattern("deno.json", "deno.jsonc")(fname)
					and util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git")(fname)
			end,
			single_file_support = true,
			init_options = {
				preferences = {
					includeCompletionsWithSnippetText = true,
					includeCompletionsForImportStatements = true,
				},
			},
		})
	end,
}
