"
"       (_)                   
" __   ___ _ __ ___  _ __ ___ 
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__ 
" (_)_/ |_|_| |_| |_|_|  \___|
"                             
"                             
"
""""""""""""""""""""""""""""""""""
""""""" frequently used  """"""
"""""""""""""""""""""""""""""

set nocompatible    "unsetting vi
syntax on
set noerrorbells
set tabstop=4 softtabstop=4 
set shiftwidth=4
set expandtab
set smartindent
set rnu
set nu
set nowrap
set smartcase
set incsearch
set splitright
set path+=**            "file finder with glob
set wildmenu            "menu for file finder 
set autowrite           "auto saving buffer
"set sidescrolloff=999   "scroll off curson middle
"set scrolloff=999
filetype plugin on
:imap jj <Esc>


"""""""""""""""""""""""""""""
""""""" rarely used  """"""
"""""""""""""""""""""""""

"set ut=1000
"set timeoutlen=1000
"set ttimeoutlen=0
"set cursorline
"set t_Co=256
"set spelllang=en_us
"set spell


""""""""""""""""""""""""
""""""" plugins """"""
""""""""""""""""""""

call plug#begin()
"Plug    'junegunn/goyo.vim'
Plug    'junegunn/fzf'
Plug    'junegunn/fzf.vim'
Plug    'alvan/vim-closetag'
Plug	'jiangmiao/auto-pairs'
Plug    'preservim/nerdtree'
"Plug    'vim-airline/vim-airline'
"Plug    'vim-airline/vim-airline-themes'
"Plug    'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
"Plug    'ap/vim-css-color'
Plug    'tpope/vim-surround'
Plug    'morhetz/gruvbox'
"Plug    'iamcco/markdown-preview.vim'
Plug    'Yggdroot/indentLine'
"Plug    'mattn/emmet-vim'
"Plug    'maxmellon/vim-jsx-pretty'
"Plug    'ryanoasis/vim-devicons'
Plug    'tpope/vim-commentary'
call plug#end()

""""""""""""""""""""""""""""""""""""""
""""""" .rmd :files & ripgrep """"""
""""""""""""""""""""""""""""""""""

"autocmd Filetype rmd map <F5> :!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla<enter>
nnoremap <silent> <C-f> :Files<CR>
"nnoremap <C-g> :Rg <CR>

""""""""""""""""""""""
""""""" theme """"""
""""""""""""""""""

"colorscheme ron
set bg=dark
colorscheme gruvbox
"
"
""""""""""""""""""""""""""""""
""""""" the nerd tree """"""
""""""""""""""""""""""""""

map <C-n> :NERDTreeToggle<CR>

"""""""""""""""""""""""""""""""""
""""""" vim airline conf """"""
"""""""""""""""""""""""""""""

let g:airline_powerline_fonts = 1
let g:airline_theme='minimalist'


"""""""""""""""""""""""""""""""""
""""""" xclip copy paste """"""
"""""""""""""""""""""""""""""

set pastetoggle=<F3>
"vmap <leader>xyy :!xclip -f -sel clip<CR>
vmap <C-C> :w !xclip -i -sel c<CR><CR>
"vmap <leader>xyy :w !xclip -i -sel c<CR><CR>
map <leader>xpp :-1r!xclip -o -sel c<CR>



""""""""""""""""""""""""""""""""""""""
""""""" show buffers and move """"""
""""""""""""""""""""""""""""""""""

:nnoremap <F5> :buffers<CR>:buffer<Space>


"""""""""""""""""""""""""""""""""
""""""" print full path """""""
"""""""""""""""""""""""""""""

nnoremap <leader>pfn :echo expand('%:p')<CR>

":echo expand("%")

"""""""""""""""""""""""""""""""""""""""""""""
""""""" transparent background """"""""""""
"""""""            and         """""""""" 
"""""""     line number color  """"""""
"""""""""""""""""""""""""""""""""""""

hi LineNr cterm=bold ctermfg=Blue
hi Normal guibg=NONE ctermbg=NONE



""""""""""""""""""""""""""""""""""""""""""""
""""""" fzf preview button control """""""
""""""""""""""""""""""""""""""""""""""""

let $FZF_DEFAULT_OPTS="--preview 'less {}' --bind ctrl-p:preview-up,ctrl-n:preview-down"


"""""""""""""""""""""""""""
""""""" some tips """""""
""""""""""""""""""""""

let g:livepreview_previewer = 'zathura'

nnoremap <C-s> :%s/<C-r><C-w>//g<left><left>
nnoremap <leader>java :-1read $HOME/.vim/.java.skeleton<CR>f{i
nnoremap <leader>rfce :-1read $HOME/.vim/.react.skeleton<CR>3jf(i

let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\}

"let g:user_emmet_settings = { 'indentation' : '    ' }
"


:nnoremap <F1> :e!<CR>
:nnoremap <F2> :!./run<CR>
:nnoremap <leader>t :IndentLinesToggle<CR>

"for json quotation mark that vanishes
autocmd Filetype json
  \ let g:indentLine_setConceal = 0 |
  \ let g:vim_json_syntax_conceal = 0

map I :! pdflatex --shell-escape %<CR><CR>
map S :! zathura $(echo % \| sed 's/tex$/pdf/') & disown <CR><CR>

" let g:airline#extensions#tabline#enabled = 1


