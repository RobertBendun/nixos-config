colorscheme gruvbox
" Disable background
autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE

set encoding=utf-8
set hidden
set ignorecase
set incsearch
set mouse=a
set nohlsearch
set noruler
set number relativenumber
set shiftwidth=0
set smartcase
set softtabstop=2
set splitbelow splitright
set tabstop=2
set termguicolors
set noerrorbells
set scrolloff=8
set signcolumn=no
set foldcolumn=0
set nofoldenable

set noswapfile
set nobackup
set undodir=~/.cache/vim/undodir
set undofile

set wildmode=longest,list,full

autocmd InsertEnter * norm zz

augroup Bendun
	" Delete all trailing whitespace and newlines at the end of the file
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritePre * %s/\n\+\%$//e
augroup END

let mapleader = " "
let g:haskell_classic_highlighting = 1

" COC Configuration

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
