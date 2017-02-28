"
" Gogis' .vimrc
"
" mostly 'inspired' byt MisoF's .vimrc

" some basic stuff
set nocompatible " we want new vim features whenever they are available
set bs=2         " backspace should work as we expect it to
set autoindent
set history=50   " remember last 50 commands
set ruler        " show cursor position in the bottom line
set number	 " display line numbers (on left, as expected)
syntax on        " turn on syntax highlighting if not available by default


" Small tweaks: my preferred indentation, colors, autowrite, status line etc.:  {{{

" currently I prefer indent step 4 and spaces -- tabs are evil and should be avoided
set shiftwidth=4
set expandtab
set softtabstop=4

" when shifting a non-aligned set of lines, align them to the next tabstop
set shiftround

" by default, if I'm editing text, I want it to wrap
set textwidth=100

" my terminal is dark, use an appropriate colorscheme
set background=dark

" 256 colorz plz
set t_Co=256

" my currently favorite colorscheme
colorscheme molokai

" disable Background Color Erase (BCE) so that color schemes
" render properly when inside 256-color tmux and GNU screen.
" see also http://snk.tuxfamily.org/log/vim-256color-bce.html
if &term =~ '256color'
  set t_ut=
endif

" use the following to force black background if necessary:
" highlight Normal guibg=black guifg=white ctermbg=black ctermfg=white 

" automatically re-read files changed outside vim
set autoread

" automatically save before each make/execute command
set autowrite

" if I press <tab> in command line, show me all options if there is more than one
set wildmenu

" y and d put stuff into system clipboard (so that other apps can see it)
set clipboard=unnamed,unnamedplus

" <F12> toggles paste mode
set pastetoggle=<F12>

" while typing a command, show it in the bottom right corner
set showcmd

" adjust timeout for mapped commands: 200 milliseconds should be enough for everyone
set timeout
set timeoutlen=200

" an alias to convert a file to html, using vim syntax highlighting
command ConvertToHTML so $VIMRUNTIME/syntax/2html.vim

" text search settings
set incsearch  " show the first match already while I type
set ignorecase
set smartcase  " only be case-sensitive if I use uppercase in my query
set nohlsearch " I hate when half of the text lights up

" enough with the @@@s, show all you can if the last displayed line is too long
set display+=lastline
" show chars that cannot be displayed as <13> instead of ^M
set display+=uhex

" status line: we want it at all times -- white on blue, with ASCII code of the current letter
set statusline=%<%f%h%m%r%=char=%b=0x%B\ \ %l,%c%V\ %P
set laststatus=2
set highlight+=s:MyStatusLineHighlight
highlight MyStatusLineHighlight ctermbg=darkblue ctermfg=white

" tab line: blue as well to fit the theme
" (this is what appears instead of the status line when you use <tab> in command mode)
highlight TabLine ctermbg=darkblue ctermfg=gray
highlight TabLineSel ctermbg=darkblue ctermfg=yellow
highlight TabLineFill ctermbg=darkblue ctermfg=darkblue

" some tweaks taken from vimbits.com:
" reselect visual block after indent/outdent 
vnoremap < <gv
vnoremap > >gv
" make Y behave like other capitals 
map Y y$
" force saving files that require root permission 
cmap w!! %!sudo tee > /dev/null %

" }}}
" ======================================================================================================
" <Tab> at the end of a word should attempt to complete it using tokens from the current file: {{{
function! My_Tab_Completion()
    if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
        return "\<C-P>"
    else
        return "\<Tab>"
endfunction
inoremap <Tab> <C-R>=My_Tab_Completion()<CR>
" }}}
" ======================================================================================================

" Make sure Vim returns to the same line when you reopen a file.
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" finally, tell the folds to fold on file open
set fdm=marker
set commentstring=\ \"\ %s
