" Based On
" https://github.com/BenBergman/ir_black-custom
" https://github.com/twerth/ir_black/tree/master

colors
runtime colors/ir_black.vim
let g:colors_name = "main"

hi LineNr         guifg=#7D7D7D gui=BOLD
hi StatusLine     guifg=white   gui=BOLD
hi StatusLineNc   guifg=white   gui=BOLD
hi Cursor         guifg=black   guibg=white
hi CursorLine     guifg=NONE    guibg=#202020
hi CursorLineSign guifg=NONE    guibg=#202020
hi CursorLineNr   guifg=#FFFFB6 guibg=#202020
hi SignColumn     guifg=NONE    guibg=NONE

hi Error            guifg=#FF6C60 guibg=NONE
hi ErrorMsg         guifg=#FF6C60 guibg=NONE
hi WarningMsg       guifg=#FFFFB6 guibg=NONE
hi LongLineWarning  guifg=#FFFFB6 guibg=NONE

hi link MiniStatuslineModeOther   StatusLine
hi link MiniStatusLineModeNormal  StatusLine
hi link MiniStatusLineModeInsert  StatusLine
hi link MiniStatusLineModeVisual  StatusLine
hi link MiniStatusLineModeCommand StatusLine
hi link MiniStatusLineModeReplace StatusLine

lua<<EOF
vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    vim.opt.termguicolors = true
    vim.opt.winborder = 'rounded'
    -- vim.opt.guicursor = 'n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor'
    local highlights = {
      'Pmenu',
      'LineNr',
      'Folded',
      'FoldColumn',
      'NonText',
      'VertSplit',
      'SpecialKey',
      'EndOfBuffer',
      'TablineFill',
      'SignColumn',
      'ColorColumn',

      'Normal',
      'NormalFloat',

      -- 'StatusLine',
      -- 'StatusLineNc',
      --
      -- 'CursorLine',
      -- 'CursorLineNr',
      -- 'CursorLineSign',
      -- 'CursorColum',
    }
    for _, name in pairs(highlights) do
      vim.cmd.highlight(name .. ' guibg=none ctermbg=none')
    end
    -- local hl = vim.api.nvim_get_hl(0, { name = 'CursorLine' })
    -- vim.api.nvim_set_hl(0, 'PmenuSel', { bg = hl.bg })
  end,
})
EOF
