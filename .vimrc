"┃ ~/.vimrc
"┣━━━━━━━━━
"┃ mjturt

"------------------"
" VIM-Plug install "
"------------------"

if empty(glob('~/.vim/autoload/plug.vim'))
   silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

"---------"
" Plugins "
"---------"

" Completion
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Syntax
Plug 'vim-syntastic/syntastic'
Plug 'vitalk/vim-shebang'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'ricpelo/vim-gdscript'
Plug 'tmux-plugins/vim-tmux'

" Automation
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'tpope/vim-surround'

" Interface
Plug 'easymotion/vim-easymotion'
Plug 'farmergreg/vim-lastplace'
Plug 'xolox/vim-misc'
Plug 'tpope/vim-eunuch'
Plug 'google/vim-searchindex'
Plug 'lilydjwg/colorizer'
Plug 'francoiscabrol/ranger.vim'
Plug 'ap/vim-buftabline'
Plug 'ryanoasis/vim-devicons'
Plug 'gcavallanti/vim-noscrollbar'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Color themes
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'NLKNguyen/papercolor-theme'
Plug 'jacoborus/tender.vim'
Plug 'xero/sourcerer.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'mhartington/oceanic-next'

call plug#end()

"----------"
" Settings "
"----------"

syntax on
filetype plugin indent on
set nocompatible
set encoding=utf-8

"set cursorline
"set cursorcolumn
set ruler
set showmatch
set nowrap
set hlsearch
set noshowmode
set list listchars=tab:∙\ ,extends:,precedes:
set hidden
set shortmess=atI
set laststatus=2

set number relativenumber

set ttyfast
set mouse=a
set showcmd
set title
set noswapfile
set report=0
set backspace=indent,eol,start
set whichwrap+=<,>,h,l
set autoread
set autochdir
set clipboard=unnamedplus
set lazyredraw
set ttimeoutlen=50

set incsearch
set ignorecase
set smartcase

set nofoldenable
set foldmethod=indent

set expandtab
set shiftwidth=3
set softtabstop=3
set smarttab
"set tabstop=3

set autoindent
"set copyindent
set smartindent

set sidescroll=40
set scrolloff=3

set backupdir=~/.vim/temp/backup
set directory=~/.vim/temp/swap
set undodir=~/.vim/temp/undo
set backup
set undofile

autocmd! bufwritepost .vimrc source ~/.vimrc
autocmd VimLeave * call system("xsel -ib", getreg('+'))

autocmd BufReadPost *.doc silent %!antiword "%" 
autocmd BufWriteCmd *.doc set readonly
autocmd BufReadPost *.odt,*.odp silent %!odt2txt "%"
autocmd BufWriteCmd *.odt set readonly
autocmd BufReadPost *.pdf  silent %!pdftotext -nopgbrk -layout -q -eol unix "%" - | fmt -w78
autocmd BufWriteCmd *.pdf set readonly
autocmd BufReadPost *.rtf silent %!unrtf --text "%"
autocmd BufWriteCmd *.rtf set readonly

"------------"
" Appearance "
"------------"

set titlestring=%(\ %M%)%(\ %F%)%a\ -\ 

color sourcerer

set background=dark
hi Normal guibg=NONE ctermbg=NONE
hi Visual ctermbg=3 ctermfg=0
hi TabLine ctermbg=NONE ctermfg=101
hi TabLineFill ctermbg=NONE ctermfg=101
hi TabLineSel cterm=bold ctermbg=101 ctermfg=16
hi LineNr cterm=bold ctermbg=NONE ctermfg=237

" Cursor color and shape
if &term =~ "xterm\\|rxvt-unicode-256color"
   let &t_SI = "\<Esc>]12;Green\x7"
   let &t_EI = "\<Esc>]12;DarkCyan\x7"
   let &t_SR = "\<Esc>]12;Red\x7"
   let &t_EI .= "\<Esc>[1 q"
   let &t_SR .= "\<Esc>[4 q"
   let &t_SI .= "\<Esc>[5 q"
