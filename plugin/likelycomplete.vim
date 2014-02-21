" @Author:      Tom Link (micathom AT gmail com?subject=[vim])
" @Website:     http://www.vim.org/account/profile.php?user_id=4037
" @GIT:         http://github.com/tomtom/likelycomplete_vim
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Revision:    45
" GetLatestVimScripts: 0 0 :AutoInstall: likelycomplete.vim

if !exists('g:loaded_tlib') || g:loaded_tlib < 107
    runtime plugin/02tlib.vim
    if !exists('g:loaded_tlib') || g:loaded_tlib < 107
        echoerr 'tlib >= 1.07 is required'
        finish
    endif
endif
if &cp || exists("loaded_likelycomplete")
    finish
endif
let loaded_likelycomplete = 1

let s:save_cpo = &cpo
set cpo&vim


if !exists('g:likelycomplete_filetypes')
    " A list of filetypes for which LikelyComplete is automatically 
    " enabled.
    "
    " If you want to permanently disable LikelyComplete for a filetype, 
    " it isn't sufficient to remove the filetype name from this 
    " variable. You should also call |likelycomplete#RemoveFiletype()| 
    " to fully remove cached information for this filetype.
    let g:likelycomplete_filetypes = []   "{{{2
endif


augroup LikelyComplete
    autocmd!
augroup END


function! LikelycompleteSetupFiletype(filetype) "{{{3
    exec 'autocmd! LikelyComplete FileType' a:filetype
    exec 'autocmd LikelyComplete FileType' a:filetype 'call likelycomplete#SetupBuffer('. string(a:filetype) .', expand("<abuf>"))'
endf


for s:ft in g:likelycomplete_filetypes
    call LikelycompleteSetupFiletype(s:ft)
endfor
unlet! s:ft


" :display: :Likelycomplete [NAME=VALUE ...]
" The following arguments are supported:
"   maxsize ......... filetype-specific value for 
"                     |g:likelycomplete#maxsize|
"   keyword_rx ...... Alternative |regexp| for |\k|
"   strip_comments .. Remove whole-line comments (not supported for all filetypes)
"   strip_strings ... Remove strings
"   strip_numbers ... Remove numbers
"   strip_rx ........ Remove matching text from lines
"   exclude_lines_rx .. Exclude lines matching this |regexp|
command! -nargs=? Likelycomplete call likelycomplete#SetupFiletype(&filetype, likelycomplete#String2Args(<q-args>))


let &cpo = s:save_cpo
unlet s:save_cpo
