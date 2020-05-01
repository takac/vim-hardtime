" hardtime.vim
" Author: Tom Cammann <cammann.tom@gmail.com>
" Site: https://github.com/takac/vim-hardtime
" Version: 0.4

if exists("g:HardTime_loaded")
    finish
endif
let g:HardTime_loaded = 1

fun! s:check_defined(variable, default)
	if !exists(a:variable)
		let {a:variable} = a:default
	endif
endf

call s:check_defined("g:list_of_visual_keys", ["h", "j", "k", "l", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"])
call s:check_defined("g:list_of_normal_keys", ["h", "j", "k", "l", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"])
call s:check_defined("g:list_of_insert_keys", ["<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"])
call s:check_defined("g:list_of_disabled_keys", [])

call s:check_defined("g:hardtime_default_on", 0)
call s:check_defined("g:hardtime_ignore_buffer_patterns", [])
call s:check_defined("g:hardtime_ignore_quickfix", 0)
call s:check_defined("g:hardtime_timeout", 1000)
call s:check_defined("g:hardtime_showmsg", 0)
call s:check_defined("g:hardtime_showerr", 0)
call s:check_defined("g:hardtime_allow_different_key", 0)
call s:check_defined("g:hardtime_maxcount", 1)

" Start hardtime in every buffer
if g:hardtime_default_on
	autocmd BufRead,BufNewFile * call s:HardTime()
endif

let s:lasttime = 0
let s:lastkey = ''
let s:lastcount = 0

fun! s:HardTime()
    let ignoreBuffer = s:IsIgnoreBuffer()
    let ignoreQuickfix = s:IsIgnoreQuickfix()
    if !ignoreBuffer && !ignoreQuickfix
      call HardTimeOn()
    endif
endf

fun! s:RetrieveMapping(key, mode)
    let mapping = maparg(a:key, a:mode, 0, 1)
    if !has_key(mapping, "rhs") || mapping["rhs"] == ""
        return "'" . a:key . "'"
    endif
    " If mapping is an expression, don't quote
    if mapping["expr"]
        return mapping["rhs"]
    endif
    return "'" . mapping["rhs"] . "'"
endf

fun! HardTimeOn()
	call s:check_defined("b:hardtime_on", 0)
    " Prevents from mapping keys recursively
    if b:hardtime_on == 0
        let b:hardtime_on = 1
        for i in g:list_of_normal_keys
            let ii = substitute(i, "<", "<lt>", "")
            exec "nnoremap <buffer> <silent> <expr> " . i . " TryKey('" . i . "') ? " . s:RetrieveMapping(i, "n") . " : TooSoon('" . ii . "','n')"
        endfor
        for i in g:list_of_visual_keys
            let ii = substitute(i, "<", "<lt>", "")
            exec "xnoremap <buffer> <silent> <expr> " . i . " TryKey('" . i . "') ? " . s:RetrieveMapping(i, "x") . " : TooSoon('" . ii . "','x')"
        endfor
        for i in g:list_of_insert_keys
            let ii = substitute(i, "<", "<lt>", "")
            exec "inoremap <buffer> <silent> <expr> " . i . " TryKey('" . i . "') ? " . s:RetrieveMapping(i, "i") . " : TooSoon('" . ii . "','i')"
        endfor
        for i in g:list_of_disabled_keys
            exec "nnoremap <buffer> <silent> <expr> " . i . " pumvisible()?'" . i . "':''"
            exec "xnoremap <buffer> <silent> <expr> " . i . " pumvisible()?'" . i . "':''"
            exec "inoremap <buffer> <silent> <expr> " . i . " pumvisible()?'" . i . "':''"
        endfor
    endif
endf

fun! HardTimeOff()
    let b:hardtime_on = 0
    for i in g:list_of_normal_keys
        exec "silent! nunmap <buffer> " . i
    endfor
    for i in g:list_of_visual_keys
        exec "silent! xunmap <buffer> " . i
    endfor
    for i in g:list_of_insert_keys
        exec "silent! iunmap <buffer> " . i
    endfor
    for i in g:list_of_disabled_keys
        exec "silent! nunmap <buffer> " . i
        exec "silent! xunmap <buffer> " . i
        exec "silent! iunmap <buffer> " . i
    endfor
endf


fun! HardTimeToggle()
	call s:check_defined("b:hardtime_on", 0)
    if b:hardtime_on
        call HardTimeOff()
		if g:hardtime_showmsg
			echo "Hard time off"
		endif
    else
        call HardTimeOn()
        if g:hardtime_showmsg
            echo "Hard time on"
        end
    endif
endf


fun! TryKey(key)
    if pumvisible()
        return 1
    endif
    let now = GetNow()
    if (now > s:lasttime + g:hardtime_timeout/1000) || (g:hardtime_allow_different_key && a:key != s:lastkey) ||
    \ (s:lastcount < g:hardtime_maxcount)
        if (now > s:lasttime + g:hardtime_timeout/1000) || (g:hardtime_allow_different_key && a:key != s:lastkey)
            let s:lastcount = 1
        else
            let s:lastcount += 1
        endif
        let s:lasttime = now
        let s:lastkey = a:key
        return 1
    else
        return 0
    endif
endf

fun! s:IsIgnoreBuffer()
    let name = bufname("%")
    for i in g:hardtime_ignore_buffer_patterns
        if name =~ i
            return 1
        endif
    endfor
    return 0
endf

fun! s:IsIgnoreQuickfix()
    if g:hardtime_ignore_quickfix && getbufvar(winbufnr("%"), '&buftype') == "quickfix"
        return 1
    endif
    return 0
endf

fun! TooSoon(key, mode)
    if g:hardtime_showmsg
        echomsg "Hard time is enabled for " . a:key . " in " . a:mode
    endif
    if g:hardtime_showerr
        echoerr "Hard time is enabled for " . a:key . " in " . a:mode
    endif
    return ""
endf

fun! GetNow()
    return reltimestr(reltime())
endf

command! HardTimeOn call HardTimeOn()
command! HardTimeOff call HardTimeOff()
command! HardTimeToggle call HardTimeToggle()
