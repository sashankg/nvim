local function nmap(keys, picker, desc)
	vim.keymap.set('n', keys, picker, { desc = desc })
end

return {
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	dependencies = { 'nvim-lua/plenary.nvim' },
	opts =  {
		defaults = {
			mappings = {
				i = {
					["<C-J>"] = 'move_selection_next',
					["<C-K>"] = 'move_selection_previous',
				},
			},
		},
	},
	init = function (telescope)
		local builtin = require('telescope.builtin')

		-- Enable telescope fzf native, if installed
		pcall(telescope.load_extension, 'fzf')

		-- See `:help telescope.builtin`
		nmap('<leader>?', builtin.keymaps, 'Find keymap')
		nmap('<leader><space>', builtin.find_files, 'Find files')
		nmap('<leader>/', function()
			-- You can pass additional configuration to telescope to change theme, layout, etc.
			builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
				winblend = 10,
				previewer = false,
			})
			end, 'Fuzzily search in current buffer')

		nmap('<leader>gf', builtin.git_files, 'Search [G]it [F]iles')
		nmap('<leader>gs', builtin.git_stash, 'Search [G]it [S]tashes')
		nmap('<leader>gb', builtin.git_branches, 'Search [G]it [B]ranches')
		nmap('<leader>gc', function()
			builtin.git_commits {
				git_command = {"git","log","--pretty=oneline","--abbrev-commit", "-1000", "--","."},
			}
			end, 'Search [G]it [C]ommits')
		nmap('<leader>bc', builtin.git_bcommits, 'Search [Buffer] [Commits]')

		nmap('<leader>sh', builtin.help_tags, '[S]earch [H]elp')
		nmap('<leader>sw', builtin.grep_string, '[S]earch current [W]ord')
		nmap('<leader>sg', builtin.live_grep, '[S]earch by [G]rep')
		nmap('<leader>sd', builtin.diagnostics, '[S]earch [D]iagnostics')
		nmap('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

		nmap('gi', builtin.lsp_implementations, '[G]o to [I]mplementations')
		nmap('gd', builtin.lsp_definitions, '[G]o to [D]efinitions')
		nmap('go', builtin.lsp_type_definitions, 'Go to Type Definitions')
		nmap('gr', builtin.lsp_references, '[G]o to [R]eferences')
	end
}
