" @Author:      Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Revision:    557


if !exists('g:loaded_tlib') || g:loaded_tlib < 107
    runtime plugin/02tlib.vim
    if !exists('g:loaded_tlib') || g:loaded_tlib < 107
        echoerr 'tlib >= 1.07 is required'
        finish
    endif
endif


if !exists('g:likelycomplete#experimental')
    " If true, enable some experimental options.
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
    let g:likelycomplete#set_completefunc = g:likelycomplete#experimental   "{{{2
endif


if !exists('g:likelycomplete#auto_complete')
    " The number of characters after which auto-completion should be 
    " invoked. If 0, auto-completion is disabled.
    "
    " This option requires |g:likelycomplete#set_completefunc| to be 
    " true or |:Likelycompletemapcompletefunc| to be called.
    let g:likelycomplete#auto_complete = g:likelycomplete#experimental ? 2 : 0  "{{{2
endif


if !exists('g:likelycomplete#use_omnifunc')
    " If true, include completions from 'omnifunc'.
    " Please be aware that some omnifunc take their time (at least on 
    " first invocation).
    " This is only used in conjunction with |:Likelycompletemapselect| 
    " and |:Likelycompletemapcompletefunc|.
    let g:likelycomplete#use_omnifunc = 0   "{{{2
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
    " 1. Select a single item from a list:
    "     likelycomplete#SingleSelect_{TYPE}(prompt, list, ?handlers=[])
    "
    " 2. Select multiple item from a list:
    "     likelycomplete#MultiSelect_{TYPE}(prompt, list)
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
    "                        supported for all filetypes; requires 'cms' to be 
    "                        set)
    "   strip_strings ...... Remove strings from lines
    "   strip_numbers ...... Remove numbers from lines
    "   strip_rx ........... Remove matching text from lines
    "
    " The following keys can override global parameters:
    "   other_sources ...... Override |g:likelycomplete#other_sources|
    "   set_completefunc ... Override |g:likelycomplete#set_completefunc|
    "   auto_complete ...... Override |g:likelycomplete#auto_complete|
    "   use_omnifunc ....... Override |g:likelycomplete#use_omnifunc|
    "   use_fuzzy_matches .. Override |g:likelycomplete#use_fuzzy_matches|
    "   match_beginning .... Override |g:likelycomplete#match_beginning|
    "   maxsize ............ Override |g:likelycomplete#maxsize|
    "   once_per_file ...... Override |g:likelycomplete#once_per_file|
    "   assess_context ..... Override |g:likelycomplete#assess_context|
    "   word_minlength ..... Override |g:likelycomplete#word_minlength|
    let g:likelycomplete#options = {}
endif


