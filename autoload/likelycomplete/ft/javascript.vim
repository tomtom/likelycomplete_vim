" @Author:      Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Revision:    3


if !exists('g:likelycomplete#ft#javascript#options')
    " Some custom options for javascript (see 
    " |g:likelycomplete#options|).
    " :read: let g:likelycomplete#ft#javascript#options = {...}   "{{{2
    let g:likelycomplete#ft#javascript#options = {
                \ 'exclude_lines_rx': '^\s*//',
                \ 'cms_rx': '\(/*%s*/\|\^\s\*//%s\)',
                \ }
endif


function! likelycomplete#ft#javascript#Init() "{{{3
endf

