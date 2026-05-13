return {
	"rmagatti/auto-session",
	config = function()
		local auto_session = require("auto-session")

		auto_session.setup({
			log_level = "error",
			auto_session_enable_last_session = true,
			auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
			auto_session_enabled = true,
			auto_save_enabled = true, -- Automatically save session when leaving Neovim
			auto_restore_enabled = false, -- Automatically restore session when entering Neovim
			auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
			auto_session_use_git_branch = true, -- Use git branch name for session names
			-- Automatically create session for new projects
			auto_session_create_enabled = true,
			-- Don't restore session if there are no buffers
			bypass_session_save_file_types = { "alpha" },
		})

		local keymap = vim.keymap

		keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" }) -- restore last workspace session for current directory
		keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory
		keymap.set("n", "<leader>wd", "<cmd>SessionDelete<CR>", { desc = "Delete session for cwd" }) -- delete session for current directory
	end,
}
