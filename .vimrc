"Note when ~/.vimrc present the following is done automatically
"set nocompatible

if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
    set fileencodings=utf-8,latin1
endif

"allow backspacing over everything in insert mode
set bs=2
set viminfo='20,\"50    " read/write a .viminfo file, don't store more
                        " than 50 lines of registers
set history=50          " keep 50 lines of command line history
"Allow switching buffers without writing to disk
set hidden
"Always show cursor position
set ruler
"Set terminal title to filename
set title
if has("autocmd")
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal g'\"" |
  \ endif
endif
"This is necessary to allow pasting from outside vim. It turns off auto stuff.
"You can tell you are in paste mode when the ruler is not visible
set pastetoggle=<F2>
"Usually annoys me
"set nowrap
"Usually I don't care about case when searching
set ignorecase
"Only ignore case when we type lower case when searching
set smartcase
"I hate noise. The t_vb bit removes any delay also
set visualbell t_vb=
"Show menu with possible tab completions
set wildmenu
"Ignore these files when completing names and in Explorer
set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif
"turn on line numbers
set number
"turn on highlight searching
set hlsearch

""""""""""""""""""""""""""""""""""""""""""""""""
" Indenting
""""""""""""""""""""""""""""""""""""""""""""""""

"Default to autoindenting of C like languages
"This is overridden per filetype below
set noautoindent smartindent

"The rest deal with whitespace handling and
"mainly make sure hardtabs are never entered
"as their interpretation is too non standard in my experience
set softtabstop=4
" Note if you don't set expandtab, vi will automatically merge
" runs of more than tabstop spaces into hardtabs. Clever but
" not what I usually want.
set expandtab
set shiftwidth=4
set shiftround
set nojoinspaces
set tabstop=4

""""""""""""""""""""""""""""""""""""""""""""""""
" Dark background
""""""""""""""""""""""""""""""""""""""""""""""""

"I always work on dark terminals
set background=dark

"Make the completion menus readable
highlight Pmenu ctermfg=0 ctermbg=3
highlight PmenuSel ctermfg=0 ctermbg=7

"The following should be done automatically for the default colour scheme
"at least, but it is not in Vim 7.0.17.
if &bg == "dark"
  highlight MatchParen ctermbg=darkblue guibg=blue
endif

""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax highlighting
""""""""""""""""""""""""""""""""""""""""""""""""

syntax on

""""""""""""""""""""""""""""""""""""""""""""""""
" file type handling
""""""""""""""""""""""""""""""""""""""""""""""""

" To create new file securely do: vim new.file.txt.gpg
" Your private key used to decrypt the text before viewing should
" be protected by a passphrase. Alternatively one could use
" a passphrase directly with symmetric encryption in the gpg commands below.
"au BufNewFile,BufReadPre *.gpg :set secure viminfo= noswapfile nobackup nowritebackup history=0 binary
"au BufReadPost *.gpg :%!gpg -d 2>/dev/null
"au BufWritePre *.gpg :%!gpg -e -r 'P@draigBrady.com' 2>/dev/null
"au BufWritePost *.gpg u

filetype on
filetype plugin on
filetype indent on

augroup html
    au!
    "Disable parenthesis matching as it's way too slow
    au BufRead *.html NoMatchParen
augroup END

augroup sh
    au!
    "smart indent really only for C like languages
    au FileType sh set nosmartindent autoindent
augroup END

augroup Python
    "See $VIMRUNTIME/ftplugin/python.vim
    au!
    "smart indent really only for C like languages
    "See $VIMRUNTIME/indent/python.vim
    au FileType python set nosmartindent autoindent
    " Allow gf command to open files in $PYTHONPATH
    au FileType python let &path = &path . "," . substitute($PYTHONPATH, ';', ',', 'g')
    if v:version >= 700
        "See $VIMRUNTIME/autoload/pythoncomplete.vim
        "<C-x><C-o> to autocomplete
        au FileType python set omnifunc=pythoncomplete#Complete
        "Don't show docs in preview window
        au FileType python set completeopt-=preview
    endif
augroup END

set mouse=a
