return {
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall" },
		opts = {},
	},

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

			local mason_lspconfig = require("mason-lspconfig")
			local servers = { "lua_ls", "ts_ls", "gopls" }

			mason_lspconfig.setup({
				ensure_installed = servers,
			})

			-- Agregar dentro de config = function(), ANTES del for loop
			vim.diagnostic.config({
				virtual_text = true, -- ← el texto en la línea (lo que pediste)
				signs = true, -- íconos en el gutter
				underline = true, -- subrayado rojo en la línea
				severity_sort = true,
				update_in_insert = false,
				float = { border = "rounded", source = "always" },
			})

			-- Configuración global para TODOS los servidores nativos
			-- Esto le dice a Neovim: "Cuando actives cualquier LSP, mapea estas teclas en ese buffer"
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local opts = { buffer = args.buf, silent = true }

					-- Forzamos el mapeo local con prioridad máxima
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				end,
			})
			for _, server in ipairs(servers) do
				if server == "lua_ls" then
					vim.lsp.config("lua_ls", {
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim" },
								},
								workspace = {
									checkThirdParty = false,
								},
							},
						},
					})
				else
					vim.lsp.config(server, {})
				end

				vim.lsp.enable(server)
			end
		end,
	},
}
