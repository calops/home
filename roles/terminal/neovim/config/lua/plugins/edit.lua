local map = require("core.utils").map

return {
	-- Comment commands
	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
		opts = {
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring.internal").calculate_commentstring()
						or vim.bo.commentstring
				end,
			},
		},
	},
	-- Split/join
	{
		"Wansmer/treesj",
		lazy = true,
		init = function()
			map {
				["gs"] = {
					function() require("treesj").toggle() end,
					"Toggle split",
				},
			}
		end,
		opts = {
			max_join_length = 300,
		},
		config = true,
	},
	-- Automatically adjust indentation settings depending on the file
	{
		"nmac427/guess-indent.nvim",
		event = "BufReadPre",
		config = true,
	},
	-- Surround text objects
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = true,
	},
	-- Word families substitutions
	{
		"tpope/vim-abolish",
		event = "VeryLazy",
	},
	-- Debug print statements
	{
		"andrewferrier/debugprint.nvim",
		lazy = true,
		init = function()
			map {
				["<leader>p"] = {
					name = "debug print",
					p = {
						function() return require("debugprint").debugprint() end,
						"Add simple debug print below",
						expr = true,
					},
					P = {
						function() return require("debugprint").debugprint { above = true } end,
						"Add simple debug print above",
						expr = true,
					},
					v = {
						function() return require("debugprint").debugprint { variable = true } end,
						"Add variable debug print below",
						expr = true,
						mode = { "n", "x", "o" },
					},
					V = {
						function() return require("debugprint").debugprint { variable = true, above = true } end,
						"Add variable debug print above",
						expr = true,
						mode = { "n", "x", "o" },
					},
				},
			}
		end,
		config = true,
	},
	-- Edit filesystem as a buffer
	{
		"stevearc/oil.nvim",
		config = function() require("oil").setup() end,
	},
	-- Move stuff around
	{
		"echasnovski/mini.move",
		event = "VeryLazy",
		opts = {
			mappings = {
				left = "<S-Left>",
				right = "<S-Right>",
				down = "<S-Down>",
				up = "<S-Up>",
				line_left = "<S-Left>",
				line_right = "<S-Right>",
				line_down = "<S-Down>",
				line_up = "<S-Up>",
			},
		},
	},
	-- Align stuff
	{
		"echasnovski/mini.align",
		event = "VeryLazy",
		config = true,
	},
	-- Move around
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			search = {
				mode = "fuzzy",
				incremental = true,
			},
			modes = {
				char = {
					enabled = false,
				},
			},
		},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function() require("flash").jump() end,
			},
			{
				"S",
				mode = { "n", "o", "x" },
				function() require("flash").treesitter() end,
			},
		},
	},
}
