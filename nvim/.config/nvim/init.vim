"*****************************************************************************
" Vim-Plug core
"*****************************************************************************

let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
let g:plugin_path = '~/.config/nvim/plugged'

"*****************************************************************************
" Plugins
"*****************************************************************************

call plug#begin(g:plugin_path)

function! Cond(cond, ...)
	let opts = get(a:000, 0, {})
	return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

function! TerminalNeovim()
	return !exists('g:vscode')
endfunction

if TerminalNeovim()
	Plug 'mbbill/undotree', {'on': 'UndotreeToggle'} " GUI for the undo tree
	Plug 'mhinz/vim-startify' " Better start screen
	Plug 'sheerun/vim-polyglot' " Syntax highlighting
	Plug 'tpope/vim-fugitive' " Git integration
	Plug 'tpope/vim-rhubarb' " Github integration
	Plug 'tpope/vim-surround' " Mappings to manipulate surrounding characters
	Plug 'w0rp/ale' " Linting
  Plug 'ap/vim-css-color' " CSS
  Plug 'folke/tokyonight.nvim', { 'branch': 'main' } " Color scheme
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzy search
  Plug 'junegunn/fzf.vim'
  Plug 'nvim-lualine/lualine.nvim' " Status line
  Plug 'shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' } " File navigation
  Plug 'tpope/vim-commentary' " Convenient mappings for commenting stuff out
endif

Plug 'airblade/vim-localorie' " Expand keys in yaml files
Plug 'airblade/vim-matchquote' " Match quotes
Plug 'alvan/vim-closetag' " Close HTML tags
Plug 'dkarter/bullets.vim' " Better bullet points
Plug 'phaazon/hop.nvim' " Easy movement around text
Plug 'tpope/vim-endwise' " Automatically insert ends
Plug 'tpope/vim-rails' " Rails functionality
Plug 'tpope/vim-repeat' " Expand 'repeat last command' functionality
Plug 'tpope/vim-unimpaired' " Complementary paired commands using ] and [
Plug 'valloric/MatchTagAlways' " Match HTML tags

call plug#end()

" Shortcut for checking if a plugin is loaded
function! s:has_plugin(plugin)
  let lookup = 'g:plugs["' . a:plugin . '"]'
  return exists(lookup)
endfunction

"*****************************************************************************
" Basic Setup
"*****************************************************************************

if s:has_plugin('tokyonight.nvim')
  lua require 'tokyonight-custom'
  colorscheme tokyonight
endif

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" Open items from quickfix in existing tab if it contains target buffer
set switchbuf+=usetab,newtab

" Open vsplits on the right
set splitright

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
set clipboard+=unnamed,unnamedplus

" Tabs and spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Syntax highlighting
" syntax sync fromstart
noremap <leader>ss <Esc>:syntax sync fromstart<CR>

" " Disable netrw
let g:loaded_netrwPlugin = 1

"*****************************************************************************
" Plugin Config
"*****************************************************************************

if executable('rg')
  " Use rg over grep
  set grepprg=rg\ --vimgrep

  " Bind K to grep word under cursor
  nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

  " Bind \ (backward slash) to grep shortcut
  command -nargs=+ -complete=file -bar RgG silent! grep! <args>|cwindow|redraw!
  nnoremap \ :RgG<SPACE>
endif

if s:has_plugin('ale')
  let g:ale_sign_column_always = 1
  let g:ale_lint_on_text_changed = 'always'
  nmap <silent> <C-k> <Plug>(ale_previous_wrap)
  nmap <silent> <C-j> <Plug>(ale_next_wrap)
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

