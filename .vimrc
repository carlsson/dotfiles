execute pathogen#infect()

syntax on
syntax enable
filetype plugin indent on
set number
let g:solarized_termcolors=256
set t_Co=256 
set background=light
colorscheme solarized

set smartindent
set tabstop=2 
set shiftwidth=4

set history=10000
let mapleader=","

" Fix slow O inserts
set timeout timeoutlen=1000 ttimeoutlen=100

" Don't make backups at all
set nobackup
set nowritebackup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp:w

" If a file is changed outside of vim, automatically reload it without asking
set autoread

set paste

" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    let selection = system(a:choice_command . " | selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction

" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
nnoremap <leader>f :call SelectaCommand("find * -type f", "", ":e")<cr>

command! W :w

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

" Enable goimports to automatically insert import paths
let g:go_fmt_command = "goimports"
