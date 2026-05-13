local opt = vim.opt -- for conciseness

-- general
opt.backup = false
opt.cmdheight = 1
opt.completeopt = { "menuone", "noselect" }
opt.conceallevel = 0
opt.showtabline = 0
opt.showmode = false
opt.pumheight = 10
opt.laststatus = 3
opt.ruler = false
opt.swapfile = false
opt.hlsearch = false
opt.incsearch = true

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.smartcase = true

-- line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.scrolloff = 8

-- Font (GUI Neovim): Iosevka is compact and modern; install Nerd Font build from nerdfonts.com
if vim.fn.has("gui_running") then
	vim.opt.guifont = "Iosevka Nerd Font:h20"
	-- Alternatives: "JetBrainsMono Nerd Font:h15" · "Maple Mono NF:h14" · "GeistMono Nerd Font:h14"
end

-- Better text rendering (transparency effects)
opt.pumblend = 10 -- Popup menu transparency
opt.winblend = 10 -- Window transparency for floating windows

-- Better text rendering quality
opt.emoji = true -- Enable emoji rendering
opt.showbreak = "↪ " -- Show line continuation character
opt.listchars = {
	tab = "→ ",
	extends = "⟩",
	precedes = "⟨",
	trail = "·",
	nbsp = "␣",
	eol = "↲",
}

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")
opt.updatetime = 50
-- Omit `terminal`: restoring terminal buffers in sessions keeps large scrollback in memory
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,localoptions"
opt.timeoutlen = 300
opt.ttimeoutlen = 0
opt.undofile = true
opt.undodir = vim.fn.expand("~/.local/share/nvim/undo")
opt.mouse = "a"
opt.cursorline = true
-- opt.colorcolumn = "80"

-- Fun cursor settings - animated blinking cursor
vim.opt.guicursor = {
	"n-v-c:block-Cursor/lCursor", -- Block cursor in normal/visual/command mode
	"i-ci-ve:ver25-Cursor/lCursor", -- Vertical bar in insert mode
	"r-cr:hor20-Cursor/lCursor", -- Horizontal bar in replace mode
	"o:hor50-Cursor/lCursor", -- Horizontal bar in operator pending
	"a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor", -- Animated blinking
	"sm:block-blinkwait175-blinkoff150-blinkon175", -- Smooth block cursor
}

-- Better line number styling
opt.numberwidth = 4 -- Make line numbers wider for better readability

-- Performance optimizations for large projects
opt.lazyredraw = true -- Don't redraw screen during macros/scripts
opt.ttyfast = true -- Fast terminal connection
opt.synmaxcol = 500 -- Don't highlight very long lines
opt.redrawtime = 1500 -- Time in milliseconds for redrawing the display
opt.maxmempattern = 2000 -- Maximum amount of memory for pattern matching
