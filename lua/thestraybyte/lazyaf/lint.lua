return {
    "mfussenegger/nvim-lint",

    config = function()
        local lint = require("lint")

        -- Dynamically determine ESLint path (prefer project-local version)
        lint.linters.eslint.cmd = function()
            local eslint_local = vim.fn.getcwd() .. "/node_modules/.bin/eslint"
            return vim.fn.filereadable(eslint_local) == 1 and eslint_local or "eslint"
        end

        -- Assign linters by filetype
        lint.linters_by_ft = {
            -- javascript = { "eslint" },
            -- typescript = { "eslint" },
            -- javascriptreact = { "eslint" },
            -- typescriptreact = { "eslint" },
            -- css = { "stylelint" }, -- uncomment if using stylelint
        }

        -- Auto-run linter on save or text change, only if a linter is defined
        vim.api.nvim_create_autocmd({ "BufWritePost", "TextChanged" }, {
            callback = function()
                local ft = vim.bo.filetype
                if lint.linters_by_ft[ft] then
                    lint.try_lint()
                end
            end,
        })
    end
}
