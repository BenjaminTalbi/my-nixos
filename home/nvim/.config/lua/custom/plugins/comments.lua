return {
  -- NOTE: Use `opts = {}` to force a plugin to be loaded.
  -- NOTE: name = 'comment.nvim' is from NixCats which I don't use anymore
  -- for when we pre-downloaded the package with nix
  { 'numToStr/Comment.nvim', name = 'comment.nvim', opts = {} },

  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = true,
      -- TODO: = { icon = "´Çî ", color = "info" },
      -- HACK: = { icon = "´ÆÉ ", color = "warning" },
      -- WARN: = { icon = "´ü▒ ", color = "warning", alt = { "WARNING", "XXX" } },
      -- PERF: = { icon = "´É║ ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      -- NOTE: = { icon = "¯®┤ ", color = "hint", alt = { "INFO" } },
      -- TEST: = { icon = "ÔÅ▓ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      colors = {
        error = { 'DiagnosticError', 'ErrorMsg', '#DC2626' },
        warning = { 'DiagnosticWarn', 'WarningMsg', '#FBBF24' },
        info = { 'DiagnosticInfo', '#F4F1DE' },
        hint = { 'DiagnosticHint', '#10B981' },
        default = { 'Identifier', '#7C3AED' },
        test = { 'Identifier', '#FF00FF' },
      },
    },
  },


}
