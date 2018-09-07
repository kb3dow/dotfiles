" Note on install/upgrade of plugins
" 1. nvim +PlugInstall +qall
" 2. nvim +PlugUpgrade +PlugUpdate +PlugClean +qall

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

let g:My_Spellcheck_Enabled     = 1
let g:My_CtrlP_Enabled          = 1
let g:My_LightLine_Enabled      = 0
let g:My_NeoMake_Enabled        = 1
let g:My_Syntastic_Enabled      = 1
let g:My_Taglist_Enabled        = 1
let g:My_PyLint_Mode_Enabled    = 0
let g:My_PyMode_Indent_Enabled  = 1
let g:My_Airline_Enabled        = 1 "airline is a lightweight alternative for powerline, uses powerline-fonts
let g:My_PowerlineFont_Enabled  = 1
let g:My_NerdTree_Enabled       = 1
let g:My_NerdCommenter_Enabled  = 1
let g:My_edit_gpg_file_Enabled  = 1

call plug#begin('~/.config/nvim/plugged')

" Plugins {
    " gruvbox colorscheme. Seems to work the best for me.
    Plug 'morhetz/gruvbox'
    if g:My_CtrlP_Enabled
        Plug 'kien/ctrlp.vim' " ctrl-p is a fuzzy file finder.
    endif
    if g:My_CtrlP_Enabled
        Plug 'itchyny/lightline.vim' " lightline is a status line for nvim.
    endif
    if g:My_NeoMake_Enabled
        Plug 'neomake/neomake' " neomake is a code linting tool that runs in the background.
    endif
    " Autocomplete for python
    Plug 'davidhalter/jedi-vim'
    " Remove extraneious whitespace when edit mode is exited
    Plug 'thirtythreeforty/lessspace.vim'
    " LaTeX editing
    Plug 'LaTex-box-Team/LaTeX-Box'
    " Status bar mods
    if g:My_Airline_Enabled
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
    endif
    Plug 'airblade/vim-gitgutter'

    " Tab completion
    Plug 'ervandew/supertab'
    if g:My_Syntastic_Enabled
        Plug 'scrooloose/syntastic'
    endif
    if g:My_Taglist_Enabled
        Plug 'vim-scripts/taglist.vim'
    endif
    if g:My_PyLint_Mode_Enabled
        Plug 'vim-scripts/pylint-mode'
    endif
    if g:My_PyMode_Indent_Enabled
        Plug 'hynek/vim-python-pep8-indent'
    endif
    if g:My_PowerlineFont_Enabled
        Plug 'powerline/fonts'
    endif
    if g:My_NerdTree_Enabled
        Plug 'scrooloose/nerdtree'
    endif
    if g:My_NerdCommenter_Enabled
        Plug 'scrooloose/nerdcommenter'
    endif

" }

call plug#end()

" My Leader Settings {
    " let mapleader="\<SPACE>" Map the leader key to ,
    let mapleader=","           "remap leader key to , instead of \
    "disable highlight when <leader><cr> is pressed
    map <silent> <Leader><cr> :noh<cr>
    "Switch CWD to the directory of the open buffer
    map <silent> <leader>cd :cd %:p:h<cr>:pwd<cr>
    " Use <Leader>l to toggle display of whitespace
    nmap <Leader>l :set list!<CR>
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
" }


" General {
    set noautoindent        " I indent my code myself.
    set nocindent           " I indent my code myself.
    "set smartindent        " Or I let the smartindent take care of it.
    set breakindent         " Indent line-breaks at the same level as code.

    set ttimeoutlen=100
" }

" Search {
    set ignorecase          " Make searching case insensitive
    set smartcase           " ... unless the query has capital letters.
    set gdefault            " Use 'g' flag by default with :s/foo/bar/.
    set magic                   "for regular expressions turn magic on

    " Use <C-L> to clear the highlighting of :set hlsearch.
    if maparg('<C-L>', 'n') ==# ''
        nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
    endif
" }

" Formatting {
    set showmatch           " Show matching brackets.
