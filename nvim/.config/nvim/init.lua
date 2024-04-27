-- Ezra's Neovim One Pager
local o = vim.o
local opt = vim.opt -- for tables
local g = vim.g
local map = vim.keymap.set

-- -----------
-- | Options |
-- -----------
o.autoindent = true
o.breakindent = true
o.cindent = true
o.clipboard = "unnamedplus"
o.colorcolumn = "120"
o.completeopt = "menuone,noselect"
o.expandtab = true
opt.fillchars = { eob = " " }
o.hidden = false
o.ignorecase = true
o.infercase = true
o.laststatus = 3
o.linebreak = true
o.mouse = "a"
o.number = true
o.pumheight = 10
o.relativenumber = true
o.scrolloff = 20
o.shiftwidth = 2
o.showmode = false
-- o.showtabline = 2
o.sidescrolloff = 8
o.signcolumn = "yes"
o.smartcase = true
o.smartindent = true
o.splitbelow = true
o.splitright = true
o.swapfile = false
o.tabstop = 2
o.termguicolors = true
o.textwidth = 100
o.timeout = true
o.timeoutlen = 300
o.title = true
o.undofile = true
o.virtualedit = "block"
o.winbar = " "
o.wrap = true
o.writebackup = false

-- Gruvbox colorscheme options
g.gruvbox_sign_column = "bg0"
g.gruvbox_transparent_bg = "1"

-- Disable python & perl providers
vim.cmd([[ let g:loaded_python3_provider = 0]])
vim.cmd([[ let g:loaded_perl_provider = 0]])

-- Netrw options
g.netrw_banner = 0
g.netrw_keepdir = 0
g.netrw_menu = 0
g.netrw_winsize = 30

-- ------------
-- | Mappings |
-- ------------
map("", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "

-- Standard operations
map("i", "jk", "<ESC>", { silent = true, desc = "Exit insert mode" })
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>q", "<cmd>confirm q<cr>", { silent = true, desc = "Quit" })
map("n", "<leader>c", "<cmd>close<cr>", { silent = true, desc = "Close window" })

-- Move lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line dbdown (normal)" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up (normal)" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down (insert)" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up (insert)" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move line down (visual)" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move line up (visual)" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { silent = true, desc = "Left window navigation" })
map("n", "<C-j>", "<C-w>j", { silent = true, desc = "Down window navigation" })
map("n", "<c-l>", "<c-w>l", { silent = true, desc = "Right window navigation" })
map("n", "<C-k>", "<C-w>k", { silent = true, desc = "Up window navigation" })

-- Telescope
map("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find for word under cursor" })
map("n", "<leader>fC", "<cmd>Telescope commands<cr>", { desc = "Commands" })
map("n", "<leader>fd", "<cmd>Telescope diagnostics severity_bound=ERROR<cr>", { desc = "Find diagnostics" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fF", "<cmd>Telescope find_files hidden=true<cr>", { desc = "Find all files" })
map("n", "<leader>fg", "<cmd>Telescope git_files<cr>", { desc = "Find git files" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help" })
map("n", "<leader>fH", "<cmd>Telescope highlights<cr>", { desc = "Highlight groups" })
map("n", "<leader>fi", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Find in buffer" })
map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })
map("n", "<leader>fM", "<cmd>Telescope man_pages<cr>", { desc = "Man Pages" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { desc = "Find word in workspace" })

-- Git
map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Git commits" })
map("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git status" })
map("n", "<leader>gf", "<cmd>G<cr>", { desc = "Git fugitive" })

-- ----------------
-- | Autocommands |
-- ----------------
-- Disable automatic comment leader insertion
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	command = "set formatoptions-=cro",
})

-- Transparent Background
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	command = "highlight Normal guibg=NONE ctermbg=NONE",
})

