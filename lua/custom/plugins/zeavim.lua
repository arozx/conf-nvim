-- [[
return {
	"KabbAmine/zeavim.vim",
	config = function()
		-- Set up keybindings for Zeavim
		vim.keymap.set("n", "<leader>z", ":Zeavim<CR>", { noremap = true, silent = true, desc = "Open Zeavim" })
		vim.keymap.set(
			"n",
			"<leader>zs",
			":ZeavimShow<CR>",
			{ noremap = true, silent = true, desc = "Show Zeavim Documentation" }
		)
	end,
}
-- ]]
