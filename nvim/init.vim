"*****************************************************************************

if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.nvim/bundle/neobundle.vim/
endif

let neobundle_readme=expand('~/.nvim/bundle/neobundle.vim/README.md')

if !filereadable(neobundle_readme)
  echo "Installing NeoBundle..."
  echo ""
  silent !mkdir -p ~/.nvim/bundle
  silent !git clone https://github.com/Shougo/neobundle.vim ~/.nvim/bundle/neobundle.vim/
  let g:not_finsh_neobundle = "yes"

  " Run shell script if exist on custom select language
endif

" Required:
call neobundle#begin(expand('~/.nvim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

"*****************************************************************************
" NeoBundle install packages
"*****************************************************************************
" Core
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-vinegar'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'godlygeek/tabular'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'itchyny/lightline.vim'

" Color schemes
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'reedes/vim-colors-pencil'
" Distraction-free writing mode
NeoBundle 'junegunn/goyo.vim'

" Qdo command for search/replace in quickfix list
NeoBundle 'henrik/vim-qargs'

" See git status in gutter
NeoBundle 'airblade/vim-gitgutter'

" Syntax checking
NeoBundle "scrooloose/syntastic"

" Syntax highlighting
NeoBundle 'sheerun/vim-polyglot'

" Snippets
NeoBundle 'SirVer/ultisnips'
NeoBundle 'honza/vim-snippets'

" --- Additional Language / Syntax Support
" Ruby Bundle
NeoBundle "tpope/vim-rails"
NeoBundle "tpope/vim-rake"
NeoBundle "tpope/vim-bundler"
NeoBundle "thoughtbot/vim-rspec"
NeoBundle 'asux/vim-capybara'
NeoBundle 'tonekk/vim-ruby-capybara'

" HTML Bundle
NeoBundle 'amirh/HTML-AutoCloseTag'
NeoBundle 'JulesWang/css.vim'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


"*****************************************************************************
" Basic Setup
"*****************************************************************************"
" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" Fix backspace indent
set backspace=indent,eol,start

" Tabs. May be overriten by autocmd rules
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Disable wrapping
set wrap!

" Map leader to ,
let mapleader=' '

" Enable hidden buffers
set hidden

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Encoding
set bomb
set binary

" Directories for swp files
set nobackup
set noswapfile

" misc
set fileformats=unix,mac
set showcmd
set shell=/bin/zsh

"*****************************************************************************
" Visual Settings
"*****************************************************************************
syntax on
set ruler
set relativenumber
set number
set colorcolumn=80

" colorscheme onedark
colorscheme base16-ocean-custom
set background=dark

let no_buffers_menu=1

set mousemodel=popup
set t_Co=256
" set cursorline

" highlight tailing whitespace
set list listchars=tab:\ \ ,trail:·

if $COLORTERM == 'gnome-terminal'
	set term=gnome-256color
else
	if $TERM == 'xterm'
		set term=xterm-256color
	endif
endif

if &term =~ '256color'
  set t_ut=
endif

" Minimum number of lines above and below cursor
set scrolloff=5

" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

""""""""""""""""""""" STATUS BAR
" Don't display the current mode (Insert, Visual, Replace)
" in the status line. This info is already shown in the Lightline status bar.
set noshowmode

set laststatus=2
let g:lightline = {
  \ 'colorscheme': 'lightline_custom',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ], [ 'filename' ], ['ctrlpmark'] ],
  \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'filetype' ] ]
  \ },
  \ 'component_function': {
  \   'filename': 'LightLineFilename',
  \   'fileformat': 'LightLineFileformat',
  \   'filetype': 'LightLineFiletype',
  \   'fileencoding': 'LightLineFileencoding',
  \   'mode': 'LightLineMode',
  \   'ctrlpmark': 'CtrlPMark',
  \ },
  \ 'component_expand': {
  \   'syntastic': 'SyntasticStatuslineFlag',
  \ },
  \ 'component_type': {
  \   'syntastic': 'error',
  \ },
  \ 'subseparator': { 'left': '|', 'right': '|' }
  \ }

function! LightLineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
endfunction

function! LightLineFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? '⭠ '._ : ''
  endif
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP'
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

" let g:unite_force_overwrite_statusline = 0
" let g:vimfiler_force_overwrite_statusline = 0
" let g:vimshell_force_overwrite_statusline = 0

""""""""""""""""""""" STATUS BAR END

"*****************************************************************************
" Abbreviations
"*****************************************************************************
" remap annoying mistakes to something useful
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qa q
cnoreabbrev Qall qall


"*****************************************************************************
" Functions
"*****************************************************************************
if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set wrap
    set wm=2
    set textwidth=79
  endfunction
endif

