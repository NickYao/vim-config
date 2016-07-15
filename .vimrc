"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"vimrc 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
"set mouse+=n
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else
"quick access to vimrc
set mapleader=","
map <silent> <leader>cs :e ~./.vimrc<cr>
map <silent> <leader>ce :source ~/.vimrc<CR>
au! bufwritepost .vimrc source  ~/.vimrc

set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
set nu
syntax on
set softtabstop=4
set tabstop=4
set autoindent
set cindent
set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s
"set roler
if &term=="xterm"
	set t_Co=8
	set t_Sb=^[[4%dm
	set t_Sf=^[[3%dm
endif

"acp
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {}<ESC>i
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap < <><ESC>i
:inoremap > <c-r>=ClosePair('>')<CR>

function ClosePair(char)
	if getline('.')[col('.') - 1] == a:char
		return "\<Right>"
	else
		return a:char
	endif
endf
""""""""""""""""""""""""""""""
"windows manager
""""""""""""""""""""""""""""""
:nmap wm :WMToggle<CR>
let g:winManagerWindowLayout = 'FileExplorer'
:nmap ZZZ :WMClose<cr><C-V><Esc>:wq!<cr>  
:imap ZZZ <C-V> <Esc>:WMClose<CR><C-V><Esc>:wq!<CR> 
:nmap ZQ :WMClose<cr><C-V><Esc>:wq!<cr>
:imap ZQ :<C-V> <Esc>:WMClose<cr><C-V><Esc>:qall!<cr> 
nmap wf :FirstExplorerWindow<CR>
let g:persistentBehaviour=0
"netrw setting
let g:netrw_winsize = 30
"nmap <silent> <leader>fe :Sexplore!<cr>

""""""""""""""""""""""""""""""
let mapleader=","
let g:netrw_winsize = 30
nmap  <leader>fe :Sexplore!<cr> 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Taglist settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Right_Window=1
nmap tt :TlistToggle<CR> 
let Tlist_WinWidth=20
set updatetime=1500

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"auto commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"au VimEnter * WMToggle 
"au VimEnter * TlistToggle
"au VimEnter * q
au VimLeave * mksession! ~/.vim/session/%:t.session
au VimLeave * wviminfo! ~/.vim/session/%:t.viminfo
"autocmd VimEnter * wm

nmap sf /<C-R>=expand("<cword>")<CR><CR>
""""""""""""""""""""""""""""""
" BufExplorer
""""""""""""""""""""""""""""""
 let g:bufExplorerDefaultHelp=0       " Do not show default help.
 let g:bufExplorerShowRelativePath=1  " Show relative paths.
 let g:bufExplorerSortBy='mru'        " Sort by most recently used.
 let g:bufExplorerSplitRight=0        " Split left.
 let g:bufExplorerSplitVertical=1     " Split vertically.
 let g:bufExplorerSplitVertSize = 30  " Split width
 let g:bufExplorerUseCurrentWindow=1  " Open in new window.
 autocmd BufWinEnter \[Buf\ List\] setl nonumber 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"auto load ctags database
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let vi_cur_file_name=argv(0)
"echomsg \"you are opening file \"vi_cur_file_name
let g:path2ctags=system("~/.vim/bash/vip ".vi_cur_file_name)
"echo g:path2ctags
let g:path2ctags=strpart(g:path2ctags,0,strlen(g:path2ctags)-1)
if (filereadable(g:path2ctags."/tags"))
	execute 'set tags='.g:path2ctags."/tags"
else
	execute 'set tags='
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"show file in project
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"au VimEnter * :20vsplit .

set paste 
"colorscheme bandit 
colorscheme desert_thl 
"
"  :nmap <silent> <C-T> :tabnew
":nmap <silent> tp :tabprevious<CR>
":nmap <silent> tn :tabnext<CR>
":nmap <silent> tc :tabclose<CR>
"nmap <silent> <C-T> :tabnew expand("<cword>")<CR> <C-V><Esc>wm TlistToggle<CR>
map <silent> ZZ :w!<CR>
imap <silent> ZZ <C-V> <Esc>:w!<CR>
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8

"load gdb plugin. 
source ~/.vim/macros/gdb_mappings.vim

"function to change directory to workspace top directory.
function! <SID>ChangeDir()
"		echo getcwd()
		if(filereadable(g:path2ctags."/cscope.out"))
			exe 'chdir '.g:path2ctags
		endif
"		echo getcwd()
endfunction
if !exists(':CDR')
	command -nargs=0 CDR :silent call <SID>ChangeDir()
end
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"nnoremap <leader>bs :call cscope#find('s', expand('<cword>'))<CR>
"nnoremap <leader>bg :call cscope#find('g', expand('<cword>'))<CR>
"nnoremap <leader>bc :call cscope#find('c', expand('<cword>'))<CR>
"nnoremap <leader>bt :call cscope#find('t', expand('<cword>'))<CR>
"nnoremap <leader>be :call cscope#find('e', expand('<cword>'))<CR>
"nnoremap <leader>bf :call cscope#find('f', expand('<cword>'))<CR>
"nnoremap <leader>bi :call cscope#find('i', expand('<cword>'))<CR>

"auto change directory
set autochdir

set cst
"
"set csre
"search cscope database first.
set csto=0
"set csverb
set cspc=3
"auto load cscope database
if (filereadable(g:path2ctags."/cscope.out"))
	execute ':cscope add '.g:path2ctags."/cscope.out"g:path2ctags
endif

nmap bs :CDR<CR>:cs find s <C-R>=expand("<cword>")<CR><CR>
nmap bg :CDR<CR>:cs find g <C-R>=expand("<cword>")<CR><CR>
nmap bc :CDR<CR>:cs find c <C-R>=expand("<cword>")<CR><CR>
"nnoremap   bt  :CDR<CR>:cs find t <cword><cr>
"nmap bt :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap bt :CDR<CR>:cs find t <C-R>=expand("<cword>")<CR><CR>
nmap be :CDR<CR>:cs find e <C-R>=expand("<cword>")<CR><CR>
nmap bf :CDR<CR>:cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap bi :CDR<CR>:cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap bd :CDR<CR>:cs find d <C-R>=expand("<cword>")<CR><CR>
nmap ts :ts <C-R>=expand("<cword>")<CR><CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"search cword under cursor
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap af /<C-R>=expand("<cword>")<CR><CR>
set noex 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
execute pathogen#infect()
set nobackup
let g:Tlist_WinWidth = 50
