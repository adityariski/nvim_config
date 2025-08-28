" Based On
" https://github.com/BenBergman/ir_black-custom
" https://github.com/twerth/ir_black/tree/master
colors
runtime colors/ir_black.vim
let g:colors_name = "main"

hi LineNr       guifg=#7D7D7D gui=BOLD
hi StatusLine   guifg=white   gui=BOLD
hi CursorLine   guifg=NONE    guibg=#202020
hi CursorLineNR guifg=#FFFFB6 guibg=#202020
hi StatusLineNC guifg=white
hi Pmenu        guibg=NONE
hi PmenuSel     guifg=white   guibg=#202020

hi link MiniStatuslineModeOther   StatusLine
hi link MiniStatusLineModeNormal  StatusLine
hi link MiniStatusLineModeInsert  StatusLine
hi link MiniStatusLineModeVisual  StatusLine
hi link MiniStatusLineModeCommand StatusLine
hi link MiniStatusLineModeReplace StatusLine
