local nmap = require("core.utils").nmap

vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError", numhl = "" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn", numhl = "" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo", numhl = "" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint", numhl = "" })

return {
	-- TUI
	{
		"rebelot/heirline.nvim",
		lazy = false,
		config = function()
			require("catppuccin")

			vim.o.signcolumn = "no"
			vim.o.foldcolumn = "0"

			require("heirline").setup {
				statuscolumn = require("plugins.ui.statuscolumn"),
				tabline = require("plugins.ui.tabline"),
				-- statusline = require('plugins.ui.statusline'),
			}

			local function new_tab()
				vim.cmd([[
                    let view = winsaveview()
                    tabedit %
                    call winrestview(view)
                ]])
			end

			nmap {
				["<C-t>"] = { new_tab, "Open current buffer in new tab" },
				["<C-g>"] = { ":tabclose<CR>", "Close current tab" },
				["<C-Tab>"] = { ":tabnext<CR>", "View next tab" },
				["<C-S-Tab>"] = { ":tabprevious<CR>", "View previous tab" },
			}
		end,
	},
	require("plugins.ui.windowline"),
	-- Colorful modes
	{
		"mvllow/modes.nvim",
		event = "VeryLazy",
		config = true,
	},
	-- CMD line replacement and other UI niceties
	{
		"folke/noice.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		enabled = true,
		lazy = false,
		init = function()
			nmap { ["<leader><leader>"] = { ":noh<CR>", "Hide search highlights" } }
		end,
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = false,
				command_palette = true,
				long_message_to_split = true,
				lsp_doc_border = true,
			},
			views = {
				messages = { backend = "popup" },
			},
			popupmenu = { enabled = true, backend = "nui" },
			routes = {
				{
					view = "notify",
					filter = { event = "msg_show", find = '"*"*lines --*%--' },
					opts = { skip = true },
				},
			},
		},
	},
	-- IDE panels
	{
		"ldelossa/nvim-ide",
		cmd = "Workspace",
		init = function()
			nmap {
				["<leader>w"] = {
					name = "ide",
					l = { ":Workspace LeftPanelToggle<CR>", "Toggle git panels" },
					r = { ":Workspace RightPanelToggle<CR>", "Toggle IDE panels" },
				},
			}
		end,
		opts = {
			workspaces = {
				auto_open = "none",
			},
			panel_sizes = {
				left = 60,
				right = 60,
				bottom = 15,
			},
		},
	},
	-- Better select dialog
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {
			input = { enabled = false },
			select = { enabled = true },
		},
	},
	-- Context-aware indentation lines
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		opts = {
			show_current_context = true,
			show_current_context_start = false,
			use_treesitter = true,
			use_treesitter_scope = false,
			max_indent_increase = 1,
			show_trailing_blankline_indent = false,
			blankline_char_priority = 10,
			integrations = {
				neotree = {
					enabled = true,
					show_root = false,
					transparent_panel = false,
				},
			},
		},
	},
	-- Notification handler
	{
		"rcarriga/nvim-notify",
		lazy = false,
		opts = {
			top_down = true,
			max_width = 100,
		},
	},
	-- Keymaps cheat sheet and tooltips
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 150
			require("which-key").setup {
				window = {
					border = "rounded",
					position = "bottom",
					margin = { 10, 10, 2, 10 },
				},
			}
		end,
	},
	-- Highlight todo/fixme/etc.
	{
		"folke/todo-comments.nvim",
		enabled = false,
		event = "VeryLazy",
		config = true,
	},
	{
		"echasnovski/mini.hipatterns",
		event = "VeryLazy",
		config = function()
			local hipatterns = require("mini.hipatterns")
			hipatterns.setup {
				highlighters = {
					fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
					hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
					todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
					note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

					palette_base = { pattern = "%f[%w]()palette[.]base()%f[%W]", group = "PaletteBase" },
					palette_mauve = { pattern = "%f[%w]()palette[.]mauve()%f[%W]", group = "PaletteMauve" },
					palette_red = { pattern = "%f[%w]()palette[.]red()%f[%W]", group = "PaletteRed" },
					palette_yellow = { pattern = "%f[%w]()palette[.]yellow()%f[%W]", group = "PaletteYellow" },
					palette_peach = { pattern = "%f[%w]()palette[.]peach()%f[%W]", group = "PalettePeach" },
					palette_teal = { pattern = "%f[%w]()palette[.]teal()%f[%W]", group = "PaletteTeal" },
					palette_green = { pattern = "%f[%w]()palette[.]green()%f[%W]", group = "PaletteGreen" },
					palette_sky = { pattern = "%f[%w]()palette[.]sky()%f[%W]", group = "PaletteSky" },
					palette_pink = { pattern = "%f[%w]()palette[.]pink()%f[%W]", group = "PalettePink" },
					palette_lavender = { pattern = "%f[%w]()palette[.]lavender()%f[%W]", group = "PaletteLavender" },
					palette_blue = { pattern = "%f[%w]()palette[.]blue()%f[%W]", group = "PaletteBlue" },
					palette_text = { pattern = "%f[%w]()palette[.]text()%f[%W]", group = "PaletteText" },
					palette_sapphire = { pattern = "%f[%w]()palette[.]sapphire()%f[%W]", group = "PaletteSapphire" },
					palette_surface0 = { pattern = "%f[%w]()palette[.]surface0()%f[%W]", group = "PaletteSurface0" },
					palette_surface1 = { pattern = "%f[%w]()palette[.]surface1()%f[%W]", group = "PaletteSurface1" },
					palette_surface2 = { pattern = "%f[%w]()palette[.]surface2()%f[%W]", group = "PaletteSurface2" },
					palette_overlay1 = { pattern = "%f[%w]()palette[.]overlay1()%f[%W]", group = "PaletteOverlay1" },

					hex_color = hipatterns.gen_highlighter.hex_color(),
				},
			}
		end,
	},
	-- Modern folds
	{
		"kevinhwang91/nvim-ufo",
		event = "VeryLazy",
		dependencies = "kevinhwang91/promise-async",
		config = function()
			vim.o.foldlevel = 99
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true

			local handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = ("  %d "):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth + 4
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(
					newVirtText,
					{ " " .. ("┄"):rep(targetWidth - curWidth - sufWidth - 2) .. "", "UfoVirtTextPill" }
				)
				table.insert(newVirtText, { suffix, "UfoVirtText" })
				table.insert(newVirtText, { "", "UfoVirtTextPill" })
				return newVirtText
			end

			require("ufo").setup {
				fold_virt_text_handler = handler,
				provider_selector = function()
					return { "treesitter", "indent" }
				end,
			}
		end,
	},
	{
		dir = "~/github/cuicui",
		name = "charcolumn",
		enabled = false,
		event = "VeryLazy",
		config = function()
			require("charcolumn").setup {
				columns = {
					{ col = 100, hl = "CuicuiCharColumn1" },
					{ col = 120, hl = "CuicuiCharColumn2", hl_overflow = "Error" },
				},
			}
		end,
	},
}
