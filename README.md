# Hardtime

Hardtime helps you break that annoying habit vimmers have of scrolling up and
down the page using `jjjjj` and `kkkkk` but without compromising the rest of our vim
experience.

It works using a timeout on the keys you want to stop repeating, i.e. `h`, `j`, `k`, `l`, `UP`, `DOWN`, `LEFT`, `RIGHT`.
This timeout is set to 1000 milliseconds. After this time you can use a movement key again. It also allows to completely disable
keys that you never under any circumstances want to use.

Stop repeating jjjjj...
Stop repeating kkkk...

Kick the habit now!

Inspired by [vim-hardmode](https://github.com/wikitopian/hardmode), but where
hardmode fell short was that sometimes `h,j,k,l` are needed! Hardtime lets you use
these keys but only once every second. You can still create macros in hardtime
where you need to move down lines, and you can still move that one character
over to make that edit.

### Resources to help you kick the bad habits

- Drew Neil has a great blog post on [Habit breaking, habit making](http://vimcasts.org/blog/2013/02/habit-breaking-habit-making/)
- Practising some [Vim golf](http://vimgolf.com/) will certainly improve your movement skills
- Vim help, `:h word-motions` and `:h motion` are both great resources
- A good [Vim wiki](http://vim.wikia.com/wiki/Moving_around) article

### Usage

Once installed you can call the command `:HardTimeOn` to activate hardtime,
conversely you can use `:HardTimeOff` to switch it off. You can also use
`:HardTimeToggle` toggle it on an off.

If you want hardtime to run in every buffer, add this to `.vimrc`

	let g:hardtime_default_on = 1

The default is `0`.

### Customization
Add the following variables to your `.vimrc` to enable customizations.
##### Keys
Set the list of keys to be banned of use with hardtime

Defaults to

	let g:list_of_normal_keys = ["h", "j", "k", "l", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
	let g:list_of_visual_keys = ["h", "j", "k", "l", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
	let g:list_of_insert_keys = ["<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
	let g:list_of_disabled_keys = []

Note that the keys added to `g:list_of_disabled_keys` are disabled in all of normal, visual and insert modes.

##### Timeout
It is possible to tweak the timeout allowed between keypresses. specifying
the time in milliseconds.

    let g:hardtime_timeout = 2000

This allows you increase the amount of time

The default is `1000`.

##### Enable Notifications
To enable the notification about HardTime being enabled set

    let g:hardtime_showmsg = 1

The default is `0`.

##### Ignore Buffers
To enable hardtime to ignore certain buffer patterns set

    let g:hardtime_ignore_buffer_patterns = [ "CustomPatt[ae]rn", "NERD.*" ]

The default is `[]`.

##### Ignore Quickfix
The quickfix window cannot be added to the ignore buffers array to have hardtime ignore it set

    let g:hardtime_ignore_quickfix = 1

The default is `0`.

##### Allow different keys
To make hardtime allow a key if it is different from the previous key, set

    let g:hardtime_allow_different_key = 1

This, for example, makes it possible to input "jh", but not "jj".

The default is `0`.

##### Maximum number of repetative key preses
This setting will let you press a key `n` number of times before
hardtime starts ignoring subsequent keypresses.

    let g:hardtime_maxcount = 2

Setting this value to `2` will allow a user to press `jj` but not `jjj`.

The default is `1`.


### Installation
I recommend installing using [Vundle](https://github.com/gmarik/vundle):

Add `Bundle 'takac/vim-hardtime'` to your `~/.vimrc` and then:

* either within Vim: `:BundleInstall`
* or in your shell: `vim +BundleInstall +qall`

### Installing using vim-plug

1. Install vim-plug using the [instructions][vim-plug]
2. Add vim-hardtime to your plugin list in `.vimrc` or `plugins.vim` and re-source it:

    insert vim-hardtime
    ```
    " Vim HardTime
    Plug 'takac/vim-hardtime'
    ```
    between
    `call plug#begin('~/.vim/plugged')`

    and
    `call plug#end()`
3. Run `:PlugInstall`

[vim-plug]:https://github.com/junegunn/vim-plug