"*****************************************************************************
" Autocmd Rules
"*****************************************************************************

function! s:defaultColors()
  if exists('#goyo')
    :Goyo
  endif
  colorscheme base16-ocean-custom
  set background=dark
endfunction

function! s:markdownColors()
  colorscheme pencil
  set background=light
  :Goyo
endfunction

call s:defaultColors()

" Function to preview markdown in Atom
function! s:setupMarkup()
  nnoremap <leader>p :silent !open -a Atom.app '%:p'<cr>
endfunction

" Markdown
augroup vimrc-markdown-settings
  autocmd!
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} set fo+=t tw=79
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()
  " Set colorscheme rules
  autocmd BufEnter *.{md,markdown,mdown,mkd,mkdn} call s:markdownColors()
  autocmd BufLeave *.{md,markdown,mdown,mkd,mkdn} call s:defaultColors()
augroup END

" Stop treating periods as keywords
autocmd FileType * set iskeyword-=.

" The PC is fast enough, do syntax highlight syncing from start
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync fromstart
augroup END

" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" txt
augroup vimrc-wrapping
  autocmd!
  autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

" Markdown
augroup vimrc-markdown-settings
  autocmd!
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} set fo+=t tw=80
augroup END

" Pleco flashcard import file
autocmd BufRead,BufNewFile *.pleco.txt set nowrap noexpandtab fo-=t tw=0

" ruby
augroup vimrc-ruby
  autocmd!
  autocmd BufNewFile,BufRead *.rb,*.rbw,*.gemspec setlocal filetype=ruby
  autocmd Filetype ruby setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
augroup END

" RSpec syntax highlighting is sometimes lacking
autocmd BufRead *_spec.rb syn keyword rubyRspec describe context it specify it_should_behave_like before after setup subject its shared_examples_for shared_context let
highlight def link rubyRspec Function

" remove whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" autoread files that have changed outside of vim
set autoread


"*****************************************************************************
" Bundle Config
"*****************************************************************************

" Vim Polyglot
let g:polyglot_disabled = ['css']

" Ctrl-P
" set-up ctrlp to include hidden files in its search
let g:ctrlp_show_hidden=1
" disable ctrlp's feature where it tries to intelligently work out the current working directory to search within
let g:ctrlp_working_path_mode=0
" don't let ctrlp take over the screen!
let g:ctrlp_max_height=30

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden --ignore .git -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
else
  let g:ctrlp_user_command = "find %s -type f | grep -Ev '"+ g:ctrlp_custom_ignore +"'"
endif
" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

" snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"

" syntastic
let g:syntastic_always_populate_loc_list=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'
let g:syntastic_auto_loc_list=1
let g:syntastic_aggregate_errors = 1
let g:syntastic_ruby_mri_exec = "~/.rbenv/shims/ruby"
let g:syntastic_scss_checkers=[]
let g:syntastic_eruby_ruby_quiet_messages =
    \ {'regex': 'possibly useless use of - in void context'}

" Easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
nmap s <Plug>(easymotion-s)

"*****************************************************************************
" Mappings
"*****************************************************************************
" Split
noremap <Leader>- :<C-u>split<CR>
noremap <Leader><bar> :<C-u>vsplit<CR>

" Goyo distraction-free writing mode
noremap <Leader>G :Goyo<CR>

" Git
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>

" Ruby
nnoremap <leader>b obinding.pry<Esc>osleep 1<CR><Esc>

" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

" Opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Copy/Paste/Cut
set clipboard=unnamed,unnamedplus
noremap YY "+y<CR>
noremap P "+gP<CR>
noremap XX "+x<CR>

if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

" Buffer nav
noremap <leader>z :bp<CR>
noremap <leader>q :bp<CR>
noremap <leader>x :bn<CR>
noremap <leader>w :bn<CR>

" Close buffer
noremap <leader>c :bd<CR>

" Open items from quickfix in existing tab if it contains target buffer
set switchbuf+=usetab,newtab

" Clear search highlight
nnoremap <silent> <leader>l :noh<cr>

" nullify ctrl+space in insert mode (cuz it's annoying)
imap <Nul> <Space>

" remap escape to kj
" inoremap kj <Esc>`^

" insert newline below or above
nnoremap <leader>j o<Esc>
nnoremap <leader>k O<Esc>

" disable Ex mode shortcut
nnoremap Q <nop>

" command shortcut to sudo save
command SW w !sudo tee %

" Function to preview markdown in Atom
function! s:setupMarkup()
  nnoremap <leader>p :silent !open -a Atom.app '%:p'<cr>
endfunction
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

"copy filename
nmap <leader>cf :let @*=expand("%")<CR>

" Replace within Quickfix with Qdo
nnoremap <leader>r :Qdo %s/

