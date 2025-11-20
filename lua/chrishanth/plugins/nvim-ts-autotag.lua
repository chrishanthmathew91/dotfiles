return {
	"windwp/nvim-ts-autotag",
	-- Lazy will call: require("nvim-ts-autotag").setup(opts)
	opts = {}, -- keep defaults
	event = "VeryLazy", -- or restrict to relevant filetypes:
	-- ft = { "html", "xml", "javascriptreact", "typescriptreact", "svelte", "vue" },
	dependencies = { "nvim-treesitter/nvim-treesitter" },
}