-- -----------
-- | Plugins |
-- -----------
-- Plugin manager: Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Colorscheme: Catppuccin
	{
		"catppuccin/nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				background = {
					dark = "mocha",
				},
				no_italic = false,
			})
			vim.cmd([[colorscheme catppuccin]])
		end,
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"BurntSushi/ripgrep",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				enabled = vim.fn.executable("make") == 1,
				build = "make",
			},
		},
		config = function()
			local actions = require("telescope.actions")
			local mappings = {
				i = {
					["<C-n>"] = actions.cycle_history_next,
					["<C-p>"] = actions.cycle_history_prev,
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
				},
				n = { ["q"] = actions.close },
			}
			require("telescope").setup({
				defaults = {
					path_display = { "truncate" },
					sorting_strategy = "ascending",
					file_ignore_patterns = { ".git/", "node_modules" },
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.55,
						},
						vertical = {
							mirror = false,
						},
						width = 0.87,
						height = 0.80,
						preview_cutoff = 120,
					},
					mappings = mappings,
				},
			})
			require("telescope").load_extension("fzf")
		end,
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufRead", "BufNewFile" },
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })()
		end,
		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({
				ensure_installed = {
					"lua",
					"typescript",
					"html",
				},
				auto_install = false,
				sync_install = false,
				highlight = { enable = true },
				incremental_selection = { enable = true },
				indent = { enable = true, disable = { "html", "css" } },
			})
		end,
	},

	-- Auto-pairs
	{
		"echasnovski/mini.nvim",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("mini.pairs").setup()
		end,
	},

	-- Mason
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{
				"williamboman/mason-lspconfig.nvim",
				lazy = true,
			},
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				automatic_installation = true,
			})
		end,
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		config = function()
			-- Servers
			local servers = {
				clangd = {},
				lua_ls = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},

				html = {},
				emmet_ls = {},
				tsserver = {},
			}

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			-- LSP Mappings
			local on_attach = function(_, bufnr)
				local map = function(keys, func, desc)
					if desc then
						desc = "LSP: " .. desc
					end
					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
				end
				map("gd", vim.lsp.buf.definition, "Goto definition")
				map("gD", vim.lsp.buf.declaration, "Goto declaration")
				map("gr", vim.lsp.buf.references, "Goto references")
				map("gI", vim.lsp.buf.implementation, "Goto implementation")
				map("gT", vim.lsp.buf.type_definition, "Type definition")
				map("K", vim.lsp.buf.hover, "Hover documentation")
				map("<leader>lR", require("telescope.builtin").lsp_references, "Search references")
				map("<leader>la", vim.lsp.buf.code_action, "Code action")
				map("<leader>ld", vim.diagnostic.setloclist, "List diagnostics")
				map("<leader>lf", vim.lsp.buf.format, "Format buffer")
				map("<leader>lh", vim.lsp.buf.signature_help, "Signature help")
				map("<leader>li", "<cmd>LspInfo<cr>", "LSP information")
				map("<leader>lr", vim.lsp.buf.rename, "Rename current symbol")
				map("<leader>ls", require("telescope.builtin").lsp_document_symbols, "Search document symbols")
				map("<leader>lw", require("telescope.builtin").lsp_workspace_symbols, "Search workspace symbols")
				map("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
				map("]d", vim.diagnostic.goto_next, "Next diagnostic")
			end

			local mason_lspconfig = require("mason-lspconfig")
			mason_lspconfig.setup({
				ensure_installed = vim.tbl_keys(servers),
			})

			mason_lspconfig.setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = servers[server_name],
					})
				end,
			})

			local config = {
				virtual_text = true,
				severity_sort = true,
			}
			vim.diagnostic.config(config)
		end, -- config end
	},

	-- Completion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			{
				"L3MON4D3/LuaSnip",
				event = "InsertEnter",
				dependencies = {
					"rafamadriz/friendly-snippets",
				},
				build = "make install_jsregexp",
			},
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load()
			local select_opts = { behavior = cmp.SelectBehavior.Select }

			cmp.setup({
				completion = {
					completeopt = "menu,menuone",
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp", priority = 1000 },
					{ name = "luasnip", keyword_length = 3 },
					{ name = "nvim_lsp_signature_help" },
					{ name = "path" },
				}, {
					{ name = "buffer" },
				}),
				mapping = {
					["<Up>"] = cmp.mapping.select_prev_item(select_opts),
					["<Down>"] = cmp.mapping.select_next_item(select_opts),

					["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
					["<C-n>"] = cmp.mapping.select_next_item(select_opts),

					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),

					["<C-e>"] = cmp.mapping.abort(),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<CR>"] = cmp.mapping.confirm({ select = false }),

					["<C-f>"] = cmp.mapping(function(fallback)
						if luasnip.jumpable(1) then
							luasnip.jump(1)
						else
							fallback()
						end
					end, { "i", "s" }),

					["<C-b>"] = cmp.mapping(function(fallback)
						if luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),

					["<Tab>"] = cmp.mapping(function(fallback)
						local col = vim.fn.col(".") - 1

						if cmp.visible() then
							cmp.select_next_item(select_opts)
						elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
							fallback()
						else
							cmp.complete()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item(select_opts)
						else
							fallback()
						end
					end, { "i", "s" }),
				},
				enabled = function()
					-- disable completion in comments
					local context = require("cmp.config.context")
					-- keep command mode completion enabled when cursor is in a comment
					if vim.api.nvim_get_mode().mode == "c" then
						return true
					else
						return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
					end
				end,
			})
		end,
	},

	-- Comments
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		config = function()
			require("Comment").setup()
		end,
	},

	-- Git signs
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "▎" },
					change = { text = "▎" },
					delete = { text = "" },
					topdelete = { text = "" },
					changedelete = { text = "▎" },
					untracked = { text = "▎" },
				},
				on_attach = function(buffer)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, desc)
						vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
					end

          -- stylua: ignore start
          map("n", "]h", gs.next_hunk, "Next Hunk")
          map("n", "[h", gs.prev_hunk, "Prev Hunk")
          map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
          map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
          map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
          map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
          map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
          map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
          map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
          map("n", "<leader>ghd", gs.diffthis, "Diff This")
          map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
				end,
			})
		end,
	},

	-- Fugitive
	{ "tpope/vim-fugitive", event = "VeryLazy" },

	-- Closetag (html)
	{ "alvan/vim-closetag", event = "BufRead" },

	-- Lualine
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
		event = "VeryLazy",
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					component_separators = "",
					section_separators = "",
				},
				sections = {
					lualine_x = { "" },
					lualine_y = {
						{ "filetype", icon_only = false, separator = "", padding = { left = 1, right = 0 } },
						"progress",
					},
				},
			})
		end,
	},

	-- Vim Surround
	{ "tpope/vim-surround", event = "VeryLazy" },

	-- Formatter (Conform)
	{
		"stevearc/conform.nvim",
		lazy = false,
		keys = {
			{
				"<leader>fe",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters_by_ft = {
				javascript = { { "prettierd", "prettier" } },
				lua = { "stylua" },
				markdown = { "prettierd" },
			},
		},
	},

	-- Linter
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("lint").linters_by_ft = {
				-- markdown = { "vale" },
				-- javascript = { "eslint_d" },
			}
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				callback = function()
					-- try_lint without arguments runs the linters defined in `linters_by_ft`
					-- for the current filetype
					require("lint").try_lint()
				end,
			})
		end,
	},

	-- Indent blankline
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		version = "2.20.8",
		opts = {
			char = "│",
			filetype_exclude = { "help", "lazy", "mason", "json", "jsonc" },
			show_trailing_blankline_indent = false,
			show_current_context = false,
		},
	},
}, { defaults = { lazy = true } })
