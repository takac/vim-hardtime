" hardtime.vim
" Author: Tom Cammann <cammann.tom@gmail.com>
" Site: https://github.com/takac/vim-hardtime
" Version: 0.4

if exists("g:HardTime_loaded")
    finish
endif
let g:HardTime_loaded = 1

" List of keys to block
if !exists("g:list_of_visual_keys")
    let g:list_of_visual_keys = [ "h", "j", "k", "l", "-",
                     \ "+","<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
endif
if !exists("g:list_of_normal_keys")
    let g:list_of_normal_keys = [ "h", "j", "k", "l", "-",
                     \ "+","<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
endif

" Allow to ignore certain buffer patterns.
if !exists("g:hardtime_ignore_buffer_patterns")
    let g:hardtime_ignore_buffer_patterns = []
endif

" Timeout in seconds between keystrokes
if !exists("g:hardtime_timeout")
    let g:hardtime_timeout = 1000
endif

if !exists("g:hardtime_showmsg")
    let g:hardtime_showmsg = 0
endif

if !exists("g:hardtime_allow_different_key")
    let g:hardtime_allow_different_key = 0
endif

if !exists("g:hardtime_maxcount")
    let g:hardtime_maxcount = 1
endif

" Start hardtime in every buffer
if exists("g:hardtime_default_on")
    if g:hardtime_default_on
        autocmd BufRead,BufNewFile * call s:HardTime()
    endif
endif

let s:lasttime = 0
let s:lastkey = ''
let s:lastcount = 0

fun! s:HardTime()
    let ignoreBuffer = s:IsIgnoreBuffer()
    if !ignoreBuffer
      call HardTimeOn()
    endif
endf

fun! HardTimeOff()
    let b:hardtime_on = 0
    for i in g:list_of_normal_keys
        exec "silent! nunmap <buffer> " . i
    endfor
    for i in g:list_of_visual_keys
        exec "silent! vunmap <buffer> " . i
    endfor
    if g:hardtime_showmsg
        echo "Hard time off"
    endif
endf

fun! HardTimeOn()
    if !exists("b:hardtime_on")
        let b:hardtime_on = 0
    endif
    " Prevents from mapping keys recursively
    if b:hardtime_on == 0
        let b:hardtime_on = 1
        for i in g:list_of_normal_keys
            exec "nnoremap <buffer> <silent> <expr> " . i . " TryKey('" . i . "') ? '" . (maparg(i, "n") != "" ? maparg(i, "n") : i) . "' : TooSoon()"
        endfor
        for i in g:list_of_visual_keys
            exec "xnoremap <buffer> <silent> <expr> " . i . " TryKey('" . i . "') ? '" . (maparg(i, "v") != "" ? maparg(i, "v") : i) . "' : TooSoon()"
        endfor
        if g:hardtime_showmsg
            echo "Hard time on"
        end
    endif
endf

fun! HardTimeToggle()
    if !exists("b:hardtime_on")
        let b:hardtime_on = 0
    endif
    if b:hardtime_on
        call HardTimeOff()
    else
        call HardTimeOn()
    endif
endf


fun! TryKey(key)
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


fun! TooSoon()
    if g:hardtime_showmsg
        echomsg "Hard time is enabled"
    endif
    return ""
endf

fun! GetNow()
    return reltimestr(reltime())
endf

command! HardTimeOn call HardTimeOn()
command! HardTimeOff call HardTimeOff()
command! HardTimeToggle call HardTimeToggle()
