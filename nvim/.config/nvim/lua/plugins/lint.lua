-- lua/plugins/lint.lua
return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		-- Forzamos que ts-standard use el ejecutable de Mason o del PATH
		lint.linters_by_ft = {
			javascript = { "standardjs" },
			javascriptreact = { "standardjs" },
			typescript = { "ts-standard" },
			typescriptreact = { "ts-standard" },
		}

		-- Crear autocomando para ejecutar el linter
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				-- Intenta ejecutar solo los linters asociados a este tipo de archivo
				lint.try_lint()
			end,
		})
	end,
}