if s:has_plugin('defx.nvim')
	autocmd FileType defx call s:defx_my_settings()
	function! s:defx_my_settings() abort
	  " Define mappings
	  nnoremap <silent><buffer><expr> <CR>
	  \ defx#do_action('open', 'tabnew')
	  nnoremap <silent><buffer><expr> c
	  \ defx#do_action('copy')
	  nnoremap <silent><buffer><expr> m
	  \ defx#do_action('move')
	  nnoremap <silent><buffer><expr> p
	  \ defx#do_action('paste')
	  nnoremap <silent><buffer><expr> l
	  \ defx#do_action('open')
	  nnoremap <silent><buffer><expr> P
	  \ defx#do_action('preview')
	  nnoremap <silent><buffer><expr> o
	  \ defx#do_action('open_tree', 'toggle')
	  nnoremap <silent><buffer><expr> K
	  \ defx#do_action('new_directory')
	  nnoremap <silent><buffer><expr> N
	  \ defx#do_action('new_file')
	  nnoremap <silent><buffer><expr> M
	  \ defx#do_action('new_multiple_files')
	  nnoremap <silent><buffer><expr> C
	  \ defx#do_action('toggle_columns', 'mark:indent:icon:filename:type:size:time')
	  nnoremap <silent><buffer><expr> S
	  \ defx#do_action('toggle_sort', 'time')
	  nnoremap <silent><buffer><expr> d
	  \ defx#do_action('remove')
	  nnoremap <silent><buffer><expr> r
	  \ defx#do_action('rename')
	  nnoremap <silent><buffer><expr> !
	  \ defx#do_action('execute_command')
	  nnoremap <silent><buffer><expr> x
	  \ defx#do_action('execute_system')
	  nnoremap <silent><buffer><expr> yy
	  \ defx#do_action('yank_path')
	  nnoremap <silent><buffer><expr> .
	  \ defx#do_action('toggle_ignored_files')
	  nnoremap <silent><buffer><expr> ;
	  \ defx#do_action('repeat')
	  nnoremap <silent><buffer><expr> h
	  \ defx#do_action('cd', ['..'])
	  nnoremap <silent><buffer><expr> ~
	  \ defx#do_action('cd')
	  nnoremap <silent><buffer><expr> q
	  \ defx#do_action('quit')
	  nnoremap <silent><buffer><expr> ,
	  \ defx#do_action('toggle_select') . 'j'
	  nnoremap <silent><buffer><expr> *
	  \ defx#do_action('toggle_select_all')
	  nnoremap <silent><buffer><expr> j
	  \ line('.') == line('$') ? 'gg' : 'j'
	  nnoremap <silent><buffer><expr> k
	  \ line('.') == 1 ? 'G' : 'k'
	  nnoremap <silent><buffer><expr> <C-r>
	  \ defx#do_action('redraw')
	  nnoremap <silent><buffer><expr> <C-g>
	  \ defx#do_action('print')
	  nnoremap <silent><buffer><expr> cd
	  \ defx#do_action('change_vim_cwd')
	endfunction

  nnoremap - :Defx -show-ignored-files -search-recursive=`expand('%:p')` `getcwd()` -buffer-name=`'defx' . tabpagenr()`<CR>
  nnoremap _ :Defx -show-ignored-files <CR>

	call defx#custom#column('icon', {
	      \ 'directory_icon': '▸',
	      \ 'opened_icon': '▾',
	      \ 'root_icon': ' ',
	      \ })
	call defx#custom#column('filename', {
	      \ 'min_width': 80,
	      \ 'max_width': 80,
	      \ })
endif

if s:has_plugin('fzf.vim')
  autocmd! FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
  nnoremap <c-p> :Files<cr>
endif

if s:has_plugin('hop.nvim')
  lua require 'hop-custom'
  nmap s :HopChar1<CR>
endif

if s:has_plugin('lualine.nvim')
  lua require 'lualine-custom'
endif

if s:has_plugin('vim-closetag')
  let g:closetag_filenames = "*.html,*.js,*.jsx"
  let g:closetag_close_shortcut = ''
endif

if s:has_plugin('vim-gutentags')
  let g:gutentags_ctags_tagfile = '.vim_tags'
  let g:gutentags_cache_dir = '~/tmp/'
  let g:gutentags_ctags_exclude = [
        \ 'node_modules',
        \ 'dist',
        \ 'vendor',
        \ 'bower_components']
