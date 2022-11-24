-- local status, _ = pcall(vim.cmd, "colorscheme nightfly")
-- if not status then
-- 	print("Colorscheme not found!")
-- 	return
-- end

require("nightfox").setup({
	options = {
		transparent = true,
		styles = {
			comments = "italic",
			keywords = "bold",
			types = "italic,bold",
		},
	},
})

vim.cmd("colorscheme carbonfox")