if !exists('g:likelycomplete#options_vim')
    " Some custom options for the vim filetype (see 
    " |g:likelycomplete#options|).
    " Anything following a single or double quote is removed. This will 
    " make sure that all strings an comments are removed -- at the cost 
    " of also removing eligible identifiers following a string.
    " :read: let g:likelycomplete#options_vim = {...}   "{{{2
    let g:likelycomplete#options_vim = {
                \ 'strip_rx': '["''].*$',
                \ 'strip_strings': 0,
                \ 'strip_comments': 0,
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
    let g:likelycomplete#assess_context = g:likelycomplete#experimental && !g:likelycomplete#once_per_file ? 5 : 0   "{{{2
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


let s:likelycomplete_data = tlib#persistent#Get(g:likelycomplete#data_cfile, {'version': 1, 'ft': {}, 'ft_options': {}})   "{{{2
" let g:likelycomplete#data = s:likelycomplete_data " DBG


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
    " TLogVAR 1, ft_options
    call extend(ft_options, g:likelycomplete#options)
    if exists('g:likelycomplete#options_'. a:filetype)
        call extend(ft_options, g:likelycomplete#options_{a:filetype})
    endif
    " TLogVAR 2, ft_options
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
    call s:EnsureFiletype(a:filetype, a:options)
    call likelycomplete#SetupBuffer(a:filetype, bufnr('%'))
endf


function! likelycomplete#SetupBuffer(filetype, bufnr) "{{{3
    " TLogVAR a:bufnr
    if !s:EnsureFiletype(a:filetype)
        call s:SetDerivedOptions(a:filetype)
    endif
    call s:SetupComplete(a:filetype)
    if !empty(g:likelycomplete#select_imap)
        call likelycomplete#MapSelectWord(g:likelycomplete#select_imap)
    endif
    exec 'autocmd LikelyComplete BufUnload <buffer='. a:bufnr .'> call s:UpdateWordList('. a:bufnr .','. string(a:filetype) .','. string(expand('%:p')) .')'
endf


function! s:SetFiletypeOptions(filetype, options) "{{{3
    if !has_key(s:likelycomplete_data.ft_options, a:filetype)
        let s:likelycomplete_data.ft_options[a:filetype] = {}
    endif
    if !empty(a:options)
        call extend(s:likelycomplete_data.ft_options[a:filetype], a:options)
    endif
    call s:SetDerivedOptions(a:filetype)
endf


function! s:GetFiletype() "{{{3
    return exists('b:likelycomplete_filetype') ? b:likelycomplete_filetype : &l:filetype
endf


function! s:SetDerivedOptions(filetype) "{{{3
    " TLogVAR a:filetype
    if s:GetFiletype() == a:filetype
        let ft_options = s:likelycomplete_data.ft_options[a:filetype]
        if !has_key(ft_options, 'cms')
            let s:likelycomplete_data.ft_options[a:filetype].cms = &l:cms
        endif
        if !empty(&l:iskeyword) && (!has_key(ft_options, '_split_rx') || get(ft_options, '_iskeyword', '') != &l:iskeyword)
            let s:likelycomplete_data.ft_options[a:filetype]._iskeyword = &l:iskeyword
            let s:likelycomplete_data.ft_options[a:filetype]._split_rx = s:GetKeywordRx(&l:iskeyword, 1)
            " TLogVAR &l:iskeyword, s:likelycomplete_data.ft_options[a:filetype]._split_rx
        endif
        " TLogVAR s:likelycomplete_data.ft_options[a:filetype]
    endif
endf


function! s:GetKeywordRx(iskeyword, inverse) "{{{3
    " TLogVAR a:iskeyword, a:inverse
    let parts = map(split(a:iskeyword, ','), 's:KeywordPartRx(split(v:val, ''-''), 0)')
    " TLogVAR parts
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
    " TLogVAR pos, neg
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
    " TLogVAR rx
    return rx
endf


function! s:KeywordPartRx(subparts, inverse) "{{{3
    " TLogVAR a:subparts
    if len(a:subparts) > 2
        throw "KeywordPartRx: Internal error: ". string(a:subparts)
    endif
    let subparts = map(a:subparts, 'v:val =~ ''^\d\+$'' ? nr2char(v:val) : v:val')
    " TLogVAR subparts
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


function! s:EnsureFiletype(...) "{{{3
    let filetype = a:0 >= 1 ? a:1 : s:GetFiletype()
    let options  = a:0 >= 2 ? a:2 : {}
    if !has_key(s:likelycomplete_data.ft, filetype)
        " TLogVAR filetype
        call s:SetData(filetype, {})
        call s:SetFiletypeOptions(filetype, options)
        call LikelycompleteSetupFiletype(filetype)
        call s:SaveData()
        return 1
    else
        return 0
    endif
endf


function! likelycomplete#RemoveFiletype(filetype) "{{{3
    " TLogVAR a:filetype
    unlet! s:likelycomplete_data.ft[a:filetype]
    unlet! s:likelycomplete_data.ft_options[a:filetype]
    let fname = s:WordListFilename(a:filetype)
    if filereadable(fname)
        call delete(fname)
    endif
    call s:SaveData()
    echom "LikelyComplete: Removed support for" a:filetype
endf


function! s:SaveData() "{{{3
    call tlib#persistent#Save(g:likelycomplete#data_cfile, s:likelycomplete_data)
endf


function! s:WordListFilename(filetype) "{{{3
    " TLogVAR a:filetype
    let dir = fnamemodify(g:likelycomplete#data_cfile, ':p:h')
    let fname = tlib#file#Join([dir, a:filetype .'_words'])
    " TLogVAR fname
    return fname
endf


function! s:SetupComplete(filetype) "{{{3
    " TLogVAR a:filetype
    let fname = s:WordListFilename(a:filetype)
    if filereadable(fname)
        let opt = 'k'. fname
        if stridx(&l:complete, opt) == -1
            exec 'setl complete+='. escape(opt, ' ,\')
            " TLogVAR &l:complete
        endif
        if stridx(&l:dictionary, fname) == -1
            exec 'setl dictionary+='. escape(fname, ' ,\')
            " TLogVAR &l:dictionary
        endif
    endif
    let ft_options = s:FtOptions(a:filetype)
    if get(ft_options, 'set_completefunc', g:likelycomplete#set_completefunc)
        call likelycomplete#SetComleteFunc()
        if get(ft_options, 'auto_complete', g:likelycomplete#auto_complete)
            autocmd LikelyComplete CursorMovedI <buffer> if !pumvisible() | call s:AutoComplete() | endif
        endif
    endif
endf


function! s:Tokenize(ft_options, text) "{{{3
    let text = a:text
    if get(a:ft_options, 'strip_strings', 1)
        let text = substitute(text, '\([''"]\).\{-}\1', ' ', 'g')
    endif
    let _split_rx = get(a:ft_options, '_split_rx', '\W\+')
    " TLogVAR _split_rx
    return split(text, _split_rx)
endf


function! s:UpdateWordList(bufnr, filetype, filename) "{{{3
    " TLogVAR a:bufnr, a:filetype, a:filename, bufnr('%')
    if getbufvar(a:bufnr, 'likelycomplete_done', 0)
        return
    endif
    let ft_options = s:FtOptions(a:filetype)
    " TLogVAR ft_options
    if bufnr('%') == a:bufnr
        let lines = getline(1, line('$'))
    elseif filereadable(a:filename)
        let lines = readfile(a:filename)
    else
        return
    endif
    " TLogVAR 1, len(lines)
    let exclude_lines_rx = get(ft_options, 'exclude_lines_rx', '')
    " TLogVAR exclude_lines_rx
    if !empty(exclude_lines_rx)
        let lines = filter(lines, 'v:val !~ exclude_lines_rx')
        " TLogVAR 2, len(lines)
    endif
    let strip_rx = get(ft_options, 'strip_rx', '')
    " TLogVAR strip_rx
    if !empty(strip_rx)
        let lines = map(lines, 'substitute(v:val, strip_rx, " ", "g")')
        " TLogVAR 3, len(lines)
    endif
    if get(ft_options, 'strip_comments', 1) && has_key(ft_options, 'cms')
        let cms_rx = '\V'. substitute(escape(ft_options.cms, '\'), '%s', '\\.\\{-}', '') .'\.\*\$'
        " TLogVAR cms_rx
        let lines = filter(lines, 'v:val !~ cms_rx')
        " TLogVAR 4, len(lines)
    endif
    let words = s:Tokenize(ft_options, join(lines))
    " TLogVAR words
    " TLogVAR 1, len(words)
    let word_minlength = get(ft_options, 'word_minlength', g:likelycomplete#word_minlength)
    let words = filter(words, '!empty(v:val) && strwidth(v:val) >= word_minlength')
    " TLogVAR 2, len(words)
    if get(ft_options, 'strip_numbers', 1)
        let words = filter(words, 'v:val !~ ''^-\?\d\+\(\.\d\+\)\?$''')
        " TLogVAR 3, len(words)
    endif
    " TLogVAR words
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
            let context_words = []
        endif
        let iword = 0
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
            if assess_context > 0
                let worddef.context = s:AssessContext(get(worddef, 'context', {}), context_words)
                call add(context_words, word)
                if len(context_words) > assess_context
                    call remove(context_words, 0)
                endif
            endif
            let data[word] = worddef
            let iword += 1
        endfor
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
    call setbufvar(a:bufnr, 'likelycomplete_done', 1)
endf


function! s:AssessContext(context, words) "{{{3
    let old_words = deepcopy(a:context)
    for word in a:words
        " TLogVAR word
        let n = get(a:context, word, 0)
        if n > 0
            " TLogVAR old_words
            let old_words[word] = -1
        endif
        if n < g:likelycomplete#max
            let a:context[word] = n + 1
        endif
    endfor
    for [word, val] in items(old_words)
        if val == -1
            let n = get(a:context, word, 0)
            if n > 0
                let a:context[word] = n - 1
            endif
        endif
    endfor
    return a:context
endf


function! s:WriteWordList(filetype) "{{{3
    " TLogVAR a:filetype
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
        " TLogVAR fname, len(words)
        call writefile(words, fname)
        if !empty(truncated)
            " TLogVAR truncated
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


function! likelycomplete#SingleSelect_tlib(prompt, list, ...) "{{{3
    let args = ['s', a:prompt, a:list] + a:000
    return call('tlib#input#List', args)
endf


function! likelycomplete#MultiSelect_tlib(prompt, list) "{{{3
    return tlib#input#List('m', a:prompt, a:list)
endf


function! likelycomplete#RemoveWords(...) "{{{3
    let filetype = a:0 >= 1 && !empty(a:1) ? a:1 : s:GetFiletype()
    let data = s:GetData(filetype)
    if !empty(data)
        let words0 = sort(keys(data))
        let words1 = likelycomplete#MultiSelect_{g:likelycomplete#list_picker}('Select obsolete words', words0)
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
    let words = s:GetCompletions(filetype, a:base, 0)
    let handlers = []
    if g:likelycomplete#list_set_filter
        call add(handlers, {'filter': s:GetVFilter(filetype, a:base)})
    endif
    let word = likelycomplete#SingleSelect_{g:likelycomplete#list_picker}('Select word:', words, handlers)
    if empty(word)
        return a:base
    else
        return word
    endif
endf


function! likelycomplete#SetComleteFunc() "{{{3
    call s:EnsureFiletype()
    if exists('+completefunc')
        let b:likelycomplete_completefunc = &l:completefunc
        setl completefunc=likelycomplete#Complete
    endif
endf


function s:AutoComplete()
    if exists('b:likelycomplete_completefunc')
        let filetype = s:GetFiletype()
        let ft_options = s:FtOptions(filetype)
        let auto_complete = get(ft_options, 'auto_complete', g:likelycomplete#auto_complete)
        let start = likelycomplete#Complete(1, '')
        if start >= 0 && col('.') - start > auto_complete
            call feedkeys("\<c-x>\<c-u>", 't') 
        endif
    endif
endf


function! likelycomplete#Complete(findstart, base) "{{{3
    if a:findstart
        let line = strpart(getline('.'), 0, col('.') - 1)
        let start = match(line, '\k\+$')
        return start
    else
        return s:GetCompletions(s:GetFiletype(), a:base, 1)
    endif
endf


function! s:GetCompletions(filetype, base, check_auto_complete) "{{{3
    let completions = []
    let ft_options = s:FtOptions(a:filetype)
    let fname = s:WordListFilename(a:filetype)
    if filereadable(fname)
        let completions += readfile(fname)
    endif
    let fns = []
    if exists('b:likelycomplete_completefunc')
        call add(fns, b:likelycomplete_completefunc)
    endif
    if exists('+omnifunc') && get(ft_options, 'use_omnifunc', g:likelycomplete#use_omnifunc)
        call add(fns, &l:omnifunc)
    endif
    for fn in fns
        if !empty(fn)
            let completions += call(fn, [0, a:base])
        endif
    endfor
    for var in get(ft_options, 'other_sources', g:likelycomplete#other_sources)
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
    if !empty(a:base)
        let lbase = len(a:base)
        let rx = s:GetVFilter(a:filetype, a:base)
        let completions = filter(completions, 'len(v:val) > lbase && v:val =~ rx')
    endif
    if get(ft_options, 'assess_context', g:likelycomplete#assess_context)
        let completions = s:GetWordsSortedByRelevance(a:filetype, a:base, ft_options, completions)
    endif
    if a:check_auto_complete && get(ft_options, 'auto_complete', g:likelycomplete#auto_complete)
        let completions = insert(completions, a:base)
    endif
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


function! s:GetWordsSortedByRelevance(filetype, base, ft_options, words) "{{{3
    " TLogVAR len(a:words)
    let line = getline('.')[0 : col('.') - 1]
    let line = substitute(line, '\(^\s\+\|\s\+$\)', '', 'g')
    let cfg = {
                \ 'base_rx': escape(a:base, '\'),
                \ 'bbase_rx': '\V\^'. escape(a:base, '\'),
                \ 'words': s:Tokenize(a:ft_options, line),
                \ 'match_beginning': get(a:ft_options, 'match_beginning', g:likelycomplete#match_beginning),
                \ 'use_omnifunc': get(a:ft_options, 'use_omnifunc', g:likelycomplete#use_omnifunc),
                \ 'data': s:GetData(a:filetype),
                \ }
    " TLogVAR cfg.base_rx
    let assessed_words = map(copy(a:words), 's:AddRelevance(v:val, cfg)')
    let sorted_words = sort(assessed_words, 's:CompareRev0')
    " TLogVAR sorted_words
    let sorted_words = map(sorted_words, 'v:val[1]')
    return sorted_words
endf


function! s:AddRelevance(word, cfg) "{{{3
    let worddef = get(a:cfg.data, a:word, {})
    let val = 0
    if !empty(worddef)
        let ac = s:AssessWordInContext(get(worddef, 'context', {}), a:cfg.words)
        if ac != 0
            let val = 0.0 + g:likelycomplete#max + ac
        else
            let av = (0.0 + worddef.obs) / worddef.n
            if av > g:likelycomplete#max
                let val = 0.0 + g:likelycomplete#max
            else
                let val = av
            endif
        endif
    endif
    if !a:cfg.match_beginning && a:word =~ a:cfg.bbase_rx
        let val = val * 1.2
    elseif a:cfg.use_omnifunc && a:word =~ a:cfg.base_rx
        let val = val * 1.1
    endif
    return [val, a:word]
endf


function! s:AssessWordInContext(context, words) "{{{3
    let v = 0
    for word in a:words
        let v += get(a:context, word, 0)
    endfor
    return v
endf


function! s:CompareRev0(i1, i2) "{{{3
    let i1 = a:i1[0]
    let i2 = a:i2[0]
    return i1 == i2 ? 0 : i1 > i2 ? -1 : 1
endf

