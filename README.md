# Hardtime

Hardtime helps you break that annoying habit vimmers have of scrolling up and
down the page using `jjjjj` and `kkkkk` but without compromising the rest of our vim
experience.

It works using a timeout on the keys you want to stop repeating, i.e. `h`, `j`, `k`, `l`, `UP`, `DOWN`, `LEFT`, `RIGHT`.
This timeout is set to 1000 milliseconds. After this time you can use a movement key again.

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
conversely you can use `:HardTimeOff` to swtich it off. You can also use
`:HardTimeToggle` toggle it on an off.

If you want hardtime to run in every buffer you can set `let
g:hardtime_default_on = 1` in your `.vimrc`.

### Customisation
Add the following variables to your `.vimrc` to enable customisations.
##### Keys
Set the list of keys to use with hardtime 

    g:list_of_normal_keys = [ "w", "W", "b", "B" ]
    g:list_of_visual_keys = [ "o", "n", "w", "b" ]

These default to `[ "h", "j", "k", "l", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>" ]`.

##### Timeout
It is possible to tweak the timeout allowed between keypresses. specifying 
the time in milliseconds.

    g:hardtime_timeout = 2000
    
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