endif

if s:has_plugin('vim-polyglot')
  let g:jsx_ext_required = 0
endif

if s:has_plugin('vim-startify')
  let g:startify_custom_header =
        \ 'startify#center(startify#fortune#boxed())'

  let g:startify_change_to_dir = 0
  let g:startify_fortune_use_unicode = 1
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

" Cursor setup
" set guicursor+=n:hor10-blinkon0 " Horizontal cursor in normal mode
" set cursorcolumn " Display highlighted column at cursor
set cursorline " Display highlight line at cursor
au VimLeave * set guicursor=a:block-blinkon1 " Switch to block cursor when leaving vim

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
" Color scheme functions
"*****************************************************************************

function! ColorsDark()
  colorscheme tokyonight
endfunction

function! ColorsLight()
  colorscheme tokyonight-day
endfunction

"*****************************************************************************
" Autocmd Rules
"*****************************************************************************

augroup vimrc-whitespace
  autocmd!
  " Remove whitespace on save
  autocmd BufWritePre * :%s/\s\+$//e
augroup END

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
  let g:ruby_indent_hanging_elements = 0
augroup END


"*****************************************************************************
" Custom Key Mappings
"*****************************************************************************

" Tab navigation
nnoremap <C-l> gt
nnoremap <C-h> gT

" Terminal normal mode
tnoremap <Esc> <C-\><C-n>

" -----------------------------
" Leader Key - single character
" -----------------------------

" Splits
noremap <leader>- :<C-u>split<CR>
noremap <leader><bar> :<C-u>vsplit<CR>

" Set working directory
noremap <leader>. :lcd %:p:h<CR>

" Opens an edit command with the path of the currently edited file filled in
noremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Clear search highlight
noremap <silent> <leader>l :noh<cr>

" Open new tab
noremap <silent> <leader>t :tabnew<CR>

" Close all other tabs
noremap <leader>o :tabonly<cr>

" Replace within Quickfix with cdo
noremap <leader>r :cdo s/

" Insert newline below or above
noremap <leader>j o<Esc>
noremap <leader>k O<Esc>

" ale - run fixer
if s:has_plugin('ale')
	nmap <silent> <leader>f <Plug>(ale_fix)
endif

" goyo - switch to distraction-free writing mode
noremap <leader>G :Goyo 100<CR>

" lualine - rename tab
nmap <silent> <leader>llr :LualineRenameTab<Space>

" MatchTagAlways jump shortcut
noremap <leader>% :MtaJumpToOtherTag<cr>

" -------------------------------
" Leader Key - multiple character
" -------------------------------

" Copy name of current file
noremap <leader>yf :let @+=expand("%")<CR>

" Line number toggles
noremap <leader>ln :set nu!<CR>
noremap <leader>lr :set relativenumber!<CR>

" Ruby - add a binding.pry at the cursor
noremap <leader>rb obinding.pry<CR><Esc>
" Ruby - Capybara - add a save_and_open_page at the cursor
noremap <leader>rso osave_and_open_page<CR><Esc>

" Expand yml key under cursor and add it to clipboard
if s:has_plugin('localorie')
	nnoremap <silent> <leader>rye :let @+=localorie#expand_key()<CR>
endif

" Quickfix
noremap <leader>qf :copen<CR>

" fugitive
if s:has_plugin('fugitive')
	noremap <leader>gl :Git log<CR>
	noremap <leader>gb :Git blame<CR>
	noremap <leader>gc :Git commit<CR>
	noremap <leader>gs :Git<CR>
	noremap <leader>go :GBrowse<CR>
endif

" fzf
if s:has_plugin('fzf')
	nnoremap <leader>zb :Buffers<cr>
	nnoremap <leader>zl :BLines<cr>
	nnoremap <leader>zh :History:<cr>
	nnoremap <leader>zc :Commits<cr>
endif

" -----------------
" Disabled mappings
" -----------------

" Disable Ex mode shortcut
nnoremap Q <nop>