"   set number              " Show the line numbers on the left side.
    set nonumber            " Dont show the line numbers on the left side.
    set formatoptions+=o    " Continue comment marker in new lines.
    set expandtab           " Insert spaces when TAB is pressed.
    set tabstop=4           " Render TABs using this many spaces.
    set softtabstop=4       "Insert 4 spaces when tab is pressed
    set shiftwidth=4        " Indentation amount for < and > commands.
    map Q gq                " Don't use Ex mode, use Q for formatting

    set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)

    " More natural splits
    set splitbelow          " Horizontal split below current.
    set splitright          " Vertical split to right of current.

    if !&scrolloff
        set scrolloff=3       " Show next 3 lines while scrolling.
    endif
    if !&sidescrolloff
        set sidescrolloff=5   " Show next 5 columns while side-scrolling.
    endif
    set nostartofline       " Do not jump to first character with page commands.

    " Tell Vim which characters to show for expanded TABs,
    " trailing whitespace, and end-of-lines. VERY useful!
    if &listchars ==# 'eol:$'
        set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
    endif
    set list                " Show problematic characters.
" }

" Configuration {
    set autochdir           " Switch to current file's parent directory.

    " Remove special characters for filename
    set isfname-=:
    set isfname-==
    set isfname-=+

    " Map ; to :
    nnoremap ; :

    " Path/file expansion in colon-mode.
    set wildmode=list:longest

    " Allow color schemes to do bright colors without forcing bold.
    if &t_Co == 8 && $TERM !~# '^linux'
        set t_Co=16
    endif

    " Remove trailing spaces.
    function! TrimWhitespace()
        let l:save = winsaveview()
        %s/\s\+$//e
        call winrestview(l:save)
    endfunction
    " FIXME: Do not call this on makefile and sv files.
    autocmd BufWritePre * call TrimWhitespace()
    nnoremap <leader>W :call TrimWhitespace()<CR>

    " Diff options
    set diffopt+=iwhite

    "Enter to go to EOF and backspace to go to start
    nnoremap <CR> G
    nnoremap <BS> gg
    " Stop cursor from jumping over wrapped lines
    nnoremap j gj
    nnoremap k gk
    " Make HOME and END behave like shell
    inoremap <C-E> <End>
    inoremap <C-A> <Home>
" }

" UI Options {
    " Colorscheme options.
    set bg=dark
    colorscheme gruvbox

    " Also highlight all tabs and trailing whitespace characters.
    highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
    match ExtraWhitespace /\s\+$\|\t/

    " Relative numbering
    function! NumberToggle()
        if(&relativenumber == 1)
            set nornu
            set number
        else
            set rnu
        endif
    endfunc

    " Toggle between normal and relative numbering.
    nnoremap <leader>r :call NumberToggle()<cr>
" }

" Keybindings {
    " Save file
    nnoremap <Leader>w :w<CR>

    " Copy and paste from system clipboard (Might require xsel/xclip install)
    vmap <Leader>y "+y
    vmap <Leader>d "+d
    nmap <Leader>p "+p
    nmap <Leader>P "+P
    vmap <Leader>p "+p
    vmap <Leader>P "+P

    " Move between buffers
    nmap <Leader>l :bnext<CR>
    nmap <Leader>h :bprevious<CR>
    nmap <Leader>k :tabnext<CR>
    nmap <Leader>j :tabprevious<CR>
    nmap <tab> <C-w>w

    " Manage split sizes
    map <leader>ww <C-w>_
    map <leader>w\ <C-w>|
    map <leader>we <C-w>=
    map <leader>w- <C-w>-
    map <leader>w= <C-w>+

" }


" Experimental {
    " Search and Replace
    nmap <Leader>s :%s//g<Left><Left>
" }

