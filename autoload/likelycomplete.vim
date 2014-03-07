" @Author:      Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Revision:    227


if !exists('g:loaded_tlib') || g:loaded_tlib < 107
    runtime plugin/02tlib.vim
    if !exists('g:loaded_tlib') || g:loaded_tlib < 107
        echoerr 'tlib >= 1.07 is required'
        finish
    endif
endif


if !exists('g:likelycomplete#select_imap')
    " The default map for |:Likelycompletemapselect|.
    " If non-empty, enable |:Likelycompletemapselect| for all enabled 
    " filetypes.
    let g:likelycomplete#select_imap = ''   "{{{2
endif


if !exists('g:likelycomplete#use_omnifunc')
    " If true, |likelycomplete#GetCompletions()| also offers completions 
    " from 'omnifunc'.
    " Please be aware that some omnifunc take their time (at least on 
    " first invocation).
    let g:likelycomplete#use_omnifunc = 0   "{{{2
endif


if !exists('g:likelycomplete#use_fuzzy_matches')
    " If true, use fuzzy matches for |:Likelycompletemapselect| 
    " and |:Likelycompletemapcompletefunc|.
    " In order to also use fuzzy search in the list picker, also set 
    " |g:tlib#input#filter_mode| to 'fuzzy'.
    let g:likelycomplete#use_fuzzy_matches = 0   "{{{2
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


let g:likelycomplete#data = tlib#persistent#Get(g:likelycomplete#data_cfile, {'version': 1, 'ft': {}, 'ft_options': {}})   "{{{2


if !exists('g:likelycomplete#options_vim')
    " Some custom options for the vim filetype.
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


if !exists('g:likelycomplete#base')
    " The base number of observations.
    " Also the number of files, you can edit without removing a word 
    " that was't included in any of these files.
    " If this value is too low, new words won't get a chance to be 
    " included in the list.
    let g:likelycomplete#base = 1   "{{{2
endif


if !exists('g:likelycomplete#max')
    " The maximum number of observations taken into account.
    let g:likelycomplete#max = 10000   "{{{2
endif


function! likelycomplete#SetupFiletype(filetype, options) "{{{3
    call likelycomplete#EnsureFiletype(a:filetype)
    call likelycomplete#SetupBuffer(a:filetype, bufnr('%'))
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


