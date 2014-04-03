" @Author:      Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Revision:    2


if !exists('g:likelycomplete#ft#vim#options')
    " Some custom options for the vim filetype (see 
    " |g:likelycomplete#options|).
    " Anything following a single or double quote is removed. This will 
    " make sure that all strings an comments are removed -- at the cost 
    " of also removing eligible identifiers following a string.
    " :read: let g:likelycomplete#ft#vim#options = {...}   "{{{2
    let g:likelycomplete#ft#vim#options = {
                \ 'exclude_lines_rx': '^\s*"',
                \ 'strip_strings': 1,
                \ 'strip_multiline_strings': 0,
                \ 'strip_comments': 1,
                \ }
endif


function! likelycomplete#ft#vim#Init() "{{{3
endf