" Plugin Settings {
    " neomake {
        if g:My_NeoMake_Enabled
            let g:neomake_warning_sign={'text': '◆'}
            let g:neomake_error_sign={'text': '✗'}
            autocmd! BufWritePost * Neomake
            nnoremap <Leader>n :lopen<CR>
        endif
    " }
    " Lightline {
        if g:My_LightLine_Enabled
            let g:lightline = {
            \ 'colorscheme': 'gruvbox',
            \ 'active': {
            \   'left': [['mode', 'paste'], ['filename', 'modified']],
            \   'right': [['lineinfo'], ['percent'], ['readonly', 'linter_warnings', 'linter_errors']]
            \ },
            \ 'component_expand': {
            \   'linter_warnings': 'LightlineLinterWarnings',
            \   'linter_errors': 'LightlineLinterErrors'
            \ },
            \ 'component_type': {
            \   'readonly': 'error',
            \   'linter_warnings': 'warning',
            \   'linter_errors': 'error'
            \ },
            \ }
            function! LightlineLinterWarnings() abort
                let l:counts = neomake#statusline#LoclistCounts()
                let l:warnings = get(l:counts, 'W', 0)
                return l:warnings == 0 ? '' : printf('%d ◆', l:warnings)
            endfunction

            function! LightlineLinterErrors() abort
                let l:counts = neomake#statusline#LoclistCounts()
                let l:errors = get(l:counts, 'E', 0)
                return l:errors == 0 ? '' : printf('%d ✗', l:errors)
            endfunction

            " Ensure lightline updates after neomake is done.
            autocmd! User NeomakeFinished call lightline#update()
         endif
    " }
    " CtrlP {
        if g:My_CtrlP_Enabled
            " Open file menu
            nnoremap <Leader>o :CtrlP<CR>
            " Open buffer menu
            nnoremap <Leader>b :CtrlPBuffer<CR>
            " Open most recently used files
            nnoremap <Leader>f :CtrlPMRUFiles<CR>
        endif
    " }
    " netrw {
        let g:netrw_liststyle=3 " tree (change to 0 for thin)
        let g:netrw_banner=0    " no banner
        let g:netrw_altv=1      " open files on right
        let g:netrw_winsize=80  " only use 20% screen for netrw
        " FIXME: Preview opens to left and is very narrow
        let g:netrw_preview=1   " open previews vertically
    " }
    "  Jedi-Vim {
        " Don't mess up undo history
        let g:jedi#show_call_signatures = "0"
    "  }
    "  SuperTab {
        "let g:SuperTabDefaultCompletionType = "<c-x><c-u>"
        function! Completefunc(findstart, base)
            return "\<c-x>\<c-p>"
        endfunction

        "call SuperTabChain(Completefunc, '<c-n>')

        "let g:SuperTabCompletionContexts = ['g:ContextText2']
    "  }
    "  GitGutter {
        let g:gitgutter_async = 1 " 1 to run git diff asynchronously, 0 to turn off
    "  }
    "  Airline {
        if g:My_Airline_Enabled
            let g:airline_powerline_fonts = 1
            let g:airline#extensions#tabline#enabled = 2
            let g:airline#extensions#tabline#fnamemod = ':t'
            let g:airline#extensions#tabline#left_sep = ' '
            let g:airline#extensions#tabline#left_alt_sep = '|'
            let g:airline#extensions#tabline#right_sep = ' '
            let g:airline#extensions#tabline#right_alt_sep = '|'
            let g:airline_left_sep = ' '
            let g:airline_left_alt_sep = '|'
            let g:airline_right_sep = ' '
            let g:airline_right_alt_sep = '|'
            let g:airline_theme= 'gruvbox'
        endif
    "  }
    " Spelling Settings {
        if g:My_Spellcheck_Enabled
            setlocal spell spelllang=en_us
            " default - no spell check
            set nospell
            nnoremap <silent> <leader>sp : set spell!<CR>
        endif
    " }

    " Syntastic Settings {
        if g:My_Syntastic_Enabled
            "let g:syntastic_python_checkers=['pep8']
            let g:syntastic_python_checkers=['pep8','pylint']
            let g:syntastic_c_checkers=['make','splint']
            let g:syntastic_hs_checkers=['ghc-mod','hlint']
            set statusline+=%#warningmsg#
            set statusline+=%{SyntasticStatuslineFlag()}
            set statusline+=%*
            let g:syntastic_auto_loc_list=1
            let g:syntastic_loc_list_height=5
            "highlight link SyntasticError SpellBad
            "highlight link SyntasticWarning SpellCap
        endif
    " }

