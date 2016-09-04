"*****************************************************************************
"" Vim-PLug core
"*****************************************************************************
if has('vim_starting')
  set nocompatible               " Be iMproved
endif

let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

let g:vim_bootstrap_langs = ""
let g:vim_bootstrap_editor = "nvim"				" nvim or vim

if !filereadable(vimplug_exists)
  echo "Installing Vim-Plug..."
  echo ""
  silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let g:not_finish_vimplug = "yes"

  " Run shell script if exist on custom select language

  autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.config/nvim/plugged'))

"*****************************************************************************
" Plugins
"*****************************************************************************
" Core
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-endwise'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'
Plug 'Lokaltog/vim-easymotion'

" Color schemes
Plug 'reedes/vim-colors-pencil'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'rakr/vim-two-firewatch' | Plug 'mobaig/vim-two-firewatch-airline'

" Generates ctags automatically
Plug 'ludovicchabant/vim-gutentags'

" GUI for the undo tree
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}

" Switch the cwd based on the file location
Plug 'airblade/vim-rooter'

" Rearrange text into tables
Plug 'godlygeek/tabular'

" Match HTML tags
Plug 'Valloric/MatchTagAlways'

" Distraction-free writing mode
Plug 'junegunn/goyo.vim'

" Qdo command for search/replace in quickfix list
Plug 'henrik/vim-qargs'

" Syntax highlighting
Plug 'sheerun/vim-polyglot'

" Completion / Snippets
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" --- Additional Language / Syntax Support
" Ruby
Plug 'tpope/vim-rails'
Plug 'tonekk/vim-ruby-capybara'
Plug 'keith/rspec.vim'

" HTML
Plug 'alvan/vim-closetag'
Plug 'cakebaker/scss-syntax.vim'

" Javascript
Plug 'pangloss/vim-javascript'

" CSS
Plug 'ap/vim-css-color'

" JSON
Plug 'tpope/vim-jdaddy'
"
"" Custom bundles
"" Include user's extra bundle
if filereadable(expand("~/.config/nvim/local_bundles.vim"))
  source ~/.config/nvim/local_bundles.vim
endif

call plug#end()
"
" Shortcut for checking if a plugin is loaded
function! s:has_plugin(plugin)
  let lookup = 'g:plugs["' . a:plugin . '"]'
  return exists(lookup)
endfunction

" Required:
filetype plugin indent on


"*****************************************************************************
" Plugin Config
"*****************************************************************************

if s:has_plugin('vim-gutentags')
  let g:gutentags_tagfile = '.vim_tags'
  let g:gutentags_exclude = [
        \ 'node_modules',
        \ 'dist',
        \ 'vendor',
        \ 'bower_components']
endif

if s:has_plugin('vim-airline')
  let g:airline#extensions#branch#enabled = 1
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers
  let g:airline#extensions#tabline#fnamemod = ':t' " Show the filename
  let g:airline#extensions#tabline#fnamecollapse = 0
  let g:airline#extensions#tabline#tab_nr_type = 1 " Show tab number
  let g:airline#extensions#tabline#buffer_nr_show = 0
  let g:airline_section_warning = ''
  let g:airline_section_error = ''
endif

if s:has_plugin('vimfiler.vim')
  let g:vimfiler_as_default_explorer = 1

  call vimfiler#custom#profile('default', 'context', {
       \ 'safe' : 0,
       \ 'edit_action' : 'tabopen',
       \ })
  let g:loaded_netrwPlugin = 1
  nnoremap - :VimFiler -find<CR>

  " VimFiler autocmd
  augroup vimfiler-custom
    autocmd!
    " prefer tab navigation to opening 2nd vimfiler
    autocmd FileType vimfiler nunmap <buffer> <Tab>
    autocmd FileType vimfiler nnoremap <Tab> gt
    autocmd FileType vimfiler nnoremap <S-Tab> gT
    " prefer keeping my leader key
    autocmd FileType vimfiler nunmap <buffer> <Space>
    autocmd FileType vimfiler nmap <buffer> , <Plug>(vimfiler_toggle_mark_current_line)

    " prefer Ag's '\' search to viewing root
    autocmd FileType vimfiler nunmap <buffer> \

    " switch off relativenumber, too damn slow
    autocmd FileType vimfiler setlocal norelativenumber
  augroup end
endif

if s:has_plugin('vim-polyglot')
  let g:polyglot_disabled = ['css']
endif

if s:has_plugin('ctrlp.vim')
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
endif

if s:has_plugin('deoplete.nvim')
  " Completion / Snippets
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#enable_ignore_case = 1
  let g:deoplete#enable_smart_case = 1
  " always use completions from all buffers
  if !exists('g:deoplete#same_filetypes')
    let g:deoplete#same_filetypes = {}
  endif
  let g:deoplete#same_filetypes._ = '_'
  " <TAB>: completion.
  inoremap <expr> <Tab> pumvisible() ? "\<C-y>" : "\<Tab>"
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<tab>"
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif

if s:has_plugin('vim-easymotion')
  " Easymotion
  let g:EasyMotion_do_mapping = 0 " Disable default mappings
  nmap s <Plug>(easymotion-s)
end


"*****************************************************************************
" Basic Setup
"*****************************************************************************"
" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" Fix backspace indent
set backspace=indent,eol,start

" Disable wrapping
set wrap!

" Map leader to ,
let mapleader="\<Space>"

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
set iskeyword-=.

" Performance tweaks
" set lazyredraw
set ttyfast


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
  set background=dark " or light if you prefer the light version
  let g:two_firewatch_italics=1
  colo two-firewatch
  let g:airline_theme='twofirewatchcustom'

  " set background=dark
  " colorscheme deep-space
  " let g:deepspace_italics = 1
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
  nnoremap <leader>p :silent !open -a Marked\ 2.app '%:p'<cr>
endfunction

augroup vimrc-defaults
  autocmd!
  " Do syntax highlight syncing from start
  autocmd BufEnter * :syntax sync fromstart
  " Default tab settings in everything, overriding anything set by ftplugin
  au BufRead,BufNewFile * setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
augroup END

" Markdown
augroup vimrc-markdown-settings
  autocmd!
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} setlocal fo+=t tw=79 spell spelllang=en_gb
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkdownPreview()
augroup END

" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" Pleco flashcard import file
autocmd BufRead,BufEnter *.pleco.txt setlocal nowrap noexpandtab fo-=t tw=0

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
noremap <Leader>go :Gbrowse<CR>

" Ruby
nnoremap <leader>b orequire 'pry-byebug';binding.pry;sleep 1<CR><Esc>

" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <Leader>t :tabnew<CR>

" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

" Opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

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

" tabs
nnoremap <leader>o :tabonly<cr>