function! likelycomplete#SetupBuffer(filetype, bufnr) "{{{3
    " TLogVAR a:bufnr
    if !likelycomplete#EnsureFiletype(a:filetype)
        call s:SetDerivedOptions(a:filetype)
    endif
    call s:SetupComplete(a:filetype)
    if !empty(g:likelycomplete#select_imap)
        call likelycomplete#MapSelectWord(g:likelycomplete#select_imap)
    endif
    exec 'autocmd LikelyComplete BufUnload <buffer='. a:bufnr .'> call s:UpdateWordList('. a:bufnr .','. string(a:filetype) .','. string(expand('%:p')) .')'
endf


function! likelycomplete#Config(filetype, options) "{{{3
    if !has_key(g:likelycomplete#data.ft_options, a:filetype)
        let g:likelycomplete#data.ft_options[a:filetype] = {}
    endif
    if !empty(a:options)
        call extend(g:likelycomplete#data.ft_options[a:filetype], a:options)
    endif
    call s:SetDerivedOptions(a:filetype)
endf


function! s:SetDerivedOptions(filetype) "{{{3
    " TLogVAR a:filetype, &ft
    if &ft == a:filetype && !has_key(g:likelycomplete#data.ft_options[a:filetype], 'cms')
        let g:likelycomplete#data.ft_options[a:filetype].cms = &cms
    endif
endf


function! likelycomplete#EnsureFiletype(filetype) "{{{3
    if !has_key(g:likelycomplete#data.ft, a:filetype)
        " TLogVAR a:filetype
        let g:likelycomplete#data.ft[a:filetype] = {}
        call likelycomplete#Config(a:filetype, {})
        call LikelycompleteSetupFiletype(a:filetype)
        call likelycomplete#SaveFiletypes()
        return 1
    else
        return 0
    endif
endf


function! likelycomplete#RemoveFiletype(filetype) "{{{3
    " TLogVAR a:filetype
    unlet! g:likelycomplete#data.ft[a:filetype]
    unlet! g:likelycomplete#data.ft_options[a:filetype]
    let fname = s:WordListFilename(a:filetype)
    if filereadable(fname)
        call delete(fname)
    endif
    call likelycomplete#SaveFiletypes()
    echom "LikelyComplete: Removed support for" a:filetype
endf


function! likelycomplete#SaveFiletypes() "{{{3
    call tlib#persistent#Save(g:likelycomplete#data_cfile, g:likelycomplete#data)
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
            exec 'setl complete+='. escape(opt, ' ,')
            " TLogVAR &l:complete
        endif
    endif
endf


function! s:FtOptions(filetype) "{{{3
    let ft_options = get(g:likelycomplete#data.ft_options, a:filetype, {})
    " TLogVAR 1, ft_options
    if exists('g:likelycomplete#options_'. a:filetype)
        call extend(ft_options, g:likelycomplete#options_{a:filetype})
    endif
    " TLogVAR 2, ft_options
    return ft_options
endf


function! s:UpdateWordList(bufnr, filetype, filename) "{{{3
    " TLogVAR a:bufnr, a:filetype, a:filename, bufnr('%')
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
        let cms_rx = substitute(ft_options.cms, '%s', '.\\{-}', '')
        let cms_rx = '^\s*'. cms_rx .'$'
        " TLogVAR cms_rx
        let lines = filter(lines, 'v:val !~ cms_rx')
        " TLogVAR 4, len(lines)
    endif
    let text = join(lines)
    if get(ft_options, 'strip_strings', 1)
        let text = substitute(text, '\([''"]\).\{-}\1', ' ', 'g')
    endif
    let rx = get(ft_options, 'keyword_rx', '\k\+')
    " TLogVAR rx
    let words = split(text, rx .'\zs')
    let words = map(words, 'matchstr(v:val, rx)')
    " TLogVAR 1, len(words)
    let words = filter(words, '!empty(v:val) && strwidth(v:val) >= g:likelycomplete#word_minlength')
    " TLogVAR 2, len(words)
    if get(ft_options, 'strip_numbers', 1)
        let words = filter(words, 'v:val !~ ''^-\?\d\+\(\.\d\+\)\?$''')
        " TLogVAR 3, len(words)
    endif
    let data = g:likelycomplete#data.ft[a:filetype]
    " TLogVAR words
    if !empty(words)
        let wordds = {}
        for word in words
            let wordds[word] = 1
            if has_key(data, word)
                let obs = data[word].obs
                if obs < g:likelycomplete#max
                    let data[word].obs = obs + 1
                elseif data[word].n > 1
                    let data[word].n -= 1
                endif
            else
                let data[word] = {'obs': g:likelycomplete#base, 'n': g:likelycomplete#base}
            endif
        endfor
        for word in filter(keys(data), '!has_key(wordds, v:val)')
            if data[word].n < g:likelycomplete#max
                let data[word].n += 1
            elseif data[word].obs > 1
                let data[word].obs -= 1
            endif
        endfor
        let g:likelycomplete#data.ft[a:filetype] = data
        if !s:WriteWordList(a:filetype)
            call likelycomplete#SaveFiletypes()
        endif
    endif
endf


function! s:WriteWordList(filetype) "{{{3
    " TLogVAR a:filetype
    let data = get(g:likelycomplete#data.ft, a:filetype, {})
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
            let g:likelycomplete#data.ft[a:filetype] = data
            call likelycomplete#SaveFiletypes()
            let saved_data = 1
        endif
    endif
    return saved_data
endf


function! likelycomplete#RemoveWords(...) "{{{3
    let filetype = a:0 >= 1 && !empty(a:1) ? a:1 : &filetype
    let data = get(g:likelycomplete#data.ft, filetype, {})
    if !empty(data)
        let words0 = sort(keys(data))
        let words1 = tlib#input#List('m', 'Select obsolete words', words0)
        if !empty(words1)
            for word in words1
                call remove(data, word)
            endfor
            let g:likelycomplete#data.ft[filetype] = data
            if !s:WriteWordList(filetype)
                call likelycomplete#SaveFiletypes()
            endif
        endif
    endif
endf


function! likelycomplete#MapSelectWord(imap) "{{{3
    let imap = empty(a:imap) ? g:likelycomplete#select_imap : a:imap
    if !empty(imap)
        exec 'inoremap' imap '<C-S-Left><DEL><C-r>=likelycomplete#SelectWord(@")<cr>'
    endif
endf


function! likelycomplete#SelectWord(base) "{{{3
    let words = likelycomplete#GetCompletions(&filetype, a:base)
    let word = tlib#input#List('s', 'Select word:', words)
    if empty(word)
        return a:base
    else
        return word
    endif
endf


function! likelycomplete#SetComleteFunc() "{{{3
    let b:likely_completefunc = &l:completefunc
    setl completefunc=likelycomplete#Complete
endf


function! likelycomplete#Complete(findstart, base) "{{{3
    if a:findstart
        let line = strpart(getline('.'), 0, col('.') - 1)
        let start = match(line, '\k\+$')
        return start
    else
        return likelycomplete#GetCompletions(&filetype, a:base)
    endif
endf


function! likelycomplete#GetCompletions(filetype, base) "{{{3
    let completions = []
    let fns = []
    if exists('b:likely_completefunc')
        call add(fns, b:likely_completefunc)
    endif
    if g:likelycomplete#use_omnifunc
        call add(fns, &l:omnifunc)
    endif
    for fn in fns
        if !empty(fn)
            let completions += call(fn, [0, a:base])
        endif
    endfor
    for var in g:likelycomplete#other_sources
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
    let fname = s:WordListFilename(a:filetype)
    if filereadable(fname)
        let completions += readfile(fname)
    endif
    if !empty(a:base)
        if g:likelycomplete#use_fuzzy_matches
            let rx = '\V'. join(map(split(a:base, '\zs'), 'escape(v:val, ''\'')'), '\.\{-}')
            let completions = filter(completions, 'v:val =~ rx')
        else
            let epos = len(a:base) - 1
            let completions = filter(completions, 'v:val[0 : epos] == a:base')
        endif
    endif
    return completions
endf


