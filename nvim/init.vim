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
" Plugins
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

" Match HTML tags
NeoBundle "Valloric/MatchTagAlways"

" Distraction-free writing mode
NeoBundle 'junegunn/goyo.vim'

" Qdo command for search/replace in quickfix list
NeoBundle 'henrik/vim-qargs'

" Syntax highlighting
NeoBundle 'sheerun/vim-polyglot'

" Completion / Snippets
NeoBundle 'Shougo/deoplete.nvim'
NeoBundle 'Shougo/context_filetype.vim'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'honza/vim-snippets'

" --- Additional Language / Syntax Support
" Ruby
NeoBundle 'tpope/vim-rails'
NeoBundle 'thoughtbot/vim-rspec'
NeoBundle 'tonekk/vim-ruby-capybara'
NeoBundle 'keith/rspec.vim'

" HTML
NeoBundle 'amirh/HTML-AutoCloseTag'
NeoBundle 'JulesWang/css.vim'

" Javascript
NeoBundle 'pangloss/vim-javascript'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


"*****************************************************************************
" Plugin Config
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

" Ctrl-P - The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden --ignore .git -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

" Completion / Snippets
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let	g:deoplete#enable_smart_case = 1
" always use completions from all buffers
if !exists('g:deoplete#same_filetypes')
	let g:deoplete#same_filetypes = {}
endif
let g:deoplete#same_filetypes._ = '_'
" <CR>: cancel popup and insert newline.
inoremap <silent> <CR> <C-r>=deoplete#mappings#smart_close_popup()<CR><CR>
" <TAB>: completion.
inoremap <expr> <Tab> pumvisible() ? "\<C-y>" : "\<Tab>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr> <C-h> deoplete#mappings#smart_close_popup()."\<C-h>"
" omnifuncs
augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
nmap s <Plug>(easymotion-s)


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

let no_buffers_menu=1

set mousemodel=popup

" highlight tailing whitespace
set list listchars=tab:\ \ ,trail:·

if $COLORTERM == 'gnome-terminal'
	set term=gnome-256color
else
	if $TERM == 'xterm'
		set term=xterm-256color
	endif
endif

" Minimum number of lines above and below cursor
set scrolloff=5

" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

"*****************************************************************************
" Status Bar
"*****************************************************************************"
" Don't display the current mode (Insert, Visual, Replace)
" in the status line. This info is already shown in the Lightline status bar.
set noshowmode

set laststatus=2
let g:lightline = {
  \ 'colorscheme': 'lightline_custom',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ], [ 'filename' ], ['ctrlpmark'] ],
  \   'right': [ [ 'lineinfo' ], ['percent'], [ 'filetype' ] ]
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
  \ },
  \ 'component_type': {
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
"*****************************************************************************
" Status Bar (END)
"*****************************************************************************"


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
" Color schemes
"*****************************************************************************
function! DarkColors()
  colorscheme base16-ocean-custom
  set background=dark
	call lightline#init()
	call lightline#colorscheme()
	call lightline#update()
endfunction

function! LightColors()
  colorscheme pencil
  set background=light
endfunction

call DarkColors()


"*****************************************************************************
" Autocmd Rules
"*****************************************************************************
" Function to preview markdown in Atom
function! s:setupMarkdownPreview()
  nnoremap <leader>p :silent !open -a Atom.app '%:p'<cr>
endfunction

" Markdown
augroup vimrc-markdown-settings
  autocmd!
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} setlocal fo+=t tw=79 spell spelllang=en_gb
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkdownPreview()
augroup END

" Stop treating periods as keywords
autocmd FileType * set iskeyword-=.

" Do syntax highlight syncing from start
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync fromstart
augroup END

" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" Pleco flashcard import file
autocmd BufRead *.pleco.txt setlocal nowrap noexpandtab fo-=t tw=0

" ruby
augroup vimrc-ruby
  autocmd!
  autocmd BufNewFile,BufRead *.rb,*.rbw,*.gemspec setlocal filetype=ruby
  autocmd FileType ruby setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" eruby
augroup vimrc-eruby
  autocmd!
  autocmd FileType eruby setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" javascript
augroup vimrc-javascript
  autocmd!
  autocmd BufNewFile,BufRead *.js setlocal filetype=javascript
  autocmd Filetype javascript setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" remove whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" autoread files that have changed outside of vim
set autoread


"*****************************************************************************
" Leader Key Mappings
"*****************************************************************************
" Color schemes
noremap <Leader>cd :call DarkColors()<CR>
noremap <Leader>cl :call LightColors()<CR>

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

" Close buffer
noremap <leader>c :bd<CR>

" Open items from quickfix in existing tab if it contains target buffer
set switchbuf+=usetab,newtab

" Clear search highlight
nnoremap <silent> <leader>l :noh<cr>

" nullify ctrl+space in insert mode (cuz it's annoying)
imap <Nul> <Space>

" insert newline below or above
nnoremap <leader>j o<Esc>
nnoremap <leader>k O<Esc>

" disable Ex mode shortcut
nnoremap Q <nop>

" command shortcut to sudo save
command SW w !sudo tee %

"copy filename
nmap <leader>cf :let @*=expand("%")<CR>

" Replace within Quickfix with Qdo
nnoremap <leader>r :Qdo %s/

" MatchTagAlways jump shortcut
nnoremap <leader>% :MtaJumpToOtherTag<cr>

