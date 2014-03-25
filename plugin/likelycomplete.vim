" @Author:      Tom Link (micathom AT gmail com?subject=[vim])
" @Website:     http://www.vim.org/account/profile.php?user_id=4037
" @GIT:         http://github.com/tomtom/likelycomplete_vim
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Revision:    99
" GetLatestVimScripts: 4889 0 :AutoInstall: likelycomplete.vim

if &cp || exists("loaded_likelycomplete")
    finish
endif
let loaded_likelycomplete = 2

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
    " The pseudo-filetype "_" is for buffers with no filetype (i.e., 
    " 'ft' is empty).
    "
    "                                                   *b:likelycomplete_filetype*
    " If the variable b:likelycomplete_filetype is defined on FileType 
    " events, its value is used instead of 'filetype'. LikelyComplete 
    " is automatically enabled for all buffers where the 
    " b:likelycomplete_filetype is defined. This variable can be used to 
    " generate project-specific word lists.
    let g:likelycomplete_filetypes = []   "{{{2
endif


if !exists('g:likelycomplete_per_window')
    "                                                   *w:likelycomplete_filetype*
    " If true, support window specific values of 
    " |b:likelycomplete_filetype|.
    "
    " If you have several windows of one buffer with differing 
    " filetypes, those should not conflict with respect to the following 
    " options (see |g:likelycomplete#options| for details): >
    "
    "   set_completefunc
    "   auto_complete
    "
    " and maybe some more.
    "
    " NOTE: This variable should not be changed once the plugin was 
    " loaded.
    let g:likelycomplete_per_window = 0   "{{{2
endif


augroup LikelyComplete
    autocmd!
    if g:likelycomplete_per_window
        autocmd LikelyComplete Filetype * if exists('w:likelycomplete_filetype') | call likelycomplete#SetupBuffer(w:likelycomplete_filetype, expand("<abuf>")) | endif
        autocmd LikelyComplete Filetype * if !exists('w:likelycomplete_filetype') && exists('b:likelycomplete_filetype') | call likelycomplete#SetupBuffer(b:likelycomplete_filetype, expand("<abuf>")) | endif
    else
        autocmd LikelyComplete Filetype * if exists('b:likelycomplete_filetype') | call likelycomplete#SetupBuffer(b:likelycomplete_filetype, expand("<abuf>")) | endif
    endif
augroup END


function! LikelycompleteSetupFiletype(filetype) "{{{3
    exec 'autocmd! LikelyComplete FileType' a:filetype
    exec 'autocmd LikelyComplete FileType' a:filetype 'if !exists("b:likelycomplete_filetype") | call likelycomplete#SetupBuffer('. string(a:filetype) .', expand("<abuf>")) | endif'
endf


for s:ft in g:likelycomplete_filetypes
    call LikelycompleteSetupFiletype(s:ft)
endfor
unlet! s:ft


" :display: :Likelycomplete [NAME=VALUE ...]
" Enable LikelyComplete for the current buffer.
" See |g:likelycomplete#options| for a list of supported key-value
" arguments.
" In general, the plugin should be enabled by setting 
" |g:likelycomplete_filetypes|.
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


command! Likelycompleteupdate call likelycomplete#LoadData()

let &cpo = s:save_cpo
unlet s:save_cpo
