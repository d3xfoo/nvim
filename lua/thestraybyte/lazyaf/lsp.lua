return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "stevearc/conform.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
        "windwp/nvim-autopairs",
    },
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                javascript = { "prettierd" },
                typescript = { "prettierd" },
                javascriptreact = { "prettierd" },
                typescriptreact = { "prettierd" },
                html = { "prettierd" },
                css = { "prettierd" },
            }
        })

        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        local acmp = require("cmp")
        acmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())
        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "gopls",
                "html",
                "cssls",
                "ts_ls",
                "tailwindcss",
                "emmet_ls",
            },

            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                ["ts_ls"] = function()
                    require("lspconfig").ts_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            javascript = { format = { enable = false } },
                            typescript = { format = { enable = false } },
                        },
                    })
                end,

                ["gopls"] = function()
                    require("lspconfig").gopls.setup({
                        capabilities = capabilities,
                        filetypes = { "go", "gomod" },
                    })
                end,

                ["emmet_ls"] = function()
                    require("lspconfig").emmet_ls.setup({
                        capabilities = capabilities,
                        filetypes = {
                            "html",
                            "scss",
                            "css",
                            "javascriptreact",
                            "typescriptreact"
                        },
                    })
                end,

                ["tailwindcss"] = function()
                    require("lspconfig").tailwindcss.setup({
                        capabilities = capabilities,
                        filetypes = { "html", "css", "javascriptreact", "typescriptreact" },
                    })
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
            }
        })

        local l = vim.lsp
        l.handlers["textDocument/hover"] = function(_, result, ctx, config)
            if not (result and result.contents) then return end
            local markdown_lines = l.util.convert_input_to_markdown_lines(result.contents)
            markdown_lines = vim.tbl_filter(function(line)
                return line ~= ""
            end, markdown_lines)
            if vim.tbl_isempty(markdown_lines) then return end
            config = vim.tbl_deep_extend("force", {
                border = "rounded",
                focusable = true,
                max_width = 80,
                wrap = true,
                winhighlight = "Normal:CmpNormal,FloatBorder:FloatBorder", -- this line ensures visible borders
            }, config or {})
            config.focus_id = ctx.method
            return l.util.open_floating_preview(markdown_lines, "markdown", config)
        end

        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        vim.api.nvim_set_hl(0, "CmpNormal", {})
        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = vim.NIL
            }),

            window = {
                completion = {
                    scrollbar = false,
                    border = "rounded",
                    winhighlight = "Normal:CmpNormal",
                },
                documentation = {
                    scrollbar = false,
                    border = "rounded",
                    winhighlight = "Normal:CmpNormal",
                }
            },


            sources = cmp.config.sources({
                { name = 'luasnip',  priority = 1000 },
                { name = 'nvim_lsp', priority = 900 },
            }, {
                { name = 'buffer', priority = 500 },
            })
        })

        -- Diagnostics Config
        vim.diagnostic.config({
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
                max_width = 80,
                wrap = true,
            },
        })
        -- Toggle virtual text diagnostics with <leader>er
        vim.keymap.set("n", "<leader>er", function()
            local current = vim.diagnostic.config().virtual_text
            vim.diagnostic.config({ virtual_text = not current })
            print("Diagnostics: " .. (current and "OFF" or "ON"))
        end, { desc = "Toggle inline diagnostics" })

        -- Toggle emmet completions with <leader>et
        local emmet_enabled = true
        vim.keymap.set("n", "<leader>et", function()
            emmet_enabled = not emmet_enabled
            if emmet_enabled then
                -- Re-enable emmet by updating sources
                cmp.setup.filetype({ 'javascriptreact', 'typescriptreact' }, {})
                print("Emmet: ON")
            else
                -- Disable emmet by filtering it out
                cmp.setup.filetype({ 'javascriptreact', 'typescriptreact' }, {
                    sources = cmp.config.sources({
                        {
                            name = 'nvim_lsp',
                            priority = 1000,
                            max_item_count = 20,
                            entry_filter = function(entry, ctx)
                                -- Filter out emmet_ls completions
                                if entry.source.name == 'nvim_lsp' and
                                    entry.source.source.client and
                                    entry.source.source.client.name == 'emmet_ls' then
                                    return false
                                end
                                return true
                            end
                        },
                    }, {
                        { name = 'luasnip', priority = 750, max_item_count = 10 },
                        { name = 'buffer',  priority = 500, max_item_count = 5 },
                    })
                })
                print("Emmet: OFF")
            end
        end, { desc = "Toggle emmet completions" })
    end
}
