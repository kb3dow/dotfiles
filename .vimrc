"Notes:
" map makes key mapping work in normal mode, imap makes it work in insert mode
" <silent> tells not to echo to the statusline what it is doing during execution
" <Leader> tells vim to use the personal mapleader key (\ by default) to activate key mappings 
" ! - exclamation point at the end of a setting tells vim to toggle the value

set nocompatible
"set mouse=a
set encoding=utf-8

if has('unix')
    set t_Co=256
    let g:solarized_termcolors=256
endif

if has('gui_running')
    syntax enable
    highlight CursorColumn guibg=#ff0000
    "set background=dark
    "colorscheme solarized
else
    syntax enable
    highlight CursorColumn ctermbg=Grey
    "set background=dark
    "colorscheme solarized
    "hi Normal ctermbg=DarkGrey ctermfg=White guifg=White guibg=grey20
    "
    " address the issue of delay after pressing escape key
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

" in insert mode jk is the equivalent of <Esc>
inoremap jk <ESC>

let mapleader=","           "remap leader key to , instead of \

set backup                  "have vim backup files
set backupdir=~/.vim/backup "save them here
set modeline                " set filetype specific settings from a :vim command in the first few lines of the file
set ruler                   "show current position
set hlsearch                "highlight search results
set magic                   "for regular expressions turn magic on
set showmatch               "show matching brackets when text indicator is over them
set mat=2                   "how many tenths of a second to blink when matching brackets
set tabstop=4               "tabstops every 4 columns
set shiftwidth=4            "4 cols for >> etc
set expandtab               "convert tabs to spaces
set nowrapscan              "dont wrap around end when / searching
set lbr                     "linebreak on 500 char
set tw=500                  "linebreak on 500 char
"disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>
"Switch CWD to the directory of the open buffer
map <silent> <leader>cd :cd %:p:h<cr>:pwd<cr>

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

filetype off " turn if on later. vundle needs it off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle  required!
Bundle 'gmarik/vundle'

" The bundles you install will be listed here
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'Lokaltog/powerline-fonts'
"airline is a lightweight alternative for powerline, uses powerline-fonts
"Bundle 'bling/vim-airline'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'klen/python-mode'
Bundle 'davidhalter/jedi-vim'
Bundle 'ervandew/supertab'
Bundle 'sjl/gundo.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'Lokaltog/vim-distinguished'
Bundle 'fholgado/minibufexpl.vim'
"Bundle 'scrooloose/syntastic'
filetype plugin indent on   "set filetype on only after vundle as loaded


"Options for mini buffer explorer
map <Leader>e :MBEOpen<cr>
map <Leader>c :MBEClose<cr>
map <Leader>t :MBEToggle<cr>
"
"Options for vim-airline
"let g:airline_section_b = '%{strftime("%c")}'
"let g:airline_section_y = 'B# %{bufnr("%")}'
"let g:airline#extensions#tabline#enabled = 0
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:airline_powerline_fonts = 1
let g:Powerline_symbols = 'fancy'

"Easily toggle cursorcolumn and cursorline - taken from http://goo.gl/DcFtgB
map  <silent> <Leader>sl      :set cursorline! <CR>
imap <silent> <Leader>sl <Esc>:set cursorline! <CR>a
map  <silent> <Leader>sc      :set cursorcolumn!              <CR>
imap <silent> <Leader>sc <Esc>:set cursorcolumn!              <CR>a
map  <silent> <Leader>st      :set cursorcolumn!  cursorline! <CR>
imap <silent> <Leader>st <Esc>:set cursorcolumn!  cursorline! <CR>a
map  <silent> <Leader>so      :set cursorcolumn   cursorline  <CR>
imap <silent> <Leader>so <Esc>:set cursorcolumn   cursorline  <CR>a
map  <silent> <Leader>sn      :set nocursorcolumn nocursorline  <CR>
imap <silent> <Leader>sn <Esc>:set nocursorcolumn nocursorline  <CR>a

"augroup vimrc_autocmds
"        autocmd!
"        " highlight characters past column 80
"        autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
"        autocmd FileType python match Excess /\%80v.*/
"        autocmd FileType python set nowrap
"augroup END


" Powerline setup
set guifont=DejaVu\ Sans\ Mono
"set guifont=Liberation\ Mono\ for\ Powerline\ 10
set laststatus=2
map <F2> :NERDTreeToggle<CR>

" Python-mode
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 0

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
"
" Don't autofold code
let g:pymode_folding = 0

" Toggle pymode Lint
map  <Leader>pt      :PymodeLintToggle <CR>

" Use <leader>l to toggle display of whitespace
nmap <leader>l :set list!<CR>
" And set some nice chars to do it with
set listchars=tab:»\ ,eol:¬

set autochdir " automatically change window's cwd to file's dir
"set noautochdir "do not change window's cwd to file's dir

nnoremap <F5> :GundoToggle<CR>

noremap <F8> :PyLintAuto<CR>

" Append modeline after last line in buffer.
" " Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" " files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
         \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

" this line is to prevent pymode from turning on line numbers at start
autocmd FileType python setlocal nonumber
