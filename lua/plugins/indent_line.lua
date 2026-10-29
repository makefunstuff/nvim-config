return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = { char = '│', tab_char = '│' },
      scope = {
        show_end = false,
        show_start = false,
      },
    },
    config = function(_, opts)
      require('ibl').setup(opts)
    end,
  },
}
