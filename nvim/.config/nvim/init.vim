"*****************************************************************************
" Vim-Plug core
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
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'

" Easy movement around text
Plug 'Lokaltog/vim-easymotion'

" Better bullet points
Plug 'dkarter/bullets.vim'

" Fuzzy search
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Color schemes
Plug 'drewtempelmeyer/palenight.vim'
Plug 'nightsense/snow'
Plug 'vim-airline/vim-airline-themes'

" Generate ctags automatically
Plug 'ludovicchabant/vim-gutentags'

" GUI for the undo tree
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}

" Rearrange text into tables
Plug 'godlygeek/tabular', {'on': 'Tabularize'}

" Match HTML tags
Plug 'Valloric/MatchTagAlways'

" Distraction-free writing mode
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}

" Qdo command for search/replace in quickfix list
Plug 'henrik/vim-qargs'

" Syntax highlighting
Plug 'sheerun/vim-polyglot'

" Completion / Snippets
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'
Plug 'epilande/vim-es2015-snippets'
Plug 'epilande/vim-react-snippets'

" Linting
Plug 'w0rp/ale'

"----------------------------
" Additional Language Support
"----------------------------

" Ruby
Plug 'tpope/vim-rails'
Plug 'tonekk/vim-ruby-capybara'
Plug 'keith/rspec.vim'
Plug 'thoughtbot/vim-rspec'

" Javascript
Plug 'pangloss/vim-javascript', {'for': ['javascript', 'javascript.jsx']}

" HTML
Plug 'alvan/vim-closetag'
Plug 'mattn/emmet-vim'

" CSS
Plug 'ap/vim-css-color'
Plug 'cakebaker/scss-syntax.vim'

" JSON
Plug 'tpope/vim-jdaddy'

" Custom bundles
" Include user's extra bundle
if filereadable(expand("~/.config/nvim/local_bundles.vim"))
  source ~/.config/nvim/local_bundles.vim
endif

call plug#end()

" Shortcut for checking if a plugin is loaded
function! s:has_plugin(plugin)
  let lookup = 'g:plugs["' . a:plugin . '"]'
  return exists(lookup)
endfunction

" Required:
filetype plugin indent on

"*****************************************************************************
" Basic Setup
"*****************************************************************************

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" Open items from quickfix in existing tab if it contains target buffer
set switchbuf+=usetab,newtab

" Fix backspace indent
set backspace=indent,eol,start

" Disable wrapping
set wrap!

" Map leader to space
let mapleader="\<Space>"

" Enable hidden buffers
set hidden

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" See live previews of text substitutions
set inccommand=nosplit

" Directories for swp files
set nobackup
set noswapfile

" Show additional Visual mode info in last line
set showcmd

" Don't show current mode in status line
set noshowmode

" Configure EOL detection
set fileformats=unix,mac

" Personal spellfile location
set spellfile=~/.config/nvim/spell/en.utf-8.add

" Switch off modelines
set nomodeline

 " Copy/Paste/Cut
if (executable('pbcopy') || executable('xclip') || executable('xsel')) && has('clipboard')
  set clipboard+=unnamed,unnamedplus
endif

"*****************************************************************************
" Plugin Config
"*****************************************************************************

if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " bind K to grep word under cursor
  nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

  " bind \ (backward slash) to grep shortcut
  command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
  nnoremap \ :Ag<SPACE>
endif

if s:has_plugin('ale')
  let g:ale_sign_column_always = 1
  nmap <silent> <C-k> <Plug>(ale_previous_wrap)
  nmap <silent> <C-j> <Plug>(ale_next_wrap)
  nmap <silent> <leader>f <Plug>(ale_fix)
  let g:ale_ruby_rubocop_executable = 'bundle'
  let g:ale_linters = { 'ruby': ['rubocop'] }
  let g:ale_fixers = { 'ruby': ['rubocop'] }
endif

if s:has_plugin('bullets.vim')
  let g:bullets_enabled_file_types = [
      \ 'markdown',
      \ 'text',
      \ 'gitcommit',
      \]
endif

if s:has_plugin('coc.nvim')
  " Use <c-space> for trigger completion
  inoremap <silent><expr> <c-space> coc#refresh()

  " Use <Tab> and <S-Tab> for navigate completion list
  inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

  " Snippets
  " Requires coc-snippets extension - :CocInstall coc-snippets
  " Use <C-l> for trigger snippet expand.
  imap <C-l> <Plug>(coc-snippets-expand)
  " Use tab for jump to next placeholder, it's default of coc.nvim
  let g:coc_snippet_next = '<tab>'
  let g:coc_snippet_prev = '<S-Tab>'

  " Introduce function text object
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  xmap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap if <Plug>(coc-funcobj-i)
  omap af <Plug>(coc-funcobj-a)
