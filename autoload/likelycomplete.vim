" @Author:      Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Revision:    1002


if !exists('g:loaded_tlib') || g:loaded_tlib < 107
    runtime plugin/02tlib.vim
    if !exists('g:loaded_tlib') || g:loaded_tlib < 107
        echoerr 'tlib >= 1.07 is required'
        finish
    endif
endif


if !exists('g:likelycomplete#experimental')
    " If 1, enable some experimental options.
    " If 2, enable even more experimental options that are not 
    " recommended for everyday use.
    "
    " Some of these experimental options may cause minor interruptions, 
    " delays, and increased memory usage.
    "
    " The list of features deemed 'experimental' may change from version 
    " to version.
    let g:likelycomplete#experimental = 0   "{{{2
endif


if !exists('g:likelycomplete#list_set_filter')
    " If true, the part of the words matching the the base text will be 
    " highlighted in |likelycomplete#SelectWord()|.
    " If false, the setting of 'smartcase' is ignored.
    let g:likelycomplete#list_set_filter = 0   "{{{2
endif


if !exists('g:likelycomplete#select_imap')
    " The default map for |:Likelycompletemapselect|.
    " If non-empty, enable |:Likelycompletemapselect| for all enabled 
    " filetypes.
    let g:likelycomplete#select_imap = empty(maparg('<C-S-Space>', 'i'))? '<C-S-Space>' : ''  "{{{2
endif


if !exists('g:likelycomplete#set_completefunc')
    " If true, set 'completefunc' for supported buffers. The results of 
    " the old completefunc will be incorporated.
    " See also |:Likelycompletemapcompletefunc|.
    let g:likelycomplete#set_completefunc = g:likelycomplete#experimental >= 1   "{{{2
endif


if !exists('g:likelycomplete#auto_complete')
    " The number of characters after which auto-completion should be 
    " invoked. If 0, auto-completion is disabled.
    "
    "                                 *i_Ctrl-G_Ctrl-U* *likelycomplete-<c-g><c-u>*
    " When auto-completion is enabled, a |imap| <c-g><c-u> is defined 
    " that can be used to temporarily disable auto-completion in order 
    " to perform some other kind of |ins-completion|. Auto-completion 
    " will be re-enabled on the next |CompleteDone| event issued by that 
    " completion.
    "
    " This option requires |g:likelycomplete#set_completefunc| to be 
    " true or |:Likelycompletemapcompletefunc| to be called.
    let g:likelycomplete#auto_complete = g:likelycomplete#experimental >= 1 ? 2 : 0  "{{{2
endif


if !exists('g:likelycomplete#use_omnifunc')
    " If true, include completions from 'omnifunc'.
    " Please be aware that some omnifunc take their time (at least on 
    " first invocation).
    " This is only used in conjunction with |:Likelycompletemapselect| 
    " and |:Likelycompletemapcompletefunc|.
    let g:likelycomplete#use_omnifunc = 0   "{{{2
endif


if !exists('g:likelycomplete#use_words')
    " If true, add words in the current buffer to the list of possible 
    " completions.
    let g:likelycomplete#use_words = 1   "{{{2
endif


if !exists('g:likelycomplete#match_beginning')
    " If true, matches must match the beginning of a word -- this is 
    " only relevant to |:Likelycompletemapselect| and 
    " |:Likelycompletemapcompletefunc|. Matches for |i_Ctrl-P| must 
    " always match the beginning of a word.
    let g:likelycomplete#match_beginning = 0   "{{{2
endif


if !exists('g:likelycomplete#use_fuzzy_matches')
    " If true, use fuzzy matches for |:Likelycompletemapselect| 
    " and |:Likelycompletemapcompletefunc|.
    " If you really believe in fuzzy matching, you might want to 
    " consider also setting |g:tlib#input#filter_mode| to 'fuzzy'.
    let g:likelycomplete#use_fuzzy_matches = 1   "{{{2
endif


if !exists('g:likelycomplete#list_picker')
    " VIM plugin developers can add support for "list pickers" other 
    " than tlib by defining the following functions:
    "
    "     likelycomplete#ListPicker(type, prompt, list, base)
    " 
    " with
    "
    "   type .... 's' (select single item) or 'm' (select multiple items)
    "   prompt .. A string
    "   list .... A list
    "   base .... A string that should be selected (may be ignored; see 
    "             also |g:likelycomplete#list_set_filter|)
    let g:likelycomplete#list_picker = 'tlib'   "{{{2
endif


if !exists('g:likelycomplete#other_sources')
    " A list of variable names, whose values will be added to the word 
    " list.
    " This is only used in conjunction with |:Likelycompletemapselect| 
    " and |:Likelycompletemapcompletefunc|.
    let g:likelycomplete#other_sources = []   "{{{2
