set nocompatible " Disable vi compatibility

" vim-airline
" if !exists('g:airline_symbols')
"   let g:airline_symbols = {}
" endif
" let g:airline_symbols.space = "\ua0"
" set noshowmode
"
" let g:airline_powerline_fonts = 1
" let g:airline#extensions#tabline#enabled = 1
" let g:airline_theme = "solarized"
" let g:airline_solarized_bg = "dark"
" set laststatus=2

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
filetype plugin indent on   " Use filetype plugins

" powerline
set rtp+=~/dotfiles/powerline/powerline/bindings/vim
let g:Powerline_symbols = 'fancy'
set laststatus=2
set noshowmode

" Neocomplete
let g:neocomplete#enable_at_startup = 1   " Start it
let g:neocomplete#enable_auto_select = 0  " Disable autoselect
let g:neocomplete#max_list = 25           " show 25 results in popup

autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags " customize omni completion
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"                   " make tab select entry

set showcmd " show commands in the status bar
" by default we go with 4 space indent and spaces
set expandtab
set softtabstop=4
set shiftwidth=4
set tabstop=4

set encoding=utf-8        " Utf-8 everything
set fileencodings=utf-8

set number " show line number in gutter

" clear out search buffer easier
nmap <silent> ,/ :let @/=""<CR>

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

" If we are using Javascript, we need 2 spaces indents and not tabs
autocmd FileType javascript set sw=2
autocmd FileType javascript set ts=2
autocmd FileType javascript set sts=2

" Nerdtree support
map <C-n> :NERDTreeToggle<CR>

" Set file format to Unix
set ff=unix

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

" Change history to 200 items
set history=1000

" Training wheels, disable arrows
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

" Remove trailling spaces
fun! <SID>ReplaceTabs()
    let l = line(".")
    let c = col(".")
    %s/\t/    /e
    call cursor(l, c)
endfun

" wildmode to match behaviour of zsh
set wildmenu
set wildmode=list:longest,full

" Git commit messages need love too
autocmd Filetype gitcommit setlocal spell textwidth=72

" vimrc
autocmd FileType vim setlocal expandtab shiftwidth=2 tabstop=8 softtabstop=2
set term=xterm-256color
set termencoding=utf-8
" Color scheme
set t_Co=256
set background=dark
let g:solarized_contrast="normal"
let g:solarized_visibility="high"
colorscheme solarized


" Gvim
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

let mapleader = "\<Space>" " space as leader key

set autoread                        " Reload files that have not been modified
set list                            " Show hidden characters
set listchars=tab:›\ ,eol:¬,trail:⋅ "Set the characters for the invisibles
set relativenumber                  " Show relative line numbers
set scrolloff=999                   " Keep the cursor centered in the screen
set showmatch                       " Highlight matching braces
set splitbelow                      " Splits show up below by default
set splitright                      " Splits go to the right by default


" Search settings
set hlsearch   " Highlight results
set ignorecase " Ignore casing of searches
set incsearch  " Start showing results as you type
set smartcase  " Be smart about case sensitivity when searching

" Shortcut to yanking to the system clipboard
map <leader>y "+y
map <leader>p "+p

" Expand in command mode to the path of the currently open file
cnoremap %% <C-R>=expand('%:h').'/'<CR>

" Buffer management
nnoremap <leader>d   :bd<cr>

" Clear whitespace at the end of lines automatically
autocmd BufWritePre * :%s/\s\+$//e

" Toogle relative line number
nnoremap <silent><leader>n :set relativenumber!<cr>

" History undo
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo

" disable HL search
nmap <silent><leader>/ :nohlsearch<CR>

" Fugitive
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

" performance improvements?
set nocursorline        " Don't paint cursor line
set nocursorcolumn      " Don't paint cursor column
set lazyredraw          " Wait to redraw
set ttyfast             " Fast tty

"----------------------------------------------------------------------
" Key Mappings
"----------------------------------------------------------------------
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

" GIT is there for this
set nobackup       " no backup files
set nowritebackup  " only in case you don't want a backup file while editing
set noswapfile     " no swap files

" Misc
set modelines=5    " Enable mode line to tell vim what to do of odd files

" reload vimrc automatically
autocmd! bufwritepost .vimrc source %
