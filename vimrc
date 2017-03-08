"Notes:
" map makes key mapping work in normal mode, imap makes it work in insert mode
" <silent> tells not to echo to the statusline what it is doing during execution
" ! - exclamation point at the end of a setting tells vim to toggle the value

" RR NOTE FOR FONTS: For vim fonts to work properly, get the powerline fonts from https://github.com/powerline/fonts
" and put them in ~/.fonts/ and use the command fc-cache -fv to update the fonts cache,
" see https://www.cyberciti.biz/faq/howto-debian-install-use-ms-windows-truetype-fonts-under-xorg/ for help
let g:My_Airline_Enabled        = 1 "airline is a lightweight alternative for powerline, uses powerline-fonts
let g:My_Colored_Cursor_Enabled = 1 " Colored cursor settings
let g:My_Conky_Syntax_Enabled   = 1
let g:My_CtrlP_Enabled          = 1
let g:My_Fugitive_Enabled       = 1
let g:My_Gundo_Enabled          = 0
let g:My_Matchit_Enabled        = 1
let g:My_MBE_Enabled            = 0
let g:My_NerdTree_Enabled       = 1
let g:My_Numbers_Enabled        = 0
let g:My_Powerline_Enabled      = 0
let g:My_PowerlineFont_Enabled  = 1
let g:My_PyMode_Enabled         = 0 " Note: use either syntastic or pymode
let g:My_Spellcheck_Enabled     = 1
let g:My_Syntastic_Enabled      = 1
let g:My_Tabularize_Enabled     = 0
let g:My_Taglist_Enabled        = 1
let g:My_PyLint_Mode_Enabled    = 0
let g:My_PyMode_Indent_Enabled  = 1
let g:My_Vundle_Enabled         = 1 " Manage all the plugin bundles
let g:My_edit_gpg_file_Enabled  = 1 

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
    hi Search cterm=NONE ctermfg=grey ctermbg=black
endif

" VIM_UI {
    " in insert mode jk is the equivalent of <Esc>
    inoremap jk <ESC>
    set nocompatible
    "set mouse=a
    set encoding=utf-8
    set backup                  "have vim backup files
    set backupdir=~/.vim/backup "save them here
    set modeline                " set filetype specific settings from a :vim command in the first few lines of the file
    set ruler                   "show current position
    set hlsearch                "highlight search results
    set magic                   "for regular expressions turn magic on
    set showmatch               "show matching brackets when text indicator is over them
    set mat=2                   "how many tenths of a second to blink when matching brackets
    set softtabstop=4           "Insert 4 spaces when tab is pressed
    set tabstop=4               "tabstops every 4 columns
    set shiftwidth=4            "4 cols for >> etc
    set expandtab               "convert tabs to spaces
    set shiftround              "Round indent to nearest shiftwidth multiple
    set nowrapscan              "dont wrap around end when / searching
    set lbr                     "linebreak on 500 char
    set tw=500                  "linebreak on 500 char
    set autochdir " automatically change window's cwd to file's dir
    "set noautochdir "do not change window's cwd to file's dir
    set undodir=~/.vim/undodir
    set undofile
    set undolevels=1000
    set undoreload=1000
    " Don't use Ex mode, use Q for formatting
    map Q gq



    " Return to last edit position when opening files (You want this!)
    autocmd BufReadPost *
         \ if line("'\"") > 0 && line("'\"") <= line("$") |
         \   exe "normal! g`\"" |
         \ endif
    " Remember info about open buffers on close
    set viminfo^=%
" }

" My Leader Settings {
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

filetype off " Turn filetype on later. vundle needs it off
" Bundl Settings {
    if g:My_Vundle_Enabled
        set rtp+=~/.vim/bundle/vundle
        call vundle#rc()

        Bundle 'gmarik/vundle'
        Bundle 'scrooloose/nerdcommenter'
        Bundle 'davidhalter/jedi-vim'
        Bundle 'ervandew/supertab'
        Bundle 'altercation/vim-colors-solarized'
        "Bundle 'Lokaltog/vim-distinguished'
    endif
" }

"Vim-airline Settings {
    if g:My_Airline_Enabled
        Bundle 'bling/vim-airline'
        "let g:airline_section_b = '%{strftime("%c")}'
        let g:airline_section_y = 'B# %{bufnr("%")}'
        let g:airline#extensions#tabline#enabled = 0
        let g:airline#extensions#tabline#left_sep = ' '
        let g:airline#extensions#tabline#left_alt_sep = '|'
        let g:airline_powerline_fonts = 1
    endif
" }

" Colored Cursor {
    if g:My_Colored_Cursor_Enabled
        " Changing cursor colors depending on mode
        " taken from http://vim.wikia.com/wiki/Configuring_the_cursor
        if &term =~ "xterm\\|rxvt"
          " use an orange cursor in insert mode
          let &t_SI = "\<Esc>]12;orange\x7"
          " use a red green otherwise
          let &t_EI = "\<Esc>]12;green\x7"
          silent !echo -ne "\033]12;red\007"
          " reset cursor when vim exits
          autocmd VimLeave * silent !echo -ne "\033]112\007"
          " use \003]12;gray\007 for gnome-terminal
        endif
    endif
" }

" Conky Syntax Settings {
let g:My_Conky_Syntax_Enabled   = 1
    if g:My_Conky_Syntax_Enabled
        Bundle 'smancill/conky-syntax.vim'
    endif
" }

" Fugitive Settings {
    if g:My_CtrlP_Enabled
        Bundle 'kien/ctrlp.vim'
        set runtimepath^=~/.vim/bundle/ctrlp.vim
    endif
