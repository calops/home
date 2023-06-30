local nmap = require("core.utils").nmap
local tmap = require("core.utils").tmap

return {
	-- Session management
	{
		"olimorris/persisted.nvim",
		lazy = false,
		init = function()
			local group = vim.api.nvim_create_augroup("PersistedHooks", {})
			local ignored_file_types = { "Trouble", "neo-tree" }
			vim.api.nvim_create_autocmd({ "User" }, {
				pattern = "PersistedSavePre",
				group = group,
				callback = function()
					for _, buf in ipairs(vim.api.nvim_list_bufs()) do
						local file_type = vim.api.nvim_buf_get_option(buf, "filetype")
						if vim.tbl_contains(ignored_file_types, file_type) then
							vim.api.nvim_command("silent! bwipeout! " .. buf)
						end
					end
				end,
			})
		end,
		opts = {
			use_git_branch = true,
			autosave = true,
			autoload = true,
			follow_cwd = false,
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
			local function toggle() require("toggleterm").toggle() end
			nmap { ["<C-f>"] = { toggle, "Toggle floating terminal" } }
			tmap { ["<C-f>"] = { toggle, "Toggle floating terminal" } }
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
	-- Auto close buffers
	{
		"chrisgrieser/nvim-early-retirement",
		opts = {
			retirementAgeMins = 10,
		},
	},
}
