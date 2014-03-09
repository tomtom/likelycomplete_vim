" @Author:      Tom Link (micathom AT gmail com?subject=[vim])
" @Website:     http://www.vim.org/account/profile.php?user_id=4037
" @GIT:         http://github.com/tomtom/likelycomplete_vim
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Revision:    74
" GetLatestVimScripts: 0 0 :AutoInstall: likelycomplete.vim

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
    " to fully remove any cached information for this filetype.
    "
    "                                                   *b:likelycomplete_filetype*
    " If the variable b:likelycomplete_filetype is defined on FileType 
    " events, its value is used instead of 'filetype'. LikelyComplete 
    " is automatically enabled for all buffers where the 
    " b:likelycomplete_filetype is defined. This variable can be used to 
    " generate project-specific word lists.
    let g:likelycomplete_filetypes = []   "{{{2
endif


augroup LikelyComplete
    autocmd!
    autocmd! LikelyComplete Filetype * if exists('b:likelycomplete_filetype') | call likelycomplete#SetupBuffer(b:likelycomplete_filetype, expand("<abuf>")) | endif
augroup END


function! LikelycompleteSetupFiletype(filetype) "{{{3
    exec 'autocmd! LikelyComplete FileType' a:filetype
    exec 'autocmd LikelyComplete FileType' a:filetype 'if exists("b:likelycomplete_filetype") | call likelycomplete#SetupBuffer('. string(a:filetype) .', expand("<abuf>")) | endif'
endf


for s:ft in g:likelycomplete_filetypes
    call LikelycompleteSetupFiletype(s:ft)
endfor
unlet! s:ft


" :display: :Likelycomplete [NAME=VALUE ...]
" Enable LikelyComplete for the current buffer.
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


" :display: :Likelycompleteremovewords [FILETYPE]
" Remove words from the list for a given filetype (or the filetype of 
" the current buffer).
command! -nargs=? -complete=filetype Likelycompleteremovewords call likelycomplete#RemoveWords(<q-args>)


" Map 'completefunc' to a function that returns matches from the 
" original completefunc and from the buffers wordlist.
" See also |g:likelycomplete#use_omnifunc| and 
" |g:likelycomplete#set_completefunc|.
command! Likelycompletemapcompletefunc call likelycomplete#SetComleteFunc()


" :display: :Likelycompletemapselect IMAP
" Map insert mode IMAP to a function that lets users select a completion 
" from a word list.
" See |tlib#input#List()| for details on how to use the list picker.
" See also |g:likelycomplete#use_omnifunc| and |g:likelycomplete#select_imap|.
command! -nargs=1 Likelycompletemapselect call likelycomplete#MapSelectWord(<q-args>)


let &cpo = s:save_cpo
unlet s:save_cpo
