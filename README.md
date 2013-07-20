# Hardtime

Hardtime helps you break that annoying habit vimmers have of scrolling up and
down the page using `jjjjj` and `kkkkk` but without comprimising the rest of our vim
experience.

It works using a timeout on the keys you want to stop repeating, i.e. `h`, `j`, `k`, `l`, `UP`, `DOWN`, `LEFT`, `RIGHT`.
This timeout is set to 1 second. After 1 second you can use a movement key again.

Stop repeating jjjjj...
Stop repeating kkkk...

Kick the habit now!

Inspired by [vim-hardmode](https://github.com/wikitopian/hardmode), but where
hardmode fell short was that sometimes `h,j,k,l` are needed! Hardtime lets you use
these keys but only once every second. You can still create macros in hardtime
where you need to move down lines, and you can still move that one character
over to make that edit.

### Usage

Once installed you can all the command `:HardTimeOn` to active hardtime,
conversely you can use `:HardTimeOff` to swtich it off. You can also use
`:HardTimeToggle` toggle it on an off.

If you want hardtime to run in every buffer you can set `let
g:hardtime_default_on = 1` in your `.vimrc`.

You can also set the list of keys you want to use with hardtime with the
`g:list_of_normal_keys` and `g:list_of_visual_keys` variables. These are both
initially set to `h`, `j`, `k`, `l`, `-`, `+`,`<UP>`, `<DOWN>`, `<LEFT>`, `<RIGHT>`.

You can also tweak the timeout using `g:HardTime_loaded`, however is not much
granularity using the current method of timing.

Also you can suppress notification about HardTime enabled with `let g:hardtime_showmsg = 0`.

### Installation
I recommend installing using [Vundle](https://github.com/gmarik/vundle):

Add `Bundle 'takac/vim-hardtime'` to your `~/.vimrc` and then:

* either within Vim: `:BundleInstall`
* or in your shell: `vim +BundleInstall +qall`

