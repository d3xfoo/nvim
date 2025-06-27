return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		local function has_formatter_config()
			local config_files = {
				-- Prettier configs
				".prettierrc",
				".prettierrc.json",
				".prettierrc.yml",
				".prettierrc.yaml",
				".prettierrc.js",
				".prettierrc.cjs",
				"prettier.config.js",
				"prettier.config.cjs",
				-- Biome configs
				"biome.json",
				"biome.jsonc",
			}

			local current_dir = vim.fn.expand("%:p:h")
			while current_dir ~= "/" do
				for _, config_file in ipairs(config_files) do
					if vim.fn.filereadable(current_dir .. "/" .. config_file) == 1 then
						return true
					end
				end
				-- Check package.json for prettier config
				local package_json = current_dir .. "/package.json"
				if vim.fn.filereadable(package_json) == 1 then
					local content = vim.fn.readfile(package_json)
					if #content > 0 and table.concat(content, "\n"):match('"prettier"') then
						return true
					end
				end
				current_dir = vim.fn.fnamemodify(current_dir, ":h")
			end
			return false
		end

		conform.setup({
			formatters_by_ft = {
				javascript = { "biome", "prettier" },
				typescript = { "biome", "prettier" },
				javascriptreact = { "biome", "prettier" },
				typescriptreact = { "biome", "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "biome", "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				lua = { "stylua" },
				python = { "black" },
			},
		})

		-- Configure prettier with your defaults (only used when no config exists)
		conform.formatters.prettier = {
			args = {
				"--stdin-filepath",
				"$FILENAME",
				"--single-quote",
				"false",
				"--semi",
				"false",
				"--tab-width",
				"4",
				"--use-tabs",
				"false",
			},
		}

		-- Smart format function
		vim.keymap.set({ "n", "v" }, "<leader>fm", function()
			local filetype = vim.bo.filetype
			local prettier_fts = {
				"javascript",
				"typescript",
				"javascriptreact",
				"typescriptreact",
				"svelte",
				"css",
				"html",
				"json",
				"yaml",
				"markdown",
				"graphql",
			}

			-- Check if current filetype uses prettier
			local uses_prettier = false
			for _, ft in ipairs(prettier_fts) do
				if ft == filetype then
					uses_prettier = true
					break
				end
			end

			-- If it's a formatter filetype but no config exists, use LSP
			if uses_prettier and not has_formatter_config() then
				vim.lsp.buf.format()
			else
				-- Use conform (which will use prettier config if exists, or other formatters)
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				})
			end
		end, {})
	end,
}
