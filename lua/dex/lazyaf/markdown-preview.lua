return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	build = "cd app && npm install",
	init = function()
		vim.g.mkdp_filetypes = { "markdown" }
	end,
	ft = { "markdown" },
	vim.keymap.set("n", "<leader>mo", "<cmd>MarkdownPreview<CR>"),
	vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewStop<CR>"),
}
