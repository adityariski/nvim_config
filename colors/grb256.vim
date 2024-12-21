" Based on
runtime colors/ir_black.vim
let g:colors_name = "grb256"

hi pythonSpaceError ctermbg=red guibg=red
hi Comment ctermfg=lightgrey
hi StatusLine ctermbg=darkgrey ctermfg=white
hi StatusLineNC ctermbg=black ctermfg=lightgrey
hi VertSplit ctermbg=black ctermfg=lightgrey
hi LineNr guifg=#7d7d7d
hi CursorLine       guifg=NONE        guibg=#202020     gui=NONE      ctermfg=NONE       ctermbg=234    cterm=NONE
hi CursorLineNR     guifg=#FFFF98     guibg=#202020
hi Function         guifg=#FFD2A7     guibg=NONE        gui=NONE      ctermfg=yellow     ctermbg=NONE   cterm=NONE
hi Visual           guifg=NONE        guibg=#262D51     gui=NONE      ctermfg=NONE       ctermbg=236    cterm=NONE
hi Error            guifg=NONE        guibg=NONE        gui=undercurl ctermfg=16         ctermbg=red    cterm=NONE     guisp=#FF6C60 " undercurl color
hi ErrorMsg         guifg=white       guibg=#FF6C60     gui=BOLD      ctermfg=16         ctermbg=red    cterm=NONE
hi WarningMsg       guifg=white       guibg=#FF6C60     gui=BOLD      ctermfg=16         ctermbg=red    cterm=NONE
hi SpellBad         guifg=white       guibg=#FF6C60     gui=BOLD      ctermfg=16         ctermbg=160    cterm=NONE

" ir_black doesn't highlight operators for some reason
hi Operator         guifg=#6699CC     guibg=NONE        gui=NONE      ctermfg=lightblue  ctermbg=NONE   cterm=NONE

highlight DiffAdd term=reverse cterm=bold ctermbg=lightgreen ctermfg=16
highlight DiffChange term=reverse cterm=bold ctermbg=lightblue ctermfg=16
highlight DiffText term=reverse cterm=bold ctermbg=lightgray ctermfg=16
highlight DiffDelete term=reverse cterm=bold ctermbg=lightred ctermfg=16
highlight PmenuSel ctermfg=16 ctermbg=156

hi link MiniStatusLineModeNormal StatusLine
hi link MiniStatusLineModeInsert StatusLine
hi link MiniStatusLineModeVisual StatusLine
hi link MiniStatusLineModeCommand StatusLine
hi link MiniStatusLineModeReplace StatusLine
hi link MiniStatuslineModeOther StatusLine

" Special for XML
" hi link xmlTag          Keyword
" hi link xmlTagName      Conditional
" hi link xmlEndTag       Identifier

" Special for HTML
" hi link htmlTag         Keyword
" hi link htmlTagName     Conditional
" hi link htmlEndTag      Identifier

" Special for Javascript
" hi link javaScriptNumber      Number

" Special for CSharp
" hi  link csXmlTag             Keyword
