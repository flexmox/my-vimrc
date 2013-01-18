"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => My Vimrc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call pathogen#infect()

let g:mapleader = ","

set foldmethod=indent
set nostartofline
set wildmenu

let NERDTreeIgnore=['\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$']
let g:snippets_dir='~/.vim/private,~/.vim/snippets'

map <leader>tl :TaskList<CR>
map <leader>gd :GundoToggle<CR>
map <leader>ne :set noexpandtab!<CR>
map <leader>nw :set nowrap!<CR>
map <leader>ts :set ts=50<CR>
map <leader>sp :set spell!<CR>

let g:pep8_map = '<leader>8'

" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugin
filetype plugin on
filetype indent on

" Fast editing of the .vimrc
map <leader>e :e! ~/.vimrc<CR>
" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vimrc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Syntax Files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufRead,BufNewFile *.as set filetype=actionscript

let g:syntastic_check_on_open=1
let g:syntastic_auto_loc_list=0
let g:syntastic_python_checker_args='--ignore=E501'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Visual Increment
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nrformats=alpha


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ctags
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("mac")
    let Tlist_Ctags_Cmd = "/opt/local/bin/ctags"
else
    let Tlist_Ctags_Cmd = "/usr/bin/ctags"
endif

let Tlist_WinWidth = 50
map <F4> :TlistToggle<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => XML_TAG
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let xml_tag_completion_map = '<C-l>'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ruler "Always show current position
set cmdheight=2 "The commandbar height
set hid "Change buffer - without saving
set backspace=eol,start,indent " Set backspace config
set whichwrap+=<,>,h,l
set ignorecase "Ignore case when searching
set smartcase
set hlsearch "Highlight search things
set incsearch "Make search act like search in modern browsers
set nolazyredraw "Don't redraw while executing macros 
set magic "Set magic on, for regular expressions
set showmatch "Show matching bracets when text indicator is over them
set mat=2 "How many tenths of a second to blink
set novisualbell " No sound on errors
set noerrorbells
set t_vb=
set tm=500


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable "Enable syntax hl

if has("gui_running")
  set lines=60 columns=180
  set guifont=monospace\ 11
  set guioptions-=T
  set t_Co=256
  set background=dark
  colorscheme peaksea
  set nonu
else
  colorscheme default
  colorscheme desert
  set background=dark
  set nonu
endif

set encoding=utf8
try
    lang en_US
catch
endtry


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git anyway...
"set nobackup
"set nowb
"set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab

set lbr
set tw=500

set ai "Auto indent
set si "Smart indet
set wrap "Wrap lines


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart mappings on the command line
cno $h NERDTree ~/
cno $d NERDTree ~/Desktop/
cno $j NERDTree ./

" Bash like keys for the command line
cnoremap <C-A>		<Home>
cnoremap <C-E>		<End>
cnoremap <C-K>		<C-U>
cnoremap <C-P>      <Up>
cnoremap <C-N>      <Down>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <silent> <leader><CR> :noh<CR>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<CR>

" Close all the buffers
map <leader>ba :1,300 bd!<CR>

" Use the arrows to something usefull
map <right> :bn<CR>
map <left> :bp<CR>

" Tab configuration
map <leader>tn :tabnew<CR>
map <leader>te :tabedit 
map <leader>tc :tabclose<CR>
map <leader>tm :tabmove 

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<CR>

command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" Specify the behavior when switching between buffers 
try
  set switchbuf=usetab
  set stal=2
catch
endtry


""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=2

" Format the statusline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c


function! CurDir()
    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction


""""""""""""""""""""""""""""""
" => Vimdiff
""""""""""""""""""""""""""""""
nnoremap dc :diffget<cr>
nnoremap dp :diffput<cr>