endif

if s:has_plugin('emmet-vim')
  let g:user_emmet_install_global = 0
  autocmd FileType html,css,javascript EmmetInstall
endif

if s:has_plugin('fzf.vim')
  let g:fzf_height = '30%'
  let g:fzf_commits_log_options = '--color --graph --pretty=format:"%C(yellow)%h%Creset -%C(auto)%d%Creset %s %C(bold blue)(%cr) %Cred<%an>%Creset" --abbrev-commit'

  nnoremap <c-p> :FZF<cr>
  nnoremap <leader>bu :Buffers<cr>
  nnoremap <leader>bl :BLines<cr>
  nnoremap <leader>hi :History:<cr>
  nnoremap <leader>co :Commits<cr>

  let g:fzf_colors =
  \ { 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Boolean'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }

  function! s:fzf_statusline()
    highlight fzf1 ctermfg=23 ctermbg=251
    highlight fzf2 ctermfg=23 ctermbg=251
    highlight fzf3 ctermfg=23 ctermbg=251
    setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
  endfunction

  autocmd! User FzfStatusLine call <SID>fzf_statusline()
endif

if s:has_plugin('vim-airline')
  let g:airline#extensions#branch#enabled = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#formatter = 'unique_tail'
  let g:airline#extensions#tabline#show_buffers = 0
  let g:airline#extensions#tabline#show_close_button = 0
  let g:airline#extensions#tabline#show_splits = 0
  let g:airline#extensions#tabline#show_tab_nr = 0
  let g:airline#extensions#tabline#show_tab_type = 0
  let g:airline#extensions#tabline#show_tabs = 1
  let g:airline_powerline_fonts = 1
  let g:airline_section_error = ''
  let g:airline_section_warning = ''
  let g:airline_section_y = ''
endif

if s:has_plugin('vim-closetag')
  let g:closetag_filenames = "*.html,*.js,*.jsx"
  let g:closetag_close_shortcut = ''
endif

if s:has_plugin('vim-easymotion')
  let g:EasyMotion_do_mapping = 0 " Disable default mappings
  nmap s <Plug>(easymotion-s)
endif

if s:has_plugin('vimfiler.vim')
  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_ignore_pattern = ['^\.git$', '^\.DS_Store$']

  call vimfiler#custom#profile('default', 'context', {
       \ 'safe' : 0,
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

    autocmd FileType vimfiler nunmap <buffer> E
    autocmd FileType vimfiler nnoremap <silent><buffer><expr> E vimfiler#do_action('tabopen')

    " change shortcut for mark current line
    autocmd FileType vimfiler nunmap <buffer> <Space>
    autocmd FileType vimfiler nmap <buffer> , <Plug>(vimfiler_toggle_mark_current_line)

    " prefer Ag's '\' search to viewing root
    autocmd FileType vimfiler nunmap <buffer> \

    " switch off relativenumber, too damn slow
    autocmd FileType vimfiler setlocal norelativenumber
  augroup end
endif

if s:has_plugin('vim-gutentags')
  let g:gutentags_ctags_tagfile = '.vim_tags'
  let g:gutentags_ctags_exclude = [
        \ 'node_modules',
        \ 'dist',
        \ 'vendor',
        \ 'bower_components']
endif

if s:has_plugin('vim-polyglot')
  let g:polyglot_disabled = ['css']
  let g:jsx_ext_required = 0
endif

if s:has_plugin('vim-rspec')
  let g:rspec_command = "tabnew | term bundle exec rspec {spec}"
endif

"*****************************************************************************
" Visual Settings
"*****************************************************************************

" Indicate 80 char width with a color column
set colorcolumn=80
" Show trailing spaces and tabs
set list listchars=tab:\ \ ,trail:·
" Enable mousemode
set mouse=a
" Show line numbers
set number
" Make line numbers relative to cursor
set relativenumber
" Minimum number of lines above and below cursor
set scrolloff=5
" Specify max width for syntax highlighting
set synmaxcol=300
" Specify limits on number of previous lines inspected for highlight
" synchronization when doing a redraw
syntax sync maxlines=300
syntax sync minlines=200
" Disable cursor styling
set guicursor=

" Color setup
if has('termguicolors')
  set termguicolors
endif
if $COLORTERM == 'gnome-terminal'
  set term=gnome-256color
else
  if $TERM == 'xterm'
    set term=xterm-256color
  endif
endif

"*****************************************************************************
" Abbreviations
"*****************************************************************************

" Remap common Normal mode typos to something useful
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev Wqa wqa
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qa q
cnoreabbrev Qall qall

"*****************************************************************************
" Color schemes
"*****************************************************************************

function! ColorsDark()
  set background=dark
  colorscheme palenight
  highlight ColorColumn guibg=#34394e
  :AirlineTheme palenight
endfunction

function! ColorsLight()
  set background=light
  colorscheme snow
  :AirlineTheme snow_light
endfunction

augroup vimrc-default-colorscheme
  autocmd!
  au VimEnter * call ColorsDark()
augroup END


"*****************************************************************************
" Autocmd Rules
"*****************************************************************************

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
syntax sync fromstart

augroup vimrc-whitespace
  autocmd!
  " Remove whitespace on save
  autocmd BufWritePre * :%s/\s\+$//e
augroup END

" Function to preview markdown in an app
function! s:setupMarkdownPreview()
  nnoremap <leader>mp :silent !open -a iA\ Writer.app '%:p'<cr>
endfunction

" Markdown
augroup vimrc-markdown-settings
  autocmd!
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn}
        \ setlocal wrap linebreak nolist textwidth=0 wrapmargin=0 |
        \ setlocal fo+=t spell spelllang=en_gb |
        \ setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2 |
        \ call s:setupMarkdownPreview() |
        \ setlocal comments+=fb:-,fb:* |
        \ set colorcolumn=
