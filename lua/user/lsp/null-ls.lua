local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/code_actions
local code_actions = null_ls.builtins.code_actions
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/completion
local completion = null_ls.builtins.completion

-- eslint_d has_eslint_config
local has_eslint_config = function(u)
  return u.root_has_file('.eslintrc')
    or u.root_has_file('.eslintrc.json')
    or u.root_has_file('.eslintrc.js')
    or u.root_has_file('.eslintrc.cjs')
    or u.root_has_file('.eslintrc.yaml')
    or u.root_has_file('.eslintrc.yml')
    or u.root_has_file('package.json')
end

null_ls.setup({
	debug = false,
	sources = {
      -- prettier
	  formatting.prettier.with({
        env = {
          PRETTIERD_LOCAL_PRETTIER_ONLY = 1,
        },
        extra_args = { "--single-quote", "--jsx-single-quote" },
      }),

      -- eslint_d
      code_actions.eslint_d.with({
        condition = has_eslint_config,
        prefer_local = "node_modules/.bin",
      }),
      diagnostics.eslint_d.with({
        condition = has_eslint_config,
        prefer_local = "node_modules/.bin",
      }),
      formatting.eslint_d.with({
        condition = has_eslint_config,
        prefer_local = "node_modules/.bin",
      }),

      -- formatting
      formatting.black.with({ extra_args = { "--fast" } }),

      -- completion
      -- completion.spell,

      -- code_actions
      code_actions.eslint_d,
      code_actions.gitsigns,

      -- diagnostics
      diagnostics.eslint_d,
      diagnostics.markdownlint,
	},
})
