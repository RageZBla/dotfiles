set nocompatible " Disable vi compatibility

" Getter/Setter generation
let g:phpgetset_getterTemplate =
     \ "    \n" .
     \ "    /**\n" .
     \ "     * Get %varname%.\n" .
     \ "     *\n" .
     \ "     * @return <type>\n" .
     \ "     */\n" .
     \ "    public function %funcname%()\n" .
     \ "    {\n" .
     \ "        return $this->%varname%;\n" .
     \ "    }"

let g:phpgetset_setterTemplate =
     \ "    \n" .
     \ "    /**\n" .
     \ "     * Set %varname%.\n" .
     \ "     *\n" .
     \ "     * @param  <type> $%varname%\n" .
     \ "     * @return fluent\n" .
     \ "     */\n" .
     \ "    public function %funcname%($%varname%)\n" .
     \ "    {\n" .
     \ "         $this->%varname% = $%varname%;\n" .
     \ "         return $this;\n" .
     \ "    }"

set nofoldenable                   " disable code folding
let g:DisableAutoPHPFolding = 1    " disable autofolding for PHP
let g:PIVCreateDefaultMappings = 0 " disable creation of default mapping
let g:pdv_cfg_foldmarke = 0        " disable generation of fold marker for docblocks
" PIV PHP shortcuts - create single docblock in PHP
nmap <leader>Pd <plug>PIVphpDocSingle
vmap <leader>Pd <plug>PIVphpDocRange

" Pathogen plugin management
call pathogen#infect()      " Load plugin
call pathogen#helptags()    " Load plugin help files
syntax on                   " Syntax highlighting on
filetype plugin indent on   " Enable filetype-specific indenting and plugins

" ========================================================================
" General settings
" ========================================================================

set showcmd    " show commands in the status bar
set noshowmode " don't show the current vim mode, powerline does it

" by default we go with 4 space indent and spaces
set expandtab
set softtabstop=4
set shiftwidth=4
set tabstop=4

set encoding=utf-8        " Utf-8 everything
set fileencodings=utf-8
set termencoding=utf-8

set laststatus=2 " Always show two line status
set ff=unix      " Set file format to Unix
set history=1000 " Change history to 200 items
set wildmenu     " use menu that looks like zsh
set wildmode=list:longest,full

" Color scheme
set t_Co=256
set background=dark
let g:solarized_contrast="normal"
let g:solarized_visibility="high"
colorscheme solarized

set autoread                        " Reload files that have not been modified
set autowrite                       " Automatically :write before running commands
set list                            " Show hidden characters
set listchars=tab:›\ ,eol:¬,trail:⋅ " Set the characters for the invisibles
set relativenumber                  " Show relative line numbers
set scrolloff=999                   " Keep the cursor centered in the screen
set showmatch                       " Highlight matching braces
set splitbelow                      " Splits show up below by default
set splitright                      " Splits go to the right by default
set textwidth=80
set colorcolumn=+1
set numberwidth=5
set showbreak=…

" Search settings
set hlsearch   " Highlight results
set ignorecase " Ignore casing of searches
set incsearch  " Start showing results as you type
set smartcase  " Be smart about case sensitivity when searching
if ! has('gui_running')
  set term=xterm-256color
endif

" performance improvements?
set nocursorline   " Don't paint cursor line
set nocursorcolumn " Don't paint cursor column
" set cursorline
set lazyredraw     " Wait to redraw
set ttyfast        " Fast tty

" History undo
set history=1000         " remember more commands and search history

" GIT is there for this
set nobackup       " no backup files
set nowritebackup  " only in case you don't want a backup file while editing
set noswapfile     " no swap files

" Misc
set modelines=5    " Enable mode line to tell vim what to do of odd files

set viminfo+=!
set smarttab
set gdefault " assume the /g flag is used for replace
set autoindent
set ignorecase smartcase
set grepprg=ag
" (Hopefully) removes the delay when hitting esc in insert mode
set noesckeys
set ttimeout
set ttimeoutlen=1

" Don't add the comment prefix when I hit enter or o/O on a comment line.
set formatoptions-=or

" Undo everything
set undodir=~/.vim/undo
set undofile
set undolevels=1000  " maximum number of changes that can be undone
set undoreload=10000 " maximum number lines to save for undo on a buffer reload

" ========================================================================
" File type related settings
" ========================================================================
if has('autocmd')
  " If we are using Javascript, we need 2 spaces indents and not tabs
  autocmd FileType javascript set sw=2
  autocmd FileType javascript set ts=2
  autocmd FileType javascript set sts=2

  " If we are using PHP, we need 2 spaces indents and not tabs
  autocmd FileType php set sw=4
  autocmd FileType php set ts=4
  autocmd FileType php set sts=4

  " Git commit messages need love too
  autocmd Filetype gitcommit setlocal spell textwidth=72

  " vimrc
  autocmd FileType vim setlocal expandtab shiftwidth=2 tabstop=8 softtabstop=2

  " reload vimrc automatically
  autocmd! bufwritepost .vimrc source %
  autocmd! bufwritepost vimrc source %

  " Clear whitespace at the end of lines automatically
  autocmd BufWritePre * :%s/\s\+$//e
