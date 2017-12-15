" =============================== Plugins ================================== "
call plug#begin('~/.vim/plugged')   " Vim-Plug Plugin Manager
Plug 'scrooloose/NERDTree'          " Sidebar Directory Tree
Plug 'itchyny/lightline.vim'        " Status Line
Plug 'joshdick/onedark.vim'         " One Dark Color Scheme
Plug 'sheerun/vim-polyglot'         " Improved Syntax Highlighting
Plug 'airblade/vim-gitgutter'       " Git Diff Indicator
call plug#end()

" ============================ General Config ============================== "
set laststatus=2                    " Display the status line. 2 = Always
set showcmd                         " Show incomplete cmds down the bottom
set showmode                        " Show current mode down the bottom
set visualbell                      " No sound
set autoread                        " Reload files changed outside vim
set number                          " Display line numbers
set encoding=utf8
set mouse=a                         " Allow mouse clicks to change cursor

set hidden                          " Hide buffers instead of closing them
set backspace=2                     " Backspace normally

set colorcolumn=80                  " Highlight the 80th column

"Re-loads the .vimrc on a save
augroup AutoReload
    autocmd!
    autocmd BufWritePost .vimrc source %
augroup END

" ============================== Key Mappings ============================== "
" Use 'jj' in insert mode to escape back to normal mode
inoremap jj <ESC>

" Use '\nt' in normal mode to toggle the NERDTree window
nnoremap <leader>nt :NERDTreeToggle

" ============================== Color Scheme ============================== "
" \Note: Vim-Plug automatically executes 'syntax enable'
" \Note: I have \"syntax on" set for onedark.vim
" if !exists("g:syntax_on")
"     syntax enable
" endif

" set background=dark
" colorscheme onedark

" =========================== Turn Off Swap Files ========================== "
set noswapfile
set nobackup
set nowb

" ============================ Persistent Undo ============================= "
" Keep undo history across sessions, by storing in file.
if has('persistent_undo') && !isdirectory(expand('~').'/.vim/backups')
   silent !mkdir ~/.vim/backups > /dev/null 2>&1
   set undodir=~/.vim/backups
   set undofile
endif

" ============================== Indentation =============================== "
set autoindent

" \Note: Vim-Plug automatically executes 'filetype plugin indent on'
" filetype plugin indent on

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

set nowrap              " Don't wrap lines
set linebreak           " Wrap lines at convenient points

" ================================ Folding ================================= "
set foldmethod=indent   " Fold based on indent
set foldnestmax=3       " Deepest fold is 3 levels
set nofoldenable        " Dont fold by default

" =============================== Completion =============================== "
set wildmode=list:longest
set wildmenu                        " Enable ctrl-n and ctrl-p to scroll through matches
set wildignore=*.o,*.obj,*~         " Stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" =============================== Scrolling ================================ "
set scrolloff=8         " Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================================ Search ================================== "
set incsearch           " Find the next match as we type the search
set hlsearch            " Highlight searches by default
set ignorecase          " Ignore case when searching...
set smartcase           " ...unless we type a capital

" =============================== Functions ================================ "
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

" ============================== Onedark.vim =============================== "
" Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
" If you're using tmux version 2.2 or later, you can remove the outermost 
" $TMUX check and use tmux's 24-bit color support
" (see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more info.)
if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

syntax on
colorscheme onedark

let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }

" =============================== GitGutter ================================ "
let g:gitgutter_map_keys = 0        " Disable all GitGutter key mappings
set updatetime=250                  " Set diff marker update/delay time to 250ms

" ============================== Cursor Style ============================== "
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
        " let &t_SI = \"\033[6 q"
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

            " Removes garbage characters that appear on vim startup
            autocmd VimEnter * redraw!
        augroup END
    endif
endif
