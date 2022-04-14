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
"colorscheme jellybeans

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
" Vim syntax file
" Language:	Snakemake (extended from python.vim)
" Maintainer:	Jay Hesselberth (jay.hesselberth@gmail.com)
" Last Change:	2016 Jan 23
"
" Usage
"
" copy to $HOME/.vim/syntax directory and add:
"
" au BufNewFile,BufRead Snakefile set syntax=snakemake
" au BufNewFile,BufRead *.snake set syntax=snakemake
"
" to your $HOME/.vimrc file
"
" force coloring in a vim session with:
"
" :set syntax=snakemake
"

" load settings from system python.vim (7.4)
source $VIMRUNTIME/syntax/python.vim

"
" Snakemake rules, as of version 3.3
"
" XXX N.B. several of the new defs are missing from this table i.e.
" subworkflow, touch etc
"
" rule       = "rule" (identifier | "") ":" ruleparams
" include    = "include:" stringliteral
" workdir    = "workdir:" stringliteral
" ni         = NEWLINE INDENT
" ruleparams = [ni input] [ni output] [ni params] [ni message] [ni threads] [ni (run | shell)] NEWLINE snakemake
" input      = "input" ":" parameter_list
" output     = "output" ":" parameter_list
" params     = "params" ":" parameter_list
" message    = "message" ":" stringliteral
" threads    = "threads" ":" integer
" resources  = "resources" ":" parameter_list
" version    = "version" ":" statement
" run        = "run" ":" ni statement
" shell      = "shell" ":" stringliteral

syn keyword pythonStatement	include workdir onsuccess onerror
syn keyword pythonStatement	ruleorder localrules configfile
syn keyword pythonStatement	touch protected temp wrapper
syn keyword pythonStatement	input output params message threads resources shadow
syn keyword pythonStatement	version run shell benchmark snakefile log script
syn keyword pythonStatement	rule subworkflow nextgroup=pythonFunction skipwhite

" similar to special def and class treatment from python.vim, except
" parenthetical part of def and class
syn match   pythonFunction
      \ "\%(\%(rule\s\|subworkflow\s\)\s*\)\@<=\h\w*" contained

syn sync match pythonSync grouphere NONE "^\s*\%(rule\|subworkflow\)\s\+\h\w*\s*"

let b:current_syntax = "snakemake"

" vim:set sw=2 sts=2 ts=8 noet:

