return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = function()
			local keys = {
				{
					"<C-e>",
					function()
						local harpoon = require("harpoon")
						harpoon.ui:toggle_quick_menu(harpoon:list())
					end,
					desc = "[H]arpoon [O]pen harpoon list",
				},
				{
					"<leader>ha",
					function()
						require("harpoon"):list():add()
					end,
					desc = "[H]arpoon [A]dd file to list",
				},
				{
					"<leader>ho",
					function()
						local harpoon = require("harpoon")
						harpoon.ui:toggle_quick_menu(harpoon:list())
					end,
					desc = "[H]arpoon [O]pen harpoon list",
				},
				{
					"<C-h>",
					function()
						require("harpoon"):list():select(1)
					end,
					desc = "Go to first file in harpoon list",
				},
				{
					"<C-j>",
					function()
						require("harpoon"):list():select(2)
					end,
					desc = "Go to second file in harpoon list",
				},
				{
					"<C-k>",
					function()
						require("harpoon"):list():select(3)
					end,
					desc = "Go to third file in harpoon list",
				},
				{
					"<C-l>",
					function()
						require("harpoon"):list():select(4)
					end,
					desc = "Go to fourth file in harpoon list",
				},
			}
			return keys
		end,
	},
}