"   autocmd VimLeave * silent execute "!echo -en \<esc>[3 q"
endif

if exists('$TMUX')
   let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]12;Green\x7\<Esc>\\"
   let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]12;DarkCyan\x7\<Esc>\\"
   let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]12;Red\x7\<Esc>\\"
   let &t_EI .= "\<Esc>Ptmux;\<Esc>\<Esc>[1 q\<Esc>\\"
   let &t_SR .= "\<Esc>Ptmux;\<Esc>\<Esc>[4 q\<Esc>\\"
   let &t_SI .= "\<Esc>Ptmux;\<Esc>\<Esc>[5 q\<Esc>\\"
"   autocmd VimLeave * silent execute "!echo -en \<esc>[3 q"
endif

"-------------"
" Status line "
"-------------"

set statusline=
set statusline+=%1*\ %{ModeCurrent()}%*%2*%*
set statusline+=\ %-3.(%3*%m%*%)\ %4*%f%*\ %y
set statusline+=\ %{fugitive#head()!=''?'\ \ '.fugitive#head().'\ ':''}
set statusline+=%h%r
set statusline+=%=
set statusline+=%#warningmsg#%{SyntasticStatuslineFlag()}%*
set statusline+=%-16.(C:%c\ L:%4*%l%*/%L%)
set statusline+=%{noscrollbar#statusline(15,'▒','▉')}
set statusline+=\ %4*%n%*

" Mode indicator
let g:currentmode={ 'n' : 'N ', 'no' : 'N·O ', 'v' : 'V ', 'V' : 'V·L ', '^V' : 'V·B ', 's' : 'S ', 'S': 'S·L ', '^S' : 'S·B ', 'i' : 'I ', 'R' : 'R ', 'Rv' : 'V·R ', 'c' : 'C ', 'cv' : 'V-Ex ', 'ce' : 'Ex ', 'r' : 'P ', 'rm' : 'M ', 'r?' : 'Confirm ', '!' : 'S ', 't' : 'T '}
function! ModeCurrent() abort
    let l:modecurrent = mode()
    let l:modelist = toupper(get(g:currentmode, l:modecurrent, 'V·B '))
    let l:current_status_mode = l:modelist
    return l:current_status_mode
endfunction

" Statusline colors
hi StatusLine cterm=NONE ctermbg=NONE ctermfg=101
hi User1 cterm=bold ctermbg=101   ctermfg=16   guibg=green guifg=red
hi User2 cterm=bold ctermbg=NONE  ctermfg=101  guibg=red   guifg=blue
hi User3 cterm=bold ctermbg=NONE  ctermfg=64 guibg=blue  guifg=green
hi User4 cterm=bold ctermbg=NONE  ctermfg=101  guibg=red   guifg=blue
au InsertEnter * hi User1 ctermbg=16 ctermfg=101 | hi User2 ctermfg=16
au InsertLeave * hi User1 ctermbg=101 ctermfg=16 | hi User2 ctermfg=101

"-----------------"
" Plugin settings "
"-----------------"

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_c_remove_include_errors = 1

let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

let g:deoplete#enable_at_startup = 1

"Projects for syntastic
source ~/.vim/projects.vim

"-------------------"
" Keyboard mappings "
"-------------------"

noremap j h
noremap k j
noremap l k
noremap ö l

nmap <silent> <C-w>l :wincmd k<CR>
nmap <silent> <C-w>k :wincmd j<CR>
nmap <silent> <C-w>j :wincmd h<CR>
nmap <silent> <C-w>ö :wincmd l<CR>

nmap <C-o> o<Esc>
"set pastetoggle=<F3>
map <S-k> :bprevious<CR>
map <S-l> :bnext<CR>
map + $
map <C-a> <Nop>
nmap QQ :q<CR>
nmap WW :wq<CR>
vmap <C-c> y

let mapleader="'"
nnoremap <silent> <Leader>l :exe "resize +5"<CR>
nnoremap <silent> <Leader>k :exe "resize -5"<CR>
nnoremap <silent> <Leader>ö :exe "vertical resize +5"<CR>
nnoremap <silent> <Leader>j :exe "vertical resize -5"<CR>

nnoremap <leader>ev :tabnew ~/.vimrc<CR>
noremap <silent> <Leader>w :call ToggleWrap()<CR>
noremap <Leader>gg gg=G
nmap <leader>/ :nohl<CR>
map <leader>X :!chmod +x %<CR><CR>
map <leader>W :%s/ \{2,}/ /g<CR>
map <leader>c :set cursorline!<CR>:set cursorcolumn!<CR>
noremap <silent> <leader>n :let [&nu, &rnu] = [!&rnu, &nu+&rnu==1]<CR>
noremap <leader>p "0p
noremap <leader>d di"

map <F5> :call CompileRunGcc()<CR>
vnoremap <F9> "ry:call Func2X11()<cr>

cmap Q q
cmap W w

" Mappings for plugins
nmap s <Plug>(easymotion-overwin-f)
nmap <leader>s ys$"
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

"----------"
" Commands "
"----------"

command! Sw silent execute 'write !sudo tee ' . shellescape(@%, 1) . ' >/dev/null'
command! -nargs=1 Shebang :new <args> | 0put =\"#!/bin/bash\<nl>\"|$
command! -nargs=1 Newdot :new <args> | 0put =\"#┃\<nl>#┣━━━━━━━━━\<nl>#┃ mjturt\"|$

"-----------"
" Functions "
"-----------"

" Compiler
func! CompileRunGcc()
   exec"w"
   if &filetype == 'c'
      exec "!gcc % -o %<"
      exec "!time ./%<"
   elseif &filetype == 'cpp'
      exec "!g++ % -o %<"
      exec "!time ./%<"
   elseif &filetype == 'java'
      exec "!javac %"
      exec "!time java -cp %:p:h %:t:r"
   elseif &filetype == 'sh'
      exec "!time bash %"
   elseif &filetype == 'python'
      exec "!time python %"
   elseif &filetype == 'html'
      exec "!firefox % &"
   elseif &filetype == 'go'
      exec "!go build %<"
      exec "!time go run %"
   endif
endfunc

" ToggleWrap
func! ToggleWrap()
   if &wrap
      echo "Wrap OFF"
      setlocal nowrap
      set virtualedit=all
      silent! nunmap <buffer> <Up>
      silent! nunmap <buffer> <Down>
      silent! nunmap <buffer> <Home>
      silent! nunmap <buffer> <End>
      silent! iunmap <buffer> <Up>
      silent! iunmap <buffer> <Down>
      silent! iunmap <buffer> <Home>
      silent! iunmap <buffer> <End>
   else
      echo "Wrap ON"
      setlocal wrap linebreak nolist
      set virtualedit=
      setlocal display+=lastline
      noremap  <buffer> <silent> <Up>   gk
      noremap  <buffer> <silent> <Down> gj
      noremap  <buffer> <silent> <Home> g<Home>
      noremap  <buffer> <silent> <End>  g<End>
      inoremap <buffer> <silent> <Up>   <C-o>gk
      inoremap <buffer> <silent> <Down> <C-o>gj
      inoremap <buffer> <silent> <Home> <C-o>g<Home>
      inoremap <buffer> <silent> <End>  <C-o>g<End>
   endif
endfunction

" Fallback copy
function! Func2X11()
   :call system('xclip -selection c', @r)
endfunction

"--------------"
" GUI-settings "
"--------------" 

if has("gui_running")
   if has("gui_gtk2") || has("gui_gtk3")
      set guifont=ShureTechMono\ Nerd\ Font\ Mono\ 10
   endif
endif
