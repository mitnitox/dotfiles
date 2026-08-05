return {
	"monkoose/neocodeium",
	event = "VeryLazy",
	config = function()
		local neocodeium = require("neocodeium")
		neocodeium.setup()
		local neocodeium = require("neocodeium")

		-- Usando Control + a para aceptar todo (o la combinación que prefieras)
		vim.keymap.set("i", "<C-a>", neocodeium.accept)
		vim.keymap.set("i", "<C-w>", neocodeium.accept_word)
		vim.keymap.set("i", "<C-l>", neocodeium.accept_line)
		vim.keymap.set("i", "<C-n>", neocodeium.cycle_or_complete)
		vim.keymap.set("i", "<C-p>", function()
			neocodeium.cycle_or_complete(-1)
		end)
		vim.keymap.set("i", "<C-x>", neocodeium.clear)
	end,
}
