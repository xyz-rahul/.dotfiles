" NOTE: 
" xmap creates a mapping for just Visual mode whereas, 
" vmap creates one for both visual and normal mode


" Leader key configuration
let mapleader = ' '
let g:mapleader = ' '
let g:maplocalleader = "  "


" Enable syntax highlighting
syntax on

" Enable filetype detection, plugins, and indentation
filetype on
filetype plugin on
filetype indent on

" Basic settings
set nocompatible                " Don't bother with vi compatibility
set autoread                    " Reload files when changed on disk, i.e. via `git checkout`
set magic                       " For regular expressions turn magic on
set title                       " Change the terminal's title
set nobackup                    " Do not keep a backup file
set novisualbell                " Turn off visual bell
set noerrorbells                " Don't beep
set visualbell t_vb=            " Turn off error beep/flash

" Show location settings
set cursorline                  " Highlight the current line
set ruler                       " Show the current row and column
set showmode                    " Display current modes
set number                      " Enable line numbers
set relativenumber              " Enable relative line numbers

" Indentation settings
set autoindent smartindent shiftround
set shiftwidth=4                " Set shift width to 4 spaces
set tabstop=4                   " Set tab width to 4 columns
set softtabstop=4               " Set soft tab stop to 4 spaces
set expandtab                   " Use spaces instead of tabs
set smartindent                 " Enable smart indentation

" Disable line wrapping
set nowrap

" Disable swap and backup files
set noswapfile
set nobackup

" Search options
set nohlsearch                  " Do not highlight search results
set incsearch                   " Incremental search
set ignorecase                  " Ignore case in search patterns

" Enable true color support
set termguicolors

" Set scroll offset and sign column
set scrolloff=16
set signcolumn=yes

" Allow filenames to contain '@'
set isfname+=@-@

" Set update time for CursorHold events
set updatetime=50

" Highlight column 80
set colorcolumn=80

" Deoplete, specific for Vim8
if !has("nvim")
    " Enable mouse support
    set mouse=a
endif

" Folding settings
set foldenable
set foldmethod=indent
set foldlevel=99
let g:FoldMethod = 0
map <leader>zz :call ToggleFold()<cr>
fun! ToggleFold()
    if g:FoldMethod == 0
        exe "normal! zM"
        let g:FoldMethod = 1
    else
        exe "normal! zR"
        let g:FoldMethod = 0
    endif
endfun

" Theme settings
colorscheme desert
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
autocmd vimenter * hi EndOfBuffer guibg=NONE ctermbg=NONE

" Key mappings
nnoremap <leader>x :bd<CR>      " Quickly close the current window
nnoremap <silent> n nzz         " Keep search pattern at the center of the screen
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv


"""""""""""""""""""""""""""""""""""""""""" keymapping """"""""""""""""""""""""""""""""""""""""

" Visual mode: Move selected lines down
vnoremap J :m '>+1<CR>gv=gv

" Visual mode: Move selected lines up
vnoremap K :m '<-2<CR>gv=gv

" Normal mode: Join current line with line below
nnoremap J mzJ`z

" Normal mode: Scroll down and center the current line
nnoremap <C-d> <C-d>zz

" Normal mode: Scroll up and center the current line
nnoremap <C-u> <C-u>zz

" Normal mode: Move to next search result and center the screen
nnoremap n nzzzv

" Normal mode: Move to previous search result and center the screen
nnoremap N Nzzzv

" Visual mode: Cut and paste to black hole register
vnoremap <leader>p "_dP

" Normal and visual mode: Yank to the system clipboard
vnoremap <leader>y "+y

" Normal mode: Yank to system clipboard from current line to end of file
nnoremap <leader>Y "+Y

" Normal and visual mode: Delete to black hole register
vnoremap <leader>d "_d

" Map Ctrl+C to escape
map <C-c> <Esc>

" Normal mode: Jump to the next location list item and center the screen
nnoremap <leader>k :lnext<CR>zz

" Normal mode: Substitute word globally with confirmation
nnoremap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>


" Buffers: Switch buffers
nnoremap <S-Tab> :bprevious<CR>
nnoremap <Tab> :bnext<CR>
nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>

" Normal mode: Clear highlights
nnoremap <Esc> :noh<CR>

" Normal mode: Close buffer
nnoremap <leader>x :bd<CR>

nmap <leader>t <Action>(ActivateTerminalToolWindow)


