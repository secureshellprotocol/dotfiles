set tabstop=4
set shiftwidth=4
"set expandtab
set smartindent

set backspace=indent,eol,start
set noshowmatch
let loaded_matchparen=1

set statusline=%F%m%r%h%w\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L] 
set laststatus=2

syntax on
colo evening
highlight Normal ctermbg=black

set hlsearch
set incsearch

set ignorecase
set smartcase

autocmd FileType cpp match ErrorMsg '\%>79v.\+'

nnoremap ; :
set nu

 map <F3> :if exists("syntax_on") <Bar> syntax off <Bar> else <Bar> syntax on <Bar> endif <CR>
 map <F5> :set spell! spell?<CR>

