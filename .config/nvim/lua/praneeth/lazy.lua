local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"nvim-lua/plenary.nvim",
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>pf", function()
				builtin.find_files({
					hidden = true,
				})
			end)
			vim.keymap.set("n", "<C-p>", builtin.git_files)
			vim.keymap.set("n", "<leader>ps", function()
				builtin.grep_string({
					search = vim.fn.input("Grep > "),
				})
			end)
		end,
	},

	{
		"saghen/blink.cmp",
		dependencies = {
			"saghen/blink.lib",
			"rafamadriz/friendly-snippets",
		},
		build = function()
			require("blink.cmp").build():pwait()
		end,
		opts = {
			keymap = {
				preset = "default",
			},

			completion = {
				documentation = {
					auto_show = true,
				},
			},

			sources = {
				default = {
					"lsp",
					"path",
					"snippets",
					"buffer",
				},
			},

			fuzzy = {
				implementation = "prefer_rust_with_warning",
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
	},

	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				json = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				go = { "gofmt" },
				rust = { "rustfmt" },
				c = { "clang_format" },
				cpp = { "clang_format" },
			},

			format_on_save = {
				timeout_ms = 1000,
				lsp_format = "fallback",
			},
		},

		config = function(_, opts)
			require("conform").setup(opts)

			vim.keymap.set({ "n", "v" }, "<leader>f", function()
				require("conform").format({
					async = true,
					lsp_format = "fallback",
				})
			end)
		end,
	},

	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				variant = "main",
				dark_variant = "main",
			})

			vim.cmd("colorscheme rose-pine")
		end,
	},

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup()

			vim.keymap.set("n", "<leader>a", function()
				harpoon:list():add()
			end)

			vim.keymap.set("n", "<C-e>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)

			vim.keymap.set("n", "<C-h>", function()
				harpoon:list():select(1)
			end)

			vim.keymap.set("n", "<C-t>", function()
				harpoon:list():select(2)
			end)

			vim.keymap.set("n", "<C-n>", function()
				harpoon:list():select(3)
			end)

			vim.keymap.set("n", "<C-s>", function()
				harpoon:list():select(4)
			end)
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",

		config = function()
			local ts = require("nvim-treesitter")

			ts.install({
				"lua",
				"python",
				"javascript",
				"typescript",
				"tsx",
				"go",
				"rust",
				"c",
				"cpp",
				"bash",
				"json",
				"html",
				"css",
				"markdown",
				"markdown_inline",
				"vim",
				"vimdoc",
				"query",
			})

			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"lua",
					"python",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"go",
					"rust",
					"c",
					"cpp",
					"bash",
					"json",
					"html",
					"css",
					"markdown",
				},

				callback = function()
					vim.treesitter.start()
				end,
			})
		end,
	},

	{
		"tpope/vim-fugitive",
	},
})
