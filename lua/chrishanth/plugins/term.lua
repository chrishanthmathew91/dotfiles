local Terminal = require("toggleterm.terminal").Terminal

local git_tui = "lazygit"

local git_client = Terminal:new({
	cmd = git_tui,
	hidden = true,
	direction = "float",
	float_opts = {
		border = "double",
	},
})

function git_client_toggle()
	git_client:toggle()
end

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>g", "<cmd>lua git_client_toggle()<CR>", opts)
