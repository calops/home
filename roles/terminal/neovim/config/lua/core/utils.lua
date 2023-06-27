local module = {}

local function map_with_mode(mode)
	return function(mappings, opts_in)
		local opts = vim.tbl_extend("force", opts_in or {}, { mode = mode })
		return require("which-key").register(mappings, opts)
	end
end

module.nmap = map_with_mode("n")
module.imap = map_with_mode("i")
module.xmap = map_with_mode("x")
module.vmap = map_with_mode("v")
module.omap = map_with_mode("o")
module.tmap = map_with_mode("t")

function module.reverse_table(table)
	for i = 1, math.floor(#table / 2), 1 do
		table[i], table[#table - i + 1] = table[#table - i + 1], table[i]
	end
	return table
end

return module