endif


if !exists('g:likelycomplete#data_cfile')
    let g:likelycomplete#data_cfile = tlib#persistent#Filename('likelycomplete', 'data', 1)   "{{{2
endif


if !exists('g:likelycomplete#options')
    " The following keys are supported:
    "   exclude_lines_rx ... Exclude lines matching this |regexp|
    "   strip_comments ..... Remove comments and any trailing text (not 
    "                        supported for all filetypes; requires 
    "                        cms_rx or 'cms' to be set)
    "   strip_strings ...... Remove strings from lines
    "   strip_multiline_strings .. Remove multi-line strings from the text
    "   strip_numbers ...... Remove numbers from lines
    "   strip_rx ........... Remove matching text from lines
    "   cms_rx ............. A |regexp| matching comments (override use 
    "                        of 'cms')
    "
    " The following keys can override global parameters:
    "   other_sources ...... Override |g:likelycomplete#other_sources|
    "   set_completefunc ... Override |g:likelycomplete#set_completefunc|
    "   auto_complete ...... Override |g:likelycomplete#auto_complete|
    "   use_omnifunc ....... Override |g:likelycomplete#use_omnifunc|
    "   use_words .......... Override |g:likelycomplete#use_words|
    "   use_fuzzy_matches .. Override |g:likelycomplete#use_fuzzy_matches|
    "   match_beginning .... Override |g:likelycomplete#match_beginning|
    "   maxsize ............ Override |g:likelycomplete#maxsize|
    "   once_per_file ...... Override |g:likelycomplete#once_per_file|
    "   assess_context ..... Override |g:likelycomplete#assess_context|
    "   word_minlength ..... Override |g:likelycomplete#word_minlength|
    let g:likelycomplete#options = {}
endif


