syntax on
set scrolloff=10

set tabstop=4
set shiftwidth=4
set smartindent

inoremap <C-w> <ESC><C-w>

set number

" rimuove i commenti automatici
set formatoptions-=cro
" risolve il problema che backspace non funziona
set backspace=indent,eol,start

set foldmethod=syntax
set foldnestmax=1

" inserisce un unico carattere
noremap <Space> i_<Esc>r

" inserisce un unico carattere
noremap <c-a> a_<Esc>r

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'preservim/vimux'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
call plug#end()

" Start NERDTree and put the cursor back in the other window.
" autocmd VimEnter * NERDTree | wincmd p

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>

" Per far funzionare il colore di airline
set t_Co=256
