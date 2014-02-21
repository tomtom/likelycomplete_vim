" @Author:      Tom Link (micathom AT gmail com?subject=[vim])
" @Website:     http://www.vim.org/account/profile.php?user_id=4037
" @GIT:         http://github.com/tomtom/likelycomplete_vim
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Revision:    42
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
    " Filetypes that are always enabled.
    "
    " LikelyComplete has to be explicitly enabled once per filetype. 
    " Either by using this variable or by calling |:Likelycomplete|.
    "
    " Once enabled, it isn't sufficient to remove the filetype name from 
    " this variable. You have to call |likelycomplete#RemoveFiletype()| 
    " to fully remove support for this filetype.
    let g:likelycomplete_filetypes = []   "{{{2
endif


if !exists('g:likelycomplete_data_cfile')
    let g:likelycomplete_data_cfile = tlib#persistent#Filename('likelycomplete', 'data', 1)   "{{{2
endif


let g:likelycomplete_data = tlib#persistent#Get(g:likelycomplete_data_cfile, {'version': 1, 'ft': {}, 'ft_options': {}})   "{{{2


augroup LikelyComplete
    autocmd!
augroup END


function! LikelycompleteSetupFiletype(filetype) "{{{3
    exec 'autocmd! LikelyComplete FileType' a:filetype
    exec 'autocmd LikelyComplete FileType' a:filetype 'call likelycomplete#SetupBuffer('. string(a:filetype) .', expand("<abuf>"))'
endf


for s:ft in keys(g:likelycomplete_data.ft) + g:likelycomplete_filetypes
    call LikelycompleteSetupFiletype(s:ft)
endfor
for s:ft in g:likelycomplete_filetypes
    if !has_key(g:likelycomplete_data.ft, s:ft)
        call LikelycompleteSetupFiletype(s:ft)
    endif
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