if !exists('g:likelycomplete#options_javascript')
    " Some custom options for javascript (see 
    " |g:likelycomplete#options|).
    " :read: let g:likelycomplete#options_javascript = {...}   "{{{2
    let g:likelycomplete#options_javascript = {
                \ 'exclude_lines_rx': '^\s*//',
                \ 'cms_rx': '\(/*%s*/\|\^\s\*//%s\)',
                \ }
endif


if !exists('g:likelycomplete#options_vim')
    " Some custom options for the vim filetype (see 
    " |g:likelycomplete#options|).
    " Anything following a single or double quote is removed. This will 
    " make sure that all strings an comments are removed -- at the cost 
    " of also removing eligible identifiers following a string.
    " :read: let g:likelycomplete#options_vim = {...}   "{{{2
    let g:likelycomplete#options_vim = {
                \ 'exclude_lines_rx': '^\s*"',
                \ 'strip_strings': 1,
                \ 'strip_multiline_strings': 0,
                \ 'strip_comments': 1,
                \ }
endif


if !exists('g:likelycomplete#maxsize')
    " The maximum number of words kept per filetype.
    let g:likelycomplete#maxsize = 5000   "{{{2
endif


if !exists('g:likelycomplete#word_minlength')
    " Minimum length of words.
    let g:likelycomplete#word_minlength = 3   "{{{2
endif


if !exists('g:likelycomplete#once_per_file')
    " If true, count a word only once per file. By default, N occurences 
    " of word X in a buffer will be counted as N times.
    let g:likelycomplete#once_per_file = 0   "{{{2
endif


if !exists('g:likelycomplete#assess_context')
    " The number of preceding words that should be taken into account 
    " when sorting the list of possible completions.
    " This is only used in conjunction with |:Likelycompletemapselect| 
    " and |:Likelycompletemapcompletefunc|.
    "
    " CAUTION: This may cause a slow-down and increased memory use. This 
    " option only works properly if |g:likelycomplete#once_per_file| 
    " evaluates to false.
    let g:likelycomplete#assess_context = g:likelycomplete#experimental >= 1 && !g:likelycomplete#once_per_file ? 5 : 0   "{{{2
endif


if !exists('g:likelycomplete#base')
    " The base number of observations.
    " Also the number of files, you can edit without removing a word 
    " that was't included in any of these files.
    " If this value is too low, new words won't get a chance to be 
    " included in the list.
    let g:likelycomplete#base = 50   "{{{2
endif


if !exists('g:likelycomplete#max')
    " The maximum number of observations taken into account.
    let g:likelycomplete#max = 10000   "{{{2
endif


if !exists('g:likelycomplete#base_context')
    " Forget a word in context after N files where it was missing.
    let g:likelycomplete#base_context = 20   "{{{2
endif


if !exists('g:likelycomplete#max_context')
    " The max weight for words in context.
    "
    " NOTE: The actual max value is |g:likelycomplete#max_context| + 
    " |g:likelycomplete#base_context| - 1.
    let g:likelycomplete#max_context = 1000   "{{{2
endif


if !exists('g:likelycomplete#run_async')
    " How to run |g:likelycomplete#prgname|.
    let g:likelycomplete#run_async = has('win16') || has('win32') || has('win64') ? '!start /min cmd /c %s >NUL' : '! %s > /dev/null &'   "{{{2
endif


if !exists('g:likelycomplete#prgname')
    " Non-empty use this program to asynchronously update word lists.
    " It's preferable to use vim instead of gvim.
    let g:likelycomplete#prgname = g:likelycomplete#experimental >= 2 && has('clientserver') && !empty(v:servername) ? (executable('vim') ? 'vim' : v:progname) : ''  "{{{2
endif


if !exists('g:likelycomplete#debug')
    let g:likelycomplete#debug = 0   "{{{2
endif


function! likelycomplete#LoadData() "{{{3
    let s:likelycomplete_data = tlib#persistent#Get(g:likelycomplete#data_cfile, {'version': 1, 'ft': {}, 'ft_options': {}})
    return ''
endf

call likelycomplete#LoadData()


function! s:SaveData() "{{{3
    call tlib#persistent#Save(g:likelycomplete#data_cfile, s:likelycomplete_data)
endf


function! s:SetData(filetype, data) "{{{3
    let s:likelycomplete_data.ft[a:filetype] = a:data
endf


function! s:GetData(...) "{{{3
    let filetype = a:0 >= 1 ? a:1 : s:GetFiletype()
    call s:EnsureFiletype(filetype)
    return s:likelycomplete_data.ft[filetype]
endf


function! s:FtOptions(filetype) "{{{3
    let ft_options = get(s:likelycomplete_data.ft_options, a:filetype, {})
    call extend(ft_options, g:likelycomplete#options)
    if exists('g:likelycomplete#options_'. a:filetype)
        call extend(ft_options, g:likelycomplete#options_{a:filetype})
    endif
    return ft_options
endf


function! likelycomplete#String2Args(string) "{{{3
    let opts = {}
    for word in split(a:string, '\s\+')
        let m = matchlist(word, '^\([^=]\+\)=\(.*\)$')
        if empty(m)
            throw "LikelyComplete: Malformed arguments string: ". string(a:string)
        endif
        let opts[m[1]] = m[2]
    endfor
    return opts
endf


function! likelycomplete#SetupFiletype(filetype, options) "{{{3
    if s:EnsureFiletype(a:filetype, a:options)
        call likelycomplete#SetupBuffer(a:filetype, bufnr('%'))
    endif
endf


function! likelycomplete#SetupBuffer(filetype, bufnr) "{{{3
    call s:EnsureFiletype(a:filetype)
    call s:SetupComplete(a:filetype)
    if !empty(g:likelycomplete#select_imap)
        call likelycomplete#MapSelectWord(g:likelycomplete#select_imap)
    endif
    exec 'autocmd! LikelyComplete BufDelete <buffer='. a:bufnr .'>'
    exec 'autocmd LikelyComplete BufDelete <buffer='. a:bufnr .'> call s:UpdateWordList('. a:bufnr .','. string(a:filetype) .','. string(expand('%:p')) .')'
endf


function! s:SetFiletypeOptions(filetype, options) "{{{3
    if !has_key(s:likelycomplete_data.ft_options, a:filetype)
        let s:likelycomplete_data.ft_options[a:filetype] = {}
    endif
    if !empty(a:options)
        call extend(s:likelycomplete_data.ft_options[a:filetype], a:options)
    endif
    " if !has_key(ft_options, '_includes')
    "     let ft_options._includes = []
    " endif
    " while has_key(ft_options, 'includes')
    "     let ft_extended = ft_options.includes
    "     call add(ft_options._includes, ft_extended)
    "     call remove(ft_options, 'includes')
    "     let other_options = s:FtOptions(ft_extended)
    "     let ft_options = extend(ft_options, other_options, 'keep')
    " endwh
endf


function! s:GetFiletype() "{{{3
    return exists('b:likelycomplete_filetype') ? b:likelycomplete_filetype : &l:filetype
endf


function! s:SetDerivedOptions(filetype) "{{{3
    if s:GetFiletype() == a:filetype
        let ft_options = s:likelycomplete_data.ft_options[a:filetype]
        if !has_key(ft_options, 'cms')
            let s:likelycomplete_data.ft_options[a:filetype].cms = &l:cms
        endif
        if !empty(&l:iskeyword) && (!has_key(ft_options, '_split_rx') || get(ft_options, '_iskeyword', '') != &l:iskeyword)
            let s:likelycomplete_data.ft_options[a:filetype]._iskeyword = &l:iskeyword
            let s:likelycomplete_data.ft_options[a:filetype]._split_rx = s:GetKeywordRx(&l:iskeyword, 1)
        endif
    endif
endf


function! s:GetKeywordRx(iskeyword, inverse) "{{{3
    let parts = map(split(a:iskeyword, ','), 's:KeywordPartRx(split(v:val, ''-''), 0)')
    let pos = filter(copy(parts), 'v:val !~ ''^\^''')
    let neg = filter(copy(parts), 'v:val =~ ''^\^''')
    let neg = map(neg, 'substitute(v:val, ''^\^'', "", "")')
    let idash = index(pos, '-')
    if idash != -1
        call add(pos, remove(pos, idash))
    endif
    let idash = index(neg, '-')
    if idash != -1
        call add(neg, remove(neg, idash))
    endif
    if a:inverse
        if !empty(pos)
            let pos = insert(pos, '^')
        endif
    else
        if !empty(neg)
            let neg = insert(neg, '^')
        endif
    endif
    let poss = join(pos, '')
    let negs = join(neg, '')
    if !empty(poss)
        if !empty(negs)
            let rx = printf('\%([%s]\+\|[%s]\+\)\+', poss, negs)
        else
            let rx = '['. poss .']\+'
        endif
    elseif !empty(negs)
        let rx = '['. negs .']\+'
    elseif a:inverse
        let rx = '\W\+'
    else
        let rx = '\w\+'
    endif
    return rx
endf


function! s:KeywordPartRx(subparts, inverse) "{{{3
    if len(a:subparts) > 2
        throw "KeywordPartRx: Internal error: ". string(a:subparts)
    endif
    let subparts = map(a:subparts, 'v:val =~ ''^\d\+$'' ? nr2char(v:val) : v:val')
    let inverse = a:inverse
    let rv = join(subparts, '-')
    if rv =~ '^\^'
        let inverse = !inverse
    endif
    if rv == '@'
        let rv = '[:alpha:]'
    endif
    let pre = inverse ? '^' : ''
    return pre . rv
endf


let s:setup = {}

function! s:EnsureFiletype(...) "{{{3
    let filetype = a:0 >= 1 ? a:1 : s:GetFiletype()
    let options  = a:0 >= 2 ? a:2 : {}
    if !has_key(s:likelycomplete_data.ft, filetype)
        call s:SetData(filetype, {})
        call s:SetFiletypeOptions(filetype, options)
        call LikelycompleteSetupFiletype(filetype)
        call s:SaveData()
        let rv = 1
    else
        let rv = 0
    endif
    if !has_key(s:setup, filetype)
        let s:setup[filetype] = 1
        call s:SetDerivedOptions(filetype)
    endif
    return rv
endf


function! likelycomplete#RemoveFiletype(filetype) "{{{3
    unlet! s:likelycomplete_data.ft[a:filetype]
    unlet! s:likelycomplete_data.ft_options[a:filetype]
    let fname = s:WordListFilename(a:filetype)
    if filereadable(fname)
        call delete(fname)
    endif
    call s:SaveData()
    echom "LikelyComplete: Removed support for" a:filetype
endf


function! s:WordListFilename(filetype) "{{{3
    let dir = fnamemodify(g:likelycomplete#data_cfile, ':p:h')
    let fname = tlib#file#Join([dir, a:filetype .'_words'])
    return fname
endf


function! s:SetupComplete(filetype) "{{{3
    let fname = s:WordListFilename(a:filetype)
    if filereadable(fname)
        let opt = 'k'. fname
        if stridx(&l:complete, opt) == -1
            exec 'setl complete+='. escape(opt, ' ,\')
        endif
        if stridx(&l:dictionary, fname) == -1
            exec 'setl dictionary+='. escape(fname, ' ,\')
        endif
    endif
    let ft_options = s:FtOptions(a:filetype)
    if get(ft_options, 'set_completefunc', g:likelycomplete#set_completefunc)
        call likelycomplete#SetComleteFunc()
        if get(ft_options, 'auto_complete', g:likelycomplete#auto_complete)
            autocmd! LikelyComplete CursorMovedI <buffer>
            autocmd LikelyComplete CursorMovedI <buffer> if !exists('b:likelycomplete_disable_auto_complete') && !pumvisible() | call s:AutoComplete() | endif
            imap <buffer> <silent> <c-g><c-u> <c-\><c-o>:call likelycomplete#EscapeAutoComplete('')<cr>
        endif
    endif
endf


if g:likelycomplete#debug
    function! likelycomplete#Tokenize(text, ...) "{{{3
        let filetype = a:0 >= 1 ? a:1 : &ft
        let ft_options = s:FtOptions(filetype)
        return s:Tokenize(ft_options, a:text)
    endf
endif


function! s:Tokenize(ft_options, text) "{{{3
    let text = a:text
    if get(a:ft_options, 'strip_multiline_strings', 1)
        let text = s:RemoveStrings(a:ft_options, text)
    endif
    let _split_rx = get(a:ft_options, '_split_rx', '\W\+')
    return split(text, _split_rx)
endf


function! s:RemoveStrings(ft_options, text) "{{{3
    let text = a:text
    let text = substitute(text, '"\(\\"\|.\{-}\)\+"', ' ', 'g')
    let text = substitute(text, '''\(''''\|\\''\|.\{-}\)\+''', ' ', 'g')
    return text
endf


function! likelycomplete#AsyncUpdateWordList(servername, filetype, filename) "{{{3
    if has('gui_running')
        suspend
    endif
    call s:UpdateWordListNow(-1, a:filetype, a:filename)
    let servers = split(serverlist(), '\n')
    if index(servers, a:servername) != -1
        let cmd = printf('%s --servername %s --remote-expr "likelycomplete#LoadData()"',
                    \ g:likelycomplete#prgname,
                    \ a:servername)
        let run = printf(g:likelycomplete#run_async, cmd)
        exec 'silent!' escape(run, '#%')
    endif
    qall!
endf


let s:sfile = expand('<sfile>:p')

function! s:UpdateWordList(bufnr, filetype, filename) "{{{3
    if empty(g:likelycomplete#prgname) || empty(g:likelycomplete#run_async) || s:sfile == fnamemodify(a:filename, ':p')
        call s:UpdateWordListNow(a:bufnr, a:filetype, a:filename)
    else
        if getbufvar(a:bufnr, 'likelycomplete_done', 0)
            return
        endif
        let cmd = printf('%s -R -n -c "call likelycomplete#AsyncUpdateWordList(%s, %s, %s)"',
                    \ g:likelycomplete#prgname,
                    \ string(v:servername),
                    \ string(a:filetype),
                    \ string(fnameescape(a:filename)))
                    " \ g:likelycomplete#prgname =~ '\<gvim\>' ? '-c suspend' : '',
        let run = printf(g:likelycomplete#run_async, cmd)
        exec 'silent!' escape(run, '#%')
        call setbufvar(a:bufnr, 'likelycomplete_done', 1)
    endif
endf


function! s:GetBufferWords(bufnr, filetype, filename, ft_options) "{{{3
    if bufnr('%') == a:bufnr
        let lines = getline(1, line('$'))
    elseif filereadable(a:filename)
        let lines = readfile(a:filename)
    else
        return []
    endif
    let exclude_lines_rx = get(a:ft_options, 'exclude_lines_rx', '')
    if !empty(exclude_lines_rx)
        let lines = filter(lines, 'v:val !~ exclude_lines_rx')
    endif
    if get(a:ft_options, 'strip_strings', 1)
        let lines = map(lines, 's:RemoveStrings(a:ft_options, v:val)')
    endif
    let strip_rx = get(a:ft_options, 'strip_rx', '')
    if !empty(strip_rx)
        let lines = map(lines, 'substitute(v:val, strip_rx, " ", "g")')
    endif
    if get(a:ft_options, 'strip_comments', 1) && has_key(a:ft_options, 'cms')
        let cms_rx = get(a:ft_options, 'cms_rx', '')
        if empty(cms_rx)
            let cms_rx = '\V'. substitute(escape(a:ft_options.cms, '\'), '%s', '\\.\\{-}', '')
        endif
        if cms_rx !~ '\\$\$'
            let cms_rx .=  '\.\*\$'
        endif
        let lines = filter(lines, 'v:val !~ cms_rx')
    endif
    let words = s:Tokenize(a:ft_options, join(lines))
    let word_minlength = get(a:ft_options, 'word_minlength', g:likelycomplete#word_minlength)
    let words = filter(words, '!empty(v:val) && strwidth(v:val) >= word_minlength')
    if get(a:ft_options, 'strip_numbers', 1)
        let words = filter(words, 'v:val !~ ''^-\?\d\+\(\.\d\+\)\?$''')
    endif
    return words
endf


function! s:UpdateWordListNow(bufnr, filetype, filename) "{{{3
    if a:bufnr > 0 && getbufvar(a:bufnr, 'likelycomplete_done', 0)
        return
    endif
    if a:bufnr > 0
        echo 'LikelyComplete: Updating' a:filetype 'word list'
    endif
    let ft_options = s:FtOptions(a:filetype)
    let words = s:GetBufferWords(a:bufnr, a:filetype, a:filename, ft_options)
    let data = s:GetData(a:filetype)
    if !empty(words)
        let wordds = {}
        for word in words
            let wordds[word] = 1
        endfor
        let once_per_file = get(ft_options, 'once_per_file', g:likelycomplete#once_per_file)
        if once_per_file
            let words = keys(wordds)
            let assess_context = 0
        else
            let assess_context = get(ft_options, 'assess_context', g:likelycomplete#assess_context)
        endif
        for word in words
            if has_key(data, word)
                let worddef = data[word]
                if worddef.obs < g:likelycomplete#max
                    let worddef.obs += 1
                elseif worddef.n > 1
                    let worddef.n -= 1
                endif
            else
                let worddef = {'obs': g:likelycomplete#base, 'n': g:likelycomplete#base}
            endif
            let data[word] = worddef
        endfor
        if assess_context > 0
            let context_words = []
            let iword = 0
            for word in words
                let data[word].context = s:AssessContext(word, get(data[word], 'context', {}), context_words)
                call add(context_words, word)
                if iword >= assess_context
                    call remove(context_words, 0)
                else
                    let iword += 1
                endif
            endfor
        endif
        for word in filter(keys(data), '!has_key(wordds, v:val)')
            if data[word].n < g:likelycomplete#max
                let data[word].n += 1
            elseif data[word].obs > 1
                let data[word].obs -= 1
            endif
        endfor
        call s:SetData(a:filetype, data)
        if !s:WriteWordList(a:filetype)
            call s:SaveData()
        endif
    endif
    if a:bufnr > 0
        echo
        call setbufvar(a:bufnr, 'likelycomplete_done', 1)
    endif
endf


function! s:AssessContext(word, context, words) "{{{3
    let old_words = copy(a:context)
    for word in a:words
        if has_key(a:context, word)
            let old_words[word] = -1
            if a:context[word] < g:likelycomplete#max_context
                let a:context[word] += g:likelycomplete#base_context
            endif
        else
            let a:context[word] = g:likelycomplete#base_context
        endif
    endfor
    for [word, val] in items(old_words)
        if val != -1
            let n = get(a:context, word, 0)
            if n <= 1
                call remove(a:context, word)
            elseif n > 0
                let a:context[word] = n - 1
            endif
        endif
    endfor
    return a:context
endf


function! s:WriteWordList(filetype) "{{{3
    let data = s:GetData(a:filetype)
    let saved_data = 0
    if !empty(data)
        let ft_options = s:FtOptions(a:filetype)
        let maxsize = get(ft_options, 'maxsize', g:likelycomplete#maxsize)
        let words = values(map(copy(data), '[(0.0 + v:val.obs) / v:val.n, v:key]'))
        let words = sort(words)
        let words = map(words, 'v:val[1]')
        let words = reverse(words)
        if len(words) > maxsize
            let truncated = words[maxsize : -1]
            let words = words[0 : maxsize - 1]
        else
            let truncated = []
        endif
        let fname = s:WordListFilename(a:filetype)
        call writefile(words, fname)
        if !empty(truncated)
            for word in truncated
                call remove(data, word)
            endfor
            call s:SetData(a:filetype, data)
            call s:SaveData()
            let saved_data = 1
        endif
    endif
    return saved_data
endf


function! likelycomplete#ListPicker_tlib(type, prompt, list, base) "{{{3
    let handlers = []
    if !empty(a:base)
        call add(handlers, {'filter': s:GetVFilter(filetype, a:base)})
    endif
    let showmode = &showmode
    set noshowmode
    try
        return tlib#input#List(a:type, a:prompt, a:list, handlers)
    finally
        if showmode != &showmode
            let &showmode = showmode
        endif
    endtry
endf


function! likelycomplete#RemoveWords(...) "{{{3
    let filetype = a:0 >= 1 && !empty(a:1) ? a:1 : s:GetFiletype()
    let data = s:GetData(filetype)
    if !empty(data)
        let words0 = sort(keys(data))
        let words1 = likelycomplete#ListPicker_{g:likelycomplete#list_picker}('m', 'Select obsolete words', words0, '')
        if !empty(words1)
            for word in words1
                call remove(data, word)
            endfor
            call s:SetData(filetype, data)
            if !s:WriteWordList(filetype)
                call s:SaveData()
            endif
        endif
    endif
endf


function! likelycomplete#MapSelectWord(imap) "{{{3
    call s:EnsureFiletype()
    let imap = empty(a:imap) ? g:likelycomplete#select_imap : a:imap
    if !empty(imap)
        exec 'inoremap' imap '<c-\><c-o>db<C-r>=likelycomplete#SelectWord(@")<cr>'
    endif
endf


function! likelycomplete#SelectWord(base) "{{{3
    let filetype = s:GetFiletype()
    let words = s:GetSortedCompletions(filetype, a:base, 0)
    let fbase = g:likelycomplete#list_set_filter ? a:base : ''
    let word = likelycomplete#ListPicker_{g:likelycomplete#list_picker}('s', 'Select word:', words, fbase)
    if empty(word)
        let word = a:base
    endif
    return word
endf


function! likelycomplete#SetComleteFunc() "{{{3
    if exists('+completefunc') && &l:completefunc != 'likelycomplete#Complete'
        call s:EnsureFiletype()
        let b:likelycomplete_completefunc = &l:completefunc
        setl completefunc=likelycomplete#Complete
    endif
endf


function! likelycomplete#EscapeAutoComplete(map) "{{{3
    let b:likelycomplete_disable_auto_complete = 1
    autocmd LikelyComplete CompleteDone <buffer> unlet! b:likelycomplete_disable_auto_complete
                \ | autocmd! LikelyComplete CompleteDone
endf


function s:AutoComplete()
    if exists('b:likelycomplete_completefunc')
        let filetype = s:GetFiletype()
        let ft_options = s:FtOptions(filetype)
        let auto_complete = get(ft_options, 'auto_complete', g:likelycomplete#auto_complete)
        let start = likelycomplete#Complete(1, '')
        if start >= 0 && col('.') - start > auto_complete
            let s:auto_complete = 1
            call feedkeys("\<c-x>\<c-u>", 't') 
        endif
    endif
endf


let s:last_failed = []

function! likelycomplete#Complete(findstart, base) "{{{3
    if a:findstart
        let pos = getpos('.')
        let line = strpart(getline('.'), 0, col('.') - 1)
        let start = match(line, '\k\+$')
        let base = line[start : -1]
        let pos[2] = start + 1
        if pos == s:last_failed
            return -3
        elseif start == -1 && exists('s:auto_complete')
            let s:last_failed = pos
            unlet s:auto_complete
            return -3
        elseif base !~ '\D'
            return -3
        else
            let s:last_failed = []
            return start
        endif
    elseif a:base =~ '\D'
        try
            let rv = s:GetSortedCompletions(s:GetFiletype(), a:base, 1)
        catch
            echohl Error
            echom v:exception
            echohl NONE
            let rv = []
        endtry
        if len(rv) <= 1
            let s:last_failed = getpos('.')
        endif
        return rv
    else
        let s:last_failed = getpos('.')
        return []
    endif
endf


let s:last_base = ''
let s:last_filetype = ''
let s:last_completions = []

function! s:GetSortedCompletions(filetype, base, insert_base) "{{{3
    let ft_options = s:FtOptions(a:filetype)
    let reuse = s:last_filetype == a:filetype && strpart(a:base, 0, len(s:last_base)) ==# s:last_base
    let completions = reuse ? copy(s:last_completions) : s:GetCompletions(a:filetype, a:base, ft_options)
    if !empty(a:base)
        let lbase = len(a:base)
        let rx = s:GetVFilter(a:filetype, a:base)
        let completions = filter(completions, 'len(v:val) > lbase && v:val =~ rx')
        if get(ft_options, 'assess_context', g:likelycomplete#assess_context)
            let completions = s:GetWordsSortedByRelevance(a:filetype, a:base, ft_options, completions)
        endif
        if a:insert_base
            let completions = insert(completions, a:base)
        endif
    endif
    if !reuse
        let s:last_base = a:base
        let s:last_completions = copy(completions)
        let s:last_filetype = a:filetype
    endif
    return completions
endf


function! s:GetCompletions(filetype, base, ft_options) "{{{3
    let completions = []
    let fname = s:WordListFilename(a:filetype)
    if filereadable(fname)
        let completions += readfile(fname)
    endif
    let fns = []
    if exists('b:likelycomplete_completefunc')
        call add(fns, b:likelycomplete_completefunc)
    endif
    if exists('+omnifunc') && get(a:ft_options, 'use_omnifunc', g:likelycomplete#use_omnifunc)
        call add(fns, &l:omnifunc)
    endif
    for fn in fns
        if !empty(fn)
            let completions += call(fn, [0, a:base])
        endif
    endfor
    for var in get(a:ft_options, 'other_sources', g:likelycomplete#other_sources)
        if exists(var) && !empty(var)
            exec 'let varval =' var
            if type(varval) == 1
                let words = split(varval, '\n')
            elseif type(varval) == 3
                let words = varval
            elseif type(varval) == 4
                let words = keys(varval)
            else
                throw 'LikelyComplete: Unsupported type for var '. var
            endif
            let completions += words
            unlet varval
        endif
    endfor
    if get(a:ft_options, 'use_words', g:likelycomplete#use_words)
        let completions += tlib#list#Uniq(s:GetBufferWords(bufnr('%'), s:GetFiletype(), '', a:ft_options), '', 1)
    endif
    let completions = tlib#list#Uniq(completions, '', 1)
    return completions
endf


function! s:GetVFilter(filetype, base) "{{{3
    if &smartcase && a:base =~ '\u'
        let rx = '\C\V'
    elseif &ignorecase
        let rx = '\c\V'
    else
        let rx = '\C\V'
    endif
    let ft_options = s:FtOptions(a:filetype)
    if get(ft_options, 'match_beginning', g:likelycomplete#match_beginning)
        let rx .= '\^'
    endif
    if get(ft_options, 'use_fuzzy_matches', g:likelycomplete#use_fuzzy_matches)
        let rx .= join(map(split(a:base, '\zs'), 'escape(v:val, ''\'')'), '\.\{-}')
    else
        let rx .= escape(a:base, '\')
    endif
    return rx
endf


function! s:GetWordParts(base) "{{{3
    let parts = {}
    let lbase = len(a:base)
    if lbase > 2
        for l in range(2, lbase)
            let lparts = split(a:base, repeat('.', l) .'\zs')
            let parts_rx = join(lparts, '\.\{-}')
            let parts[l] = parts_rx
        endfor
    endif
    return parts
endf


function! s:GetWordsSortedByRelevance(filetype, base, ft_options, words) "{{{3
    let line = getline('.')[0 : col('.') - 1]
    let line = substitute(line, '\(^\s\+\|\s\+$\)', '', 'g')
    let use_fuzzy = get(a:ft_options, 'use_fuzzy_matches', g:likelycomplete#use_fuzzy_matches)
    let cfg = {
                \ 'base': a:base,
                \ 'base_rx': escape(a:base, '\'),
                \ 'bbase_rx': '\V\^'. escape(a:base, '\'),
                \ 'base_parts': use_fuzzy ? items(s:GetWordParts(a:base)) : [],
                \ 'words': s:Tokenize(a:ft_options, line),
                \ 'match_beginning': get(a:ft_options, 'match_beginning', g:likelycomplete#match_beginning),
                \ 'use_fuzzy': use_fuzzy,
                \ 'use_omnifunc': get(a:ft_options, 'use_omnifunc', g:likelycomplete#use_omnifunc),
                \ 'data': s:GetData(a:filetype),
                \ }
    let assessed_words = map(copy(a:words), 's:AddRelevance(v:val, cfg)')
    let sorted_words = sort(assessed_words, 's:CompareRev0')
    let sorted_words = map(sorted_words, 'v:val[1]')
    return sorted_words
endf


function! s:AddRelevance(word, cfg) "{{{3
    let worddef = get(a:cfg.data, a:word, {})
    let val = 0
    if !empty(worddef)
        let val = (0.0 + worddef.obs) / worddef.n
        let weight = s:AssessWordInContext(a:word, get(worddef, 'context', {}), a:cfg.words)
        if weight != 0
            let val = val * weight
        endif
        if val > g:likelycomplete#max
            let val = 0.0 + g:likelycomplete#max
        endif
    endif
    if a:cfg.use_fuzzy
        for [plen, parts_rx] in a:cfg.base_parts
            if a:word =~? parts_rx
                if a:word =~# parts_rx
                    let plen = plen * 5
                endif
                let val = val * plen
            endif
        endfor
    else
        if !a:cfg.match_beginning
            let wordpart = strpart(a:word, 0, len(a:cfg.base))
            if wordpart ==# a:cfg.base
                let val = val * 10
            elseif (&ignorecase || &smartcase) && wordpart ==? a:cfg.base
                let val = val * 5
            endif
        endif
        if a:word =~# a:cfg.base_rx
            let val = val * 3
        elseif a:word =~? a:cfg.base_rx
            let val = val * 2
        endif
    endif
    let val = val * (1 + len(a:cfg.base) / len(a:word))
    return [val, a:word]
endf


function! s:AssessWordInContext(word, context, words) "{{{3
    let v = 1
    for word in a:words
        let c = get(a:context, word, 0)
        let v += c
    endfor
    return v
endf


function! s:CompareRev0(i1, i2) "{{{3
    let i1 = a:i1[0]
    let i2 = a:i2[0]
    return i1 == i2 ? 0 : i1 > i2 ? -1 : 1
endf

