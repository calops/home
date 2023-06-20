local nmap = require("core.utils").nmap
local imap = require("core.utils").imap
local tmap = require("core.utils").tmap

return {
	-- Session management
	{
		"rmagatti/auto-session",
		lazy = false,
		priority = 1001,
		init = function()
			nmap {
				["<C-s>"] = {
					function()
						require("auto-session.session-lens").search_session()
					end,
					"Search sessions",
				},
			}
		end,
		opts = {
			log_level = "error",
			cwd_change_handling = false,
			bypass_session_save_file_types = { "neo-tree" },
			pre_save_cmds = {
				function()
					require("neo-tree.sources.manager").close_all()
				end,
			},
		},
	},
	-- Universal clipboard forwarding
	{
		"ojroques/nvim-osc52",
		lazy = true,
		init = function()
			vim.api.nvim_create_autocmd("TextYankPost", {
				callback = function()
					if vim.v.event.operator == "y" and vim.v.event.regname == "+" then
						require("osc52").copy_register("+")
					end
				end,
			})
		end,
	},
	-- Startup time analyzer
	{
		"dstein64/vim-startuptime",
		lazy = false,
		enabled = false,
	},
	-- Floating terminal window
	{
		"akinsho/toggleterm.nvim",
		name = "toggleterm",
		cmd = "ToggleTerm",
		init = function()
			nmap { ["<C-f>"] = { "<Cmd>exe v:count1 . 'ToggleTerm'<CR>", "Toggle floating terminal" } }
			imap { ["<C-f>"] = { "<Esc><Cmd>exe v:count1 . 'ToggleTerm'<CR>", "Toggle floating terminal" } }
			vim.api.nvim_create_autocmd("TermEnter", {
				pattern = "term://*toggleterm#*",
				callback = function()
					tmap {
						["<C-f>"] = { "<Cmd>exe v:count1 . 'ToggleTerm'<CR>", "Toggle floating terminal" },
					}
				end,
			})
		end,
		opts = {
			direction = "float",
			float_opts = { border = "rounded" },
			highlights = { FloatBorder = { link = "TermFloatBorder" } },
		},
	},
	-- Project-local configuration
	{
		"folke/neoconf.nvim",
		lazy = false,
		enabled = true,
		config = true,
	},
}
