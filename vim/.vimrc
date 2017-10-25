" Use Vim settings, rather then Vi settings (much better!).
" " This must be first, because it changes other options as a side effect.
set nocompatible               " be iMproved, requires
set laststatus=2

" ================ Vundle ========================
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

"let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tomasr/molokai'
Plugin 'scrooloose/NERDTree'
Plugin 'itchyny/lightline.vim'
"Plugin 'vim-airline/vim-airline'
"Plugin 'vim-airline/vim-airline-themes'
Plugin 'joshdick/onedark.vim'
Plugin 'sheerun/vim-polyglot'
call vundle#end()

" ================ General Config ===================="
set showcmd 		      "Show incomplete cmds down the bottom
set showmode                  "Show current mode down the bottom
set visualbell                "No sound
set autoread                   "Reload files changed outside vim
set nonumber
set encoding=utf8
set mouse=a

" The escape button is mapped to "jj", so in insert mode
" I can quickly press jj to access normal mode
imap jj <ESC>


filetype plugin indent on

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden
set backspace=2

"syntax highlighting is set to on
set number
syntax enable
set background=dark
" colorscheme vimbrant
"Re-loads the .vimrc on a save
autocmd! BufWritePost .vimrc source %
" ================ Turn Off Swap Files ==============
set noswapfile
set nobackup
set nowb
" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo') && !isdirectory(expand('~').'/.vim/backups')
   silent !mkdir ~/.vim/backups > /dev/null 2>&1
   set undodir=~/.vim/backups
   set undofile
endif
" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>
" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ================ Scrolling ========================
set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search ===========================
set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" ================ Functions ========================
 if !exists('*s:setupWrapping')
   function s:setupWrapping()
       set wrap
           set wm=2
               set textwidth=79
                 endfunction
                 endif "" txt
augroup vimrc-wrapping
    autocmd!
      autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
    augroup END

" =============== onedark.vim ========================
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

syntax on
let g:lightline = {
    \ 'colorscheme':'onedark', 
    \ }
colorscheme onedark
