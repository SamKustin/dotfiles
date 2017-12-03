" ================ Plugins ===========================
" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'       " Plugin Manager
Plugin 'scrooloose/NERDTree'        " Sidebar Directory Tree
Plugin 'itchyny/lightline.vim'      " Status Line
Plugin 'joshdick/onedark.vim'       " Colorscheme
Plugin 'sheerun/vim-polyglot'       " Improved Syntax Highlighting
Plugin 'airblade/vim-gitgutter'     " Git Diff Indicator
call vundle#end()

" ================ General Config ====================
set laststatus=2        " Display the status line. 2 = Always
set showcmd             " Show incomplete cmds down the bottom
set showmode            " Show current mode down the bottom
set visualbell          " No sound
set autoread            " Reload files changed outside vim
set number              " Display line numbers
set encoding=utf8
set mouse=a             " Allow mouse clicks to change cursor

" The escape button is mapped to \"jj\", so in insert mode
" I can quickly press jj to access normal mode
imap jj <ESC>

set hidden              " Hide buffers instead of closing them
set backspace=2         " Backspace normally (over indents, line breaks, and 
                        " over characters existing before starting insert mode)

" \Note: I have \"syntax on" set for onedark.vim
if !exists("g:syntax_on")
    syntax enable
endif

" set background=dark
" colorscheme onedark

"Re-loads the .vimrc on a save
augroup AutoReload
    autocmd!
    autocmd BufWritePost .vimrc source %
augroup END

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
filetype plugin indent on
set smarttab
set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       " Don't wrap lines
set linebreak    " Wrap lines at convenient points

" ================ Folds ============================
set foldmethod=indent   " Fold based on indent
set foldnestmax=3       " Deepest fold is 3 levels
set nofoldenable        " Dont fold by default

" ================ Completion =======================
set wildmode=list:longest
set wildmenu                        " Enable ctrl-n and ctrl-p to scroll through matches
set wildignore=*.o,*.obj,*~         " Stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ================ Scrolling ========================
set scrolloff=8         " Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search ===========================
set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" ================ Functions ========================
if !exists('*s:setupWrapping')
    function! s:setupWrapping() abort
        set wrap
        set wm=2
        set textwidth=79
    endfunction
endif

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
colorscheme onedark

let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }

" =============== GitGutter ==========================
let g:gitgutter_map_keys = 0        " Disable all GitGutter key mappings
set updatetime=250                  " Set diff marker update/delay time to 250ms

" =============== Cursor Style =======================
" Change the cursor style depending on which mode vim is on
"
" Uses ANSI/Terminal control and escape sequences to configure the style
" CSI Ps SP q       --> Change cursor style
"   CSI (control sequence introducer) = \033[ -- represents ESC [
"   Ps (single parameter) = 2 (block) and 6 (vertical line)
"   SP = space character and q = q character
" OSC Pl Color ST   --> Change cursor color
"   OSC (operating system command) = \033] -- represents ESC ]
"   Pl = Change cursor color
"   Color = Hex value for cursor color
"   ST (string terminator) = \033\\

if $TERM =~ "^xterm-256color\\|rxvt"
    if exists('$TMUX')
        let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]1337;CursorShape=1\x7\<Esc>\\"
        let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]1337;CursorShape=0\x7\<Esc>\\"
    else
        " Use a vertical line upon starting insert mode
        let &t_SI = "\033]Plc7c7c7\033[6 q\033\\"
        " let &t_SI = \"\033[6 q
        " let &t_SI = \<Esc>]1337;CursorShape=1\x7"

        " Use a rectangular block upon exiting insert mode
        let &t_EI = "\033]Plc7c7c7\033[2 q\033\\"
        " let &t_EI = \"\033[2 q"
        " let &t_EI = \"\<Esc>]1337;CursorShape=0\x7"

        " Use a rectangular block upon starting replace mode
        let &t_SR = "\033]Plc7c7c7\033[2 q\033\\"
        " let &t_SR = \"\033[2 q"
        " let &t_SR = \"\<Esc>]1337;CursorShape=0\x7"

        augroup vimrc-cursorstyle
            autocmd!
            " Set cursor to a block when vim starts
            autocmd VimEnter * silent !printf "\033]Plc7c7c7\033[2 q\033\\"
            " autocmd VimEnter * silent !printf \"\033[2 q"

            " Reset cursor to a vertical bar when vim exits
            autocmd VimLeave * silent !printf "\033]Plc7c7c7\033[6 q\033\\"
            " autocmd VimLeave * silent !printf \"\033[6 q"
        augroup END
    endif
endif