augroup END

" Git commits
autocmd FileType gitcommit setlocal spell spelllang=en_gb

" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" Ruby
augroup vimrc-ruby
  autocmd!
  autocmd FileType ruby setlocal comments+=b:#
augroup END


"*****************************************************************************
" Custom Key Mappings
"*****************************************************************************

" Tab navigation
nnoremap <Tab> gt
nnoremap <S-Tab> gT

" -----------------------------
" Leader Key - single character
" -----------------------------

" Splits
noremap <leader>- :<C-u>split<CR>
noremap <leader><bar> :<C-u>vsplit<CR>

" Set working directory
noremap <leader>. :lcd %:p:h<CR>

" MatchTagAlways jump shortcut
noremap <leader>% :MtaJumpToOtherTag<cr>

" Close buffer
noremap <leader>c :bd<CR>

" Opens an edit command with the path of the currently edited file filled in
noremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Clear search highlight
noremap <silent> <leader>l :noh<cr>

" Insert newline below or above
noremap <leader>j o<Esc>
noremap <leader>k O<Esc>

" Open new tab
noremap <silent> <leader>t :tabnew<CR>

" Close all other tabs
noremap <leader>o :tabonly<cr>

" Replace within Quickfix with Qdo
noremap <leader>r :Qdo %s/

" Switch to a distraction-free writing mode
noremap <leader>G :Goyo 100<CR>

" -------------------------------
" Leader Key - multiple character
" -------------------------------

" Copy name of current file
noremap <leader>cf :let @*=expand("%")<CR>

" Color schemes
noremap <leader>cd :call ColorsDark()<CR>
noremap <leader>cl :call ColorsLight()<CR>

" Git
noremap <leader>ga :Gwrite<CR>
noremap <leader>gb :Gblame<CR>
noremap <leader>gc :Gcommit<CR>
noremap <leader>gd :Gvdiff<CR>
noremap <leader>gll :Gpull<CR>
noremap <leader>go :Gbrowse<CR>
noremap <leader>gr :Gremove<CR>
noremap <leader>gs :Gstatus<CR>
noremap <leader>gsh :Gpush<CR>

" Line number toggles
noremap <leader>ln :set nu!<CR>
noremap <leader>lr :set relativenumber!<CR>

" Ruby - add a binding.pry at the cursor
noremap <leader>rb orequire 'pry-byebug';binding.pry;sleep 1<CR><Esc>
" Ruby - Capybara - add a save_and_open_page at the cursor
noremap <leader>rso osave_and_open_page<CR><Esc>

" Invoke vim-rspec runner
noremap <leader>sa :call RunAllSpecs()<CR>
noremap <leader>sc :call RunCurrentSpecFile()<CR>
noremap <leader>sl :call RunLastSpec()<CR>
noremap <leader>sn :call RunNearestSpec()<CR>

" Quickfix
noremap <leader>qf :copen<CR>

" -----------------
" Disabled mappings
" -----------------

" Nullify ctrl+space in insert mode (used in macos)
imap <Nul> <Space>

" Disable Ex mode shortcut
nnoremap Q <nop>

