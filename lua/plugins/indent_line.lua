return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    setup = function()
      local ibl = require 'ibl'
      ibl.setup {
        scope = {
          show_end = false,
          show_start = false,
        },
      }
    end,
    opts = {},
  },
}
