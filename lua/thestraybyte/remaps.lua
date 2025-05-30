vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

-- -- Insert mode: Use Ctrl + hjkl to move cursor
-- vim.keymap.set("i", "<C-h>", "<Left>", { desc = "Move Left in Insert" })
-- vim.keymap.set("i", "<C-j>", "<Down>", { desc = "Move Down in Insert" })
-- vim.keymap.set("i", "<C-k>", "<Up>", { desc = "Move Up in Insert" })
-- vim.keymap.set("i", "<C-l>", "<Right>", { desc = "Move Right in Insert" })

-- obsidian notes remaps
vim.keymap.set("n", "<leader>oo", ":cd /home/bashneko/SecondBrain/<CR>")
vim.keymap.set("n", "<leader>on", ":ObsidianTemplate note<CR>:lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<CR>")
vim.keymap.set("n", "<leader>of", ":s/^#\\s*\\([^_]*\\)_\\d\\{4\\}-\\d\\{2\\}-\\d\\{2\\}$/# \\1/<CR>")
vim.keymap.set("n", "<leader>ok", ":silent! !mv '%:p' /home/bashneko/SecondBrain/reviewed/<CR>:bd<CR>")
vim.keymap.set("n", "<leader>odd", ":silent! !rm -f '%:p'<CR>:bd<CR>")



-- Ctrl + S: Save file in both Normal and Insert mode
-- vim.keymap.set({ "n", "i" }, "<C-s>", "<cmd>w<CR>", { desc = "Save File" })

-- vim.keymap.set("n", "<leader>vwm", function()
--     require("vim-with-me").StartVimWithMe()
-- end)
-- vim.keymap.set("n", "<leader>svwm", function()
--     require("vim-with-me").StopVimWithMe()
-- end)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever  : asbjornHaland
-- yanks to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")

-- This is going to get me cancelled
-- vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux_sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- vim.keymap.set("n", "<leader>f", function()
--     require("conform").format()
-- end, { noremap = true, silent = true })
--
--

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set(
    "n",
    "<leader>ee",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)

-- vim.keymap.set(
--     "n",
--     "<leader>ea",
--     "oassert.NoError(err, \"\")<Esc>F\";a"
-- )

-- vim.keymap.set(
--     "n",
--     "<leader>ef",
--     "oif err != nil {<CR>}<Esc>Olog.Fatalf(\"error: %s\\n\", err.Error())<Esc>jj"
-- )

-- vim.keymap.set(
--     "n",
--     "<leader>el",
--     "oif err != nil {<CR>}<Esc>O.logger.Error(\"error\", \"error\", err)<Esc>F.;i"
-- )

-- vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

