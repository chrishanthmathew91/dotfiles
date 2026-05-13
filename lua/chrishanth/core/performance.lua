-- Performance optimizations for large projects
local opt = vim.opt

-- Disable features that cause performance issues in large directories
opt.updatetime = 300 -- Increase from 50 to reduce constant file checks
opt.lazyredraw = true -- Don't redraw during macros
opt.ttyfast = true -- Fast terminal connection

-- Limit search depth for file operations
opt.maxmempattern = 2000 -- Limit memory for patterns

-- File watching optimizations
opt.swapfile = false -- Already disabled, but important for performance
opt.backup = false -- Already disabled
opt.writebackup = false -- Disable backup before overwrite

-- Reduce visual effects that can slow down large files
opt.foldmethod = "manual" -- Avoid automatic folding in large files
opt.foldenable = false -- Disable folding by default

-- LSP performance settings
vim.g.cursorhold_updatetime = 300 -- Reduce CursorHold frequency

-- Disable certain features in very large files
vim.api.nvim_create_autocmd("BufReadPre", {
	pattern = "*",
	callback = function()
		local file_size = vim.fn.getfsize(vim.fn.expand("%"))
		if file_size > 100000 then -- 100KB threshold
			-- Disable syntax highlighting for very large files
			vim.cmd("syntax off")
			-- Disable swap and undo for large files
			vim.opt_local.swapfile = false
			vim.opt_local.undofile = false
			-- Disable folding
			vim.opt_local.foldmethod = "manual"
			vim.opt_local.foldenable = false
		end
	end,
})

-- Avoid scanning these directories for files
vim.opt.wildignore:append({
	"*/node_modules/*",
	"*/.git/*",
	"*/.next/*",
	"*/dist/*",
	"*/build/*",
	"*/coverage/*",
	"*/.cache/*",
	"*/logs/*",
	"*/terminals/*",
	"*/agent-tools/*",
	"*/agent-transcripts/*",
	"*/.cursor/*",
})

-- Set reasonable limits for file operations
vim.g.matchparen_timeout = 20 -- Limit paren matching time
vim.g.matchparen_insert_timeout = 20