" Taglist {
    if g:My_Taglist_Enabled
        Plug 'vim-scripts/taglist.vim'
        nnoremap <silent> <F6> :TlistToggle<CR>
        nmap <Leader>g, :TlistToggle<CR>
    endif
" }

" PyLintMode {
    if g:My_PyLint_Mode_Enabled
        Plug 'vim-scripts/pylint-mode'
        let g:PyLintCWindow   = 1
        let g:PyLintSigns     = 1
        let g:PyLintOnWrite   = 1
        "let g:PyLintDissabledMessages = 'C0103,C0111,C0301,W0141,W0142,W0212,W0221,W0223,W0232,W0401,W0613,W0631,E1101,E1120,R0903,R0904,R0913'
    endif
" }

" PyMode_Indent {
    if g:My_PyMode_Indent_Enabled
        let g:pymode_indent = 0
        augroup vimrc_pymodecmds
            autocmd!
            " highlight characters past column 90
            autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
            autocmd FileType python match Excess /\%90v.*/
            autocmd FileType python set nowrap
            augroup END
    endif
" }

" Powerline Settings {
    if g:My_PowerlineFont_Enabled
        " set guifont=Inconsolata\ for\ Powerline "make sure to escape the spaces in the name properly
        set guifont=DejaVu\ Sans\ Mono\ for\ Powerline "make sure to escape the spaces in the name properly
        " set guifont=Source\ Code\ Pro\ for\ Powerline "make sure to escape the spaces in the name properly
    endif

" }

" NerdTree Settings {
    if g:My_NerdTree_Enabled
        map <F2> :NERDTreeToggle<CR>
        map  <silent> <Leader>n3  :NERDTreeToggle<CR>
    endif
" }

" NerdCommenter Settings {
    " See https://github.com/scrooloose/nerdcommenter for usage
    "
    " [count]<leader>cc |NERDComComment|
    " Comment out the current line or text selected in visual mode.
    "
    " [count]<leader>cn |NERDComNestedComment|
    " Same as cc but forces nesting.
    "
    " [count]<leader>c<space> |NERDComToggleComment|
    " Toggles the comment state of the selected line(s). If the topmost selected line is commented, all selected lines are uncommented and vice versa.

    if g:My_NerdCommenter_Enabled
        " Add spaces after comment delimiters by default
        let g:NERDSpaceDelims = 1
    endif
" }

" Edit_gpg_file_Enabled {
    if g:My_edit_gpg_file_Enabled
        " Transparent editing of gpg encrypted files.
        " By Wouter Hanegraaff
        augroup encrypted
          au!

          " First make sure nothing is written to ~/.viminfo while editing
          " an encrypted file.
          autocmd BufReadPre,FileReadPre *.gpg set viminfo=
          " We don't want a various options which write unencrypted data to disk
          autocmd BufReadPre,FileReadPre *.gpg set noswapfile noundofile nobackup

          " Switch to binary mode to read the encrypted file
          autocmd BufReadPre,FileReadPre *.gpg set bin
          autocmd BufReadPre,FileReadPre *.gpg let ch_save = &ch|set ch=2
          " (If you use tcsh, you may need to alter this line.)
          autocmd BufReadPost,FileReadPost *.gpg '[,']!gpg --decrypt 2> /dev/null

          " Switch to normal mode for editing
          autocmd BufReadPost,FileReadPost *.gpg set nobin
          autocmd BufReadPost,FileReadPost *.gpg let &ch = ch_save|unlet ch_save
          autocmd BufReadPost,FileReadPost *.gpg execute ":doautocmd BufReadPost " . expand("%:r")

          " Convert all text to encrypted text before writing
          " (If you use tcsh, you may need to alter this line.)
          autocmd BufWritePre,FileWritePre *.gpg '[,']!gpg --default-recipient-self -ae 2>/dev/null
          " Undo the encryption so we are back in the normal text, directly
          " after the file has been written.
          autocmd BufWritePost,FileWritePost *.gpg u
          augroup END
    endif
" }
" }

" vim:set ft=vim sw=4 ts=4:
