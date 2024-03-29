local map = require("core.utils").map
return {
	-- Fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-media-files.nvim",
			"nvim-telescope/telescope-symbols.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			{
				"prochri/telescope-all-recent.nvim",
				dependencies = { "kkharji/sqlite.lua" },
			},
		},
		cmd = "Telescope",
		lazy = true,
		init = function()
			map {
				["<C-p>"] = {
					function() require("telescope.builtin").find_files() end,
					"Find files",
				},
				["<leader>"] = {
					["<Space>"] = {
						function() require("telescope.builtin").grep_string() end,
						"Grep string under cursor",
					},
					s = {
						function() require("telescope.builtin").live_grep() end,
						"Live grep",
					},
					b = {
						function() require("telescope.builtin").buffers() end,
						"Find buffer",
					},
					e = {
						function() require("telescope.builtin").symbols() end,
						"Select symbol",
					},
					R = {
						function() require("telescope.builtin").resume() end,
						"Resume selection",
					},
				},
			}
		end,
		config = function()
			require("notify")
			local telescope = require("telescope")

			telescope.setup {
				defaults = {
					layout_strategy = "flex",
					layout_config = {
						flex = { flip_columns = 200 },
					},
					mappings = { i = { ["<esc>"] = require("telescope.actions").close } },
				},
			}

			telescope.load_extension("fzf")
			telescope.load_extension("notify")
			telescope.load_extension("media_files")
			telescope.load_extension("persisted")

			require("telescope-all-recent").setup {
				default = {
					sorting = "frecency",
				},
				pickers = {
					live_grep = {
						disable = false,
					},
					grep_string = {
						disable = false,
					},
				},
			}
		end,
	},
	-- File tree browser
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		cmd = "Neotree",
		init = function()
			map {
				["<leader>n"] = {
					name = "file tree",
					n = { ":Neotree toggle reveal_force_cwd<cr>", "Toggle file browser" },
					g = { ":Neotree toggle git_status<cr>", "Show git status" },
					b = { ":Neotree toggle buffers<cr>", "Show open buffers" },
				},
			}
		end,
		config = function()
			require("neo-tree").setup {
				popup_border_style = "rounded",
				filesystem = {
					filtered_items = {
						visible = true,
						hide_dotfiles = false,
						hide_gitignored = true,
					},
				},
				source_selector = {
					winbar = true,
					statusline = false,
				},
				default_component_config = {
					modified = {
						symbol = "",
						highlight = "NeoTreeModified",
					},
				},
			}
		end,
	},
}
