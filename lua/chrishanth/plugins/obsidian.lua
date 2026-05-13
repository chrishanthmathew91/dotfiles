return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	-- Load on markdown OR when any of our commands are invoked (e.g. from Alpha).
	ft = { "markdown" },
	cmd = {
		-- Obsidian.nvim commands we use
		"ObsidianToday",
		"ObsidianDailies",
		"ObsidianYesterday",
		"ObsidianTomorrow",
		"ObsidianSearch",
		"ObsidianRename",
		"ObsidianExtractNote",
		-- Our helper commands
		"NotesPinned",
		"NotesPin",
	},
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local function first_existing_dir(candidates)
			for _, dir in ipairs(candidates) do
				local expanded = vim.fn.expand(dir)
				if vim.fn.isdirectory(expanded) == 1 then
					return expanded
				end
			end
			return nil
		end

		-- Project-scoped daily notes: prefer mobile-monorepo if present, otherwise fall back.
		local vault = first_existing_dir({
			"~/Dev/mobile-monorepo/notes",
			"~/Dev/mobile-monorepo/.notes",
			"~/notes/mobile-monorepo",
			"~/notes",
		}) or vim.fn.expand("~/notes")

		local daily = vault .. "/daily"
		if vim.fn.isdirectory(daily) == 0 then
			vim.fn.mkdir(daily, "p")
		end

		local pinned_path = vault .. "/pinned.md"

		require("obsidian").setup({
			workspaces = {
				{
					name = "mobile-monorepo",
					path = vault,
				},
			},
			daily_notes = {
				folder = "daily",
				date_format = "%Y-%m-%d",
				alias_format = "%B %-d, %Y",
				default_tags = { "daily" },
				template = nil,
			},
			disable_frontmatter = true,
			ui = { enable = false },
		})

		local function note_ref_for_buf(bufnr)
			bufnr = bufnr or 0
			local path = vim.api.nvim_buf_get_name(bufnr)
			if path == nil or path == "" then
				return nil
			end

			-- Prefer Obsidian-style wikilinks when the file is inside the vault.
			local vault_prefix = vault
			if not vim.endswith(vault_prefix, "/") then
				vault_prefix = vault_prefix .. "/"
			end

			local normalized = vim.fs.normalize(path)
			local normalized_prefix = vim.fs.normalize(vault_prefix)
			if vim.startswith(normalized, normalized_prefix) then
				local rel = string.sub(normalized, #normalized_prefix + 1)
				rel = rel:gsub("%.md$", "")
				return ("[[%s]]"):format(rel)
			end

			-- Fall back to a plain filename reference.
			return vim.fn.fnamemodify(path, ":t")
		end

		local function open_pinned()
			-- Auto-create on first use.
			if vim.fn.filereadable(pinned_path) == 0 then
				local lines = {
					"# Pinned",
					"",
					"- ",
					"",
					"## Quick links",
					"",
					"- [[daily/" .. os.date("%Y-%m-%d") .. "]]",
				}
				vim.fn.writefile(lines, pinned_path)
			end
			vim.cmd("edit " .. vim.fn.fnameescape(pinned_path))
		end

		local function pin_current_note()
			local ref = note_ref_for_buf(0)
			if not ref then
				vim.notify("No file-backed buffer to pin", vim.log.levels.WARN)
				return
			end

			if vim.fn.filereadable(pinned_path) == 0 then
				open_pinned()
				-- If we just created it, we can proceed to append below.
			end

			local lines = vim.fn.readfile(pinned_path)
			local entry = "- " .. ref

			for _, line in ipairs(lines) do
				if vim.trim(line) == entry then
					vim.notify("Already pinned: " .. ref, vim.log.levels.INFO)
					return
				end
			end

			table.insert(lines, 2, entry) -- right under the "# Pinned" heading
			vim.fn.writefile(lines, pinned_path)
			vim.notify("Pinned: " .. ref, vim.log.levels.INFO)
		end

		local function search_prompt()
			vim.ui.input({ prompt = "Search notes: " }, function(input)
				if not input or input == "" then
					return
				end
				vim.cmd("ObsidianSearch " .. vim.fn.fnameescape(input))
			end)
		end

		local function get_visual_selection()
			-- Returns selected text (single line preferred) or nil.
			local srow, scol = unpack(vim.api.nvim_buf_get_mark(0, "<"))
			local erow, ecol = unpack(vim.api.nvim_buf_get_mark(0, ">"))
			if srow == 0 or erow == 0 then
				return nil
			end
			if srow > erow or (srow == erow and scol > ecol) then
				srow, erow = erow, srow
				scol, ecol = ecol, scol
			end

			local lines = vim.api.nvim_buf_get_text(0, srow - 1, scol, erow - 1, ecol + 1, {})
			if not lines or #lines == 0 then
				return nil
			end
			local text = table.concat(lines, "\n")
			text = vim.trim(text)
			if text == "" then
				return nil
			end
			return text
		end

		local function extract_and_pin()
			local selected = get_visual_selection()
			if not selected then
				vim.notify("No selection to extract", vim.log.levels.WARN)
				return
			end

			-- Use a short default title based on selection.
			local default_title = selected:gsub("%s+", " ")
			if #default_title > 60 then
				default_title = default_title:sub(1, 60) .. "…"
			end

			vim.ui.input({ prompt = "New note title: ", default = default_title }, function(title)
				if not title or title == "" then
					return
				end
				-- Extract selection into the new note (also links it from current note).
				vim.cmd("ObsidianExtractNote " .. vim.fn.fnameescape(title))
				-- After the command runs and buffer changes, pin the new note.
				vim.schedule(function()
					pin_current_note()
				end)
			end)
		end

		local function delete_current_note()
			local current_file = vim.api.nvim_buf_get_name(0)
			if current_file == "" or not vim.fn.filereadable(current_file) then
				vim.notify("No file to delete", vim.log.levels.WARN)
				return
			end

			local filename = vim.fn.fnamemodify(current_file, ":t")
			vim.ui.input({
				prompt = string.format("Delete '%s'? (y/N): ", filename)
			}, function(input)
				if input and string.lower(input) == "y" then
					-- Remove from pinned notes if it exists there
					local ref = note_ref_for_buf(0)
					if ref and vim.fn.filereadable(pinned_path) == 1 then
						local lines = vim.fn.readfile(pinned_path)
						local filtered_lines = {}
						local removed = false
						for _, line in ipairs(lines) do
							local entry = "- " .. ref
							if vim.trim(line) ~= entry then
								table.insert(filtered_lines, line)
							else
								removed = true
							end
						end
						if removed then
							vim.fn.writefile(filtered_lines, pinned_path)
							vim.notify("Removed from pinned list", vim.log.levels.INFO)
						end
					end

					-- Close buffer and delete file
					vim.cmd("bdelete!")
					vim.fn.delete(current_file)
					vim.notify("Deleted: " .. filename, vim.log.levels.INFO)
				end
			end)
		end

		local function cleanup_old_dailies()
			local daily_dir = vault .. "/daily"
			if vim.fn.isdirectory(daily_dir) == 0 then
				vim.notify("No daily notes directory found", vim.log.levels.WARN)
				return
			end

			vim.ui.input({
				prompt = "Delete daily notes older than how many days? "
			}, function(days)
				if not days or not tonumber(days) then 
					return 
				end

				local cutoff = os.time() - (tonumber(days) * 24 * 60 * 60)
				local deleted = 0
				local files_to_delete = {}

				-- Collect files to delete
				for file in vim.fs.dir(daily_dir) do
					if file:match("^%d%d%d%d%-%d%d%-%d%d%.md$") then
						local file_path = daily_dir .. "/" .. file
						local stat = vim.loop.fs_stat(file_path)
						if stat and stat.mtime.sec < cutoff then
							table.insert(files_to_delete, {path = file_path, name = file})
						end
					end
				end

				if #files_to_delete == 0 then
					vim.notify("No old daily notes found", vim.log.levels.INFO)
					return
				end

				-- Confirm deletion
				local file_list = {}
				for _, file_info in ipairs(files_to_delete) do
					table.insert(file_list, file_info.name)
				end
				local message = string.format("Delete %d files?\n%s", #files_to_delete, table.concat(file_list, ", "))
				
				vim.ui.input({
					prompt = message .. " (y/N): "
				}, function(confirm)
					if confirm and string.lower(confirm) == "y" then
						for _, file_info in ipairs(files_to_delete) do
							vim.fn.delete(file_info.path)
							deleted = deleted + 1
						end
						vim.notify(string.format("Deleted %d old daily notes", deleted), vim.log.levels.INFO)
					end
				end)
			end)
		end

		vim.api.nvim_create_user_command("NotesPinned", open_pinned, { desc = "Open pinned notes list" })
		vim.api.nvim_create_user_command("NotesPin", pin_current_note, { desc = "Pin current note into pinned.md" })
		vim.api.nvim_create_user_command("NotesDelete", delete_current_note, { desc = "Delete current note" })
		vim.api.nvim_create_user_command("NotesCleanup", cleanup_old_dailies, { desc = "Cleanup old daily notes" })

		local keymap = vim.keymap
		keymap.set("n", "<leader>nd", "<cmd>ObsidianToday<CR>", { desc = "Notes: today" })
		keymap.set("n", "<leader>nD", "<cmd>ObsidianDailies<CR>", { desc = "Notes: dailies" })
		keymap.set("n", "<leader>ny", "<cmd>ObsidianYesterday<CR>", { desc = "Notes: yesterday" })
		keymap.set("n", "<leader>nt", "<cmd>ObsidianTomorrow<CR>", { desc = "Notes: tomorrow" })
		keymap.set("n", "<leader>ns", "<cmd>ObsidianSearch<CR>", { desc = "Notes: search" })
		keymap.set("n", "<leader>nS", search_prompt, { desc = "Notes: search prompt" })
		keymap.set("n", "<leader>np", open_pinned, { desc = "Notes: pinned" })
		keymap.set("n", "<leader>nP", "<cmd>NotesPin<CR>", { desc = "Notes: pin current note" })
		keymap.set("v", "<leader>ne", extract_and_pin, { desc = "Notes: extract selection + pin" })
		keymap.set("n", "<leader>nr", "<cmd>ObsidianRename<CR>", { desc = "Notes: rename (update links)" })
		keymap.set(
			"n",
			"<leader>nR",
			"<cmd>ObsidianRename --dry-run<CR>",
			{ desc = "Notes: rename dry-run" }
		)
		keymap.set("n", "<leader>nX", delete_current_note, { desc = "Notes: delete current note" })
		keymap.set("n", "<leader>nC", cleanup_old_dailies, { desc = "Notes: cleanup old dailies" })
	end,
}