endif

" ============================================================================
" Functions/Macro
" ============================================================================

" Remove trailling spaces
fun! <SID>ReplaceTabs()
    let l = line(".")
    let c = col(".")
    %s/\t/    /e
    call cursor(l, c)
endfun

" Handle paste in vim from tmux
fun! <SID>PasteFromTmux()
    set paste
    startinsert
    !tmux paste-buffer -p
    !tmux send-keys Escape ":set nopaste" Enter
endfun

" used to paste from tmux
function! XTermPasteBegin(ret)
  set paste
  return a:ret
endfunction

" ========================================================================
" Plugin settings
" ========================================================================

" powerline
set rtp+=~/dotfiles/powerline/powerline/bindings/vim
let g:Powerline_symbols = 'fancy'

" Neocomplete
let g:neocomplete#enable_at_startup = 1   " Start it
let g:neocomplete#enable_auto_select = 0  " Disable autoselect
let g:neocomplete#max_list = 25           " show 25 results in popup

autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags " customize omni completion
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"                   " make tab select entry

" Ultisnip
if (has('gui_running'))
  let g:UltiSnipsExpandTrigger="<C-CR>"
else
  let g:UltiSnipsExpandTrigger="<C-J>"
endif

" Tweak some things for CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/vendor/*
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_user_command = {
    \ 'types' : {
        \ 1: ['.git', 'cd %s && git ls-files'],
        \ },
    \ 'fallback': 'find %s -type f'
    \ }

" ========================================================================
" Key mappings
" ========================================================================

" Disable Ex mode
map Q <Nop>

" Disable K looking stuff up
map K <Nop>
" Leader key
let mapleader = "\<Space>" " space as leader key

" clear out search buffer easier
nmap <silent> ,/ :let @/=""<CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" easily switch between vsplit windows
map <c-j> <C-w>j
map <c-k> <C-w>k
map <c-h> <c-w>h
map <c-l> <c-w>l

" save yourself if you forgot to use sudo to save something
cmap w!! w !sudo tee % >/dev/null

" tabularize shortcut
vmap t= :Tabularize /=><CR>
vmap t" :Tabularize /"<CR>
nnoremap <silent> <leader>t= :Tabularize /=><CR>

" Nerdtree support
map <C-n> :NERDTreeToggle<CR>

" Training wheels, disable arrows
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

" Shortcut to yanking to the system clipboard
map <leader>y "+y
map <leader>p o<esc>"+p

" Let's be reasonable, shall we?
nmap k gk
nmap j gj


map <leader>P :call <SID>PasteFromTmux()<CR>

" Expand in command mode to the path of the currently open file
cnoremap %% <C-R>=expand('%:h').'/'<CR>

" Buffer management
nnoremap <leader>d   :bd<cr>

" Toogle relative line number
nnoremap <silent><leader>n :set relativenumber!<cr>

" disable HL search
nmap <silent><leader>/ :nohlsearch<CR>

" Fugitive and GIT goodness
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gr :Gread<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>ge :Gedit<CR>

" GIT workflow
" <space>gm = git checkout master
nnoremap <silent> <leader>gm :Git checkout master<CR>
" push my current work to live only works from master
nnoremap <silent> <leader>gli :Git pull --rebase<CR>:Git checkout live<CR>:Git pull --rebase origin live<CR>:Git merge master<CR>:Git push origin live<CR>:Git checkout master<CR>

" Remap a key sequence in insert mode to kick me out to normal
" mode. This makes it so this key sequence can never be typed
" again in insert mode, so it has to be unique.
inoremap jj <esc>
inoremap jJ <esc>
inoremap Jj <esc>
inoremap JJ <esc>
inoremap jk <esc>
inoremap jK <esc>
inoremap Jk <esc>
inoremap JK <esc>

" test tmux
let &t_ti = &t_ti . "\e[?2004h"
let &t_te = "\e[?2004l" . &t_te
let &pastetoggle = "\e[201~"
map <F10> <Esc>[201~
imap <F10> <Esc>[201~

map <special> <expr> <Esc>[200~ XTermPasteBegin("i")
imap <special> <expr> <Esc>[200~ XTermPasteBegin("")
cmap <special> <Esc>[200~ <nop>
cmap <special> <Esc>[201~ <nop>

" Ctrl s save
" Note that remapping C-s requires flow control to be disabled
" (e.g. in .bashrc or .zshrc)
map <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>
map <C-t> <esc>:tabnew<CR>
map <C-x> <C-w>c

" Emacs-like beginning and end of line.
imap <c-e> <c-o>$
imap <c-a> <c-o>^
map <leader>vi :tabe ~/.vimrc

" ============================================================================
" Gvim
" ============================================================================
if has("gui_running")
    " Disable any visual or audible bell
    au GUIEnter * set vb t_vb=

    " Set font
    set guifont=Inconsolata\ for\ Powerline\ Bold\ 12


    " remove superfluous chrome
    set guioptions-=m
    set guioptions-=l
    set guioptions-=L
    set guioptions-=t
    set guioptions-=T
    set guioptions+=c
    set guioptions-=l
    set guioptions-=r
    set guioptions-=b
endif
