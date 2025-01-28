-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Set up globals {{{
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.skip_ts_context_commentstring_module = true
vim.g.have_nerd_font = true
-- }}}

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Set up options {{{
vim.opt.background = "dark"
vim.opt.cursorline = true
vim.opt.guicursor = ""
vim.opt.incsearch = true
vim.opt.isfname = "@,48-57,/,.,-,_,+,,,#,$,%,~,=,@-@"
vim.opt.showtabline = 0
vim.opt.signcolumn = "yes"
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = "split"
-- }}}

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

do
	local __basic_binds = {
		{
			action = ":m '>+1<CR>gv=gv",
			key = "J",
			mode = "v",
			options = { desc = "Move selection up" },
		},
		{
			action = ":m '<-2<CR>gv=gv",
			key = "K",
			mode = "v",
			options = { desc = "Move selection down" },
		},
		{
			action = '"ry/<C-r>r',
			key = "<leader>sv",
			mode = "v",
			options = { desc = "[S]earch selection with [V]im" },
		},
		{
			action = "mzJ`z",
			key = "J",
			mode = "n",
			options = { desc = "[J]oin but cursor stays put" },
		},
		{
			action = "<C-d>zz",
			key = "<C-d>",
			mode = "n",
			options = { desc = "Jump down with fixed cursor" },
		},
		{
			action = "<C-u>zz",
			key = "<C-u>",
			mode = "n",
			options = { desc = "Jump up with fixed cursor" },
		},
		{
			action = "nzzzv",
			key = "n",
			mode = "n",
			options = { desc = "[N]ext with fixed cursor" },
		},
		{
			action = "Nzzzv",
			key = "N",
			mode = "n",
			options = { desc = "Previous with fixed cursor" },
		},
		{
			action = [["_dP]],
			key = "<leader>p",
			mode = "x",
			options = { desc = "[P]aste keep clipboard" },
		},
		{
			action = [["+y]],
			key = "<leader>y",
			mode = { "n", "v" },
			options = { desc = "[Y]ank system clipboard" },
		},
		{
			action = [["+Y]],
			key = "<leader>Y",
			mode = "n",
			options = { desc = "[Y]ank system clipboard" },
		},
		{
			action = [["_d]],
			key = "<leader>d",
			mode = "n",
			options = { desc = "[D]elete to to system clipboard" },
		},
		{
			action = "<nop>",
			key = "Q",
			mode = "n",
			options = { desc = "Nothing" },
		},
	}
	for _, map in ipairs(__basic_binds) do
		vim.keymap.set(map.mode, map.key, map.action, map.options)
	end
end

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Todo Keybinds
vim.keymap.set("n", "]t", function()
	require("todo-comments").jump_next({ keywords = { "TODO" } })
end, { desc = "Next todo comment" })
vim.keymap.set("n", "[t", function()
	require("todo-comments").jump_prev({ keywords = { "TODO" } })
end, { desc = "Previous todo comment" })

-- TODO:
-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- [[ Basic Autogroups ]] {{
vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_augroup("markdown_conceal", { clear = true })
-- }}

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

do
	local __vim_autocommands = {
		{
			command = "setlocal conceallevel=2",
			event = { "FileType" },
			group = "markdown_conceal",
			pattern = { "markdown" },
			desc = "Used for displaying markdown",
		},
		{
			callback = function()
				vim.highlight.on_yank()
			end,
			desc = "Highlight when yanking text",
			event = { "TextYankPost" },
			group = "highlight_yank",
		},
	}

	for _, autocmd in ipairs(__vim_autocommands) do
		vim.api.nvim_create_autocmd(autocmd.event, {
			group = autocmd.group,
			pattern = autocmd.pattern,
			buffer = autocmd.buffer,
			desc = autocmd.desc,
			callback = autocmd.callback,
			command = autocmd.command,
			once = autocmd.once,
			nested = autocmd.nested,
		})
	end
end

local lazyOptions = {
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
}

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
require("lazy").setup({
	spec = {
		-- NOTE: Plugins
		"tpope/vim-sleuth",
		-- Useful for getting pretty icons, but requires a Nerd Font.
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		{ "stevearc/dressing.nvim", opts = {} },

		{ import = "custom.plugins" },
	},
}, lazyOptions)

-- Setup clipboard for wsl {{{
if vim.fn.has("wsl") == 1 then
	vim.g.clipboard = {
		name = "WslClipboard",
		copy = {
			["+"] = "clip.exe",
			["*"] = "clip.exe",
		},
		paste = {
			["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
			["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
		},
		cache_enabled = 0,
	}
end
-- }}}
