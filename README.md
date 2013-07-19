# Hardtime

Hardtime helps you break that annoying habit vimmers have of scrolling up and
down the page using jjjjj and kkkkk but without comprimising the rest of our vim
experience.

It works using a timeout on the keys you want to stop repeating. Default to 1 second.

Stop repeating jjjjj... 
Stop repeating kkkk... 

Kick the habit now!

Inspired by [vim-hardmode](https://github.com/wikitopian/hardmode), but where
hardmode fell short was that sometimes h,j,k,l are needed! Hardtime lets you use
these keys but only once every second. You can still create macros in hardtime
where you need to move down lines, and you can still move that one character
over to make that edit.

### Installation
I recommend installing using [Vundle](https://github.com/gmarik/vundle):

Add `Bundle 'takac/vim-commandcaps'` to your `~/.vimrc` and then:

* either within Vim: `:BundleInstall`
* or in your shell: `vim +BundleInstall +qall`