" }

" Fugitive Settings {
    if g:My_Fugitive_Enabled
        Bundle 'tpope/vim-fugitive'
        set statusline+=%{fugitive#statusline()}
        map <leader>gs :Gstatus <CR>
        map <leader>gd :Gdiff <CR>
        map <leader>gc :Gcommit <CR>
        map <leader>gb :Gblame <CR>
        map <leader>gl :Glog <CR>
        map <leader>gp :Git push <CR>
    endif
" }

" Gundo Settings {
    if g:My_Gundo_Enabled
        Bundle 'sjl/gundo.vim'
        nnoremap <F5> :GundoToggle<CR>
    endif
" }

" Matchit Settings {
    if g:My_Matchit_Enabled
        Bundle 'tmhedberg/matchit'
    endif
" }

" Mini buffer explorer Settings {
    if g:My_MBE_Enabled
        Bundle 'fholgado/minibufexpl.vim'
        map <Leader>e :MBEOpen<cr>
        map <Leader>c :MBEClose<cr>
        map <Leader>t :MBEToggle<cr>
    endif
" }

" NerdTree Settings {
    if g:My_NerdTree_Enabled
        Bundle 'scrooloose/nerdtree'
        map <F2> :NERDTreeToggle<CR>
        map  <silent> <Leader>n3  :NERDTreeToggle<CR>
    endif
" }
"
" Numbers Settings {
    if g:My_Numbers_Enabled
        Bundle 'myusuf3/numbers.vim'
        set number
        nnoremap <F3> :NumbersToggle<CR>
        nnoremap <F4> :NumbersOnOff<CR>
        map  <silent> <Leader>nt  :NumbersToggle<CR>
        map  <silent> <Leader>no  :NumbersOnOff<CR>
        let g:numbers_exclude = ['unite', 'tagbar', 'startify', 'gundo', 'vimshell', 'w3m', 'tagbar', 'gundo', 'minibufexpl', 'nerdtree']$
    endif
" }

" Powerline Settings {
    if g:My_PowerlineFont_Enabled
        Bundle 'Lokaltog/powerline-fonts'
        set guifont=Inconsolata\ for\ Powerline "make sure to escape the spaces in the name properly
        " set guifont=DejaVu\ Sans\ Mono\ for\ Powerline "make sure to escape the spaces in the name properly
        " set guifont=Source\ Code\ Pro\ for\ Powerline "make sure to escape the spaces in the name properly
    endif

    if g:My_Powerline_Enabled
        Bundle 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
        set guifont=DejaVu\ Sans\ Mono
        "set guifont=Liberation\ Mono\ for\ Powerline\ 10
        set laststatus=2
        let g:Powerline_symbols = 'fancy'

        " address the issue of delay after pressing escape key
        set ttimeoutlen=10
        augroup FastEscape
            autocmd!
            au InsertEnter * set timeoutlen=0
            au InsertLeave * set timeoutlen=1000
        augroup END
    endif
" }

" Python-mode Settings {
    if g:My_PyMode_Enabled
        Bundle 'klen/python-mode'
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
        let g:pymode = 1 " turn it off/on
        let g:pymode_rope = 0

        " Documentation
        let g:pymode_doc = 1
        let g:pymode_doc_key = 'K'

        "Linting
        let g:pymode_lint = 1
        let g:pymode_lint_checker = "pep8"
        "let g:pymode_lint_checker = "pyflakes,pep8"
        let g:pymode_lint_write = 1 " Auto check on save

        " Support virtualenv
        let g:pymode_virtualenv = 1

        " Enable breakpoints plugin
        let g:pymode_breakpoint = 0
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
        "
        " this line is to prevent pymode from turning on line numbers at start
        autocmd FileType python setlocal nonumber

        noremap <F8> :PyLintAuto<CR>
    endif
" }

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
        Bundle 'scrooloose/syntastic'
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
        Bundle 'vim-scripts/taglist.vim'
    endif
" }

" Tabularize {
    if g:My_Tabularize_Enabled
        Bundle 'godlygeek/tabular'
        nmap <Leader>a= :Tabularize /=<CR>
        vmap <Leader>a= :Tabularize /=<CR>
        nmap <Leader>a: :Tabularize /:<CR>
        vmap <Leader>a: :Tabularize /:<CR>
        nmap <Leader>a:: :Tabularize /:\\zs<CR>
        vmap <Leader>a:: :Tabularize /:\\zs<CR>
        nmap <Leader>a, :Tabularize /,<CR>
        vmap <Leader>a, :Tabularize /,<CR>
        nmap <Leader>a| :Tabularize /|<CR>
        vmap <Leader>a| :Tabularize /|<CR>
    endif
" }

" PyMode_Indent {
    if g:My_PyMode_Indent_Enabled
        Bundle 'hynek/vim-python-pep8-indent'
        let g:pymode_indent = 0
    endif
" }

" PyLintMode {
    if g:My_PyLint_Mode_Enabled
        Bundle 'vim-scripts/pylint-mode'
        let g:PyLintCWindow   = 1
        let g:PyLintSigns     = 1
        let g:PyLintOnWrite   = 1
        "let g:PyLintDissabledMessages = 'C0103,C0111,C0301,W0141,W0142,W0212,W0221,W0223,W0232,W0401,W0613,W0631,E1101,E1120,R0903,R0904,R0913'
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
        
" And set some nice chars to do it with
set listchars=tab:»\ ,eol:¬

" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
         \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

filetype plugin indent on   "set filetype on only after vundle as loaded
