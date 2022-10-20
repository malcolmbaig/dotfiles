"*****************************************************************************
" Vim-Plug core
"*****************************************************************************

let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
let g:plugin_path = '~/.config/nvim/plugged'
call plug#begin(g:plugin_path)

"*****************************************************************************
" Plugins
"*****************************************************************************

Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' } " File navigation
Plug 'junegunn/fzf.vim' " Fuzzy search
Plug 'tpope/vim-commentary' " Convenient mappings for commenting stuff out
Plug 'tpope/vim-endwise' " Automatically insert ends
Plug 'tpope/vim-fugitive' " Git integration
Plug 'tpope/vim-repeat' " Expand 'repeat last command' functionality
Plug 'tpope/vim-rhubarb' " Github integration
Plug 'tpope/vim-surround' " Mappings to manipulate surrounding characters
Plug 'tpope/vim-unimpaired' " Complementary paired commands using ] and [

Plug 'Lokaltog/vim-easymotion' " Easy movement around text
Plug 'Valloric/MatchTagAlways' " Match HTML tags
Plug 'airblade/vim-localorie' " Expand keys in yaml files
Plug 'airblade/vim-matchquote' " Match quotes
Plug 'dkarter/bullets.vim' " Better bullet points
Plug 'henrik/vim-qargs' " Qdo command for search/replace in quickfix list
Plug 'junegunn/goyo.vim', {'on': 'Goyo'} " Distraction-free writing mode
Plug 'ludovicchabant/vim-gutentags' " Generate ctags automatically
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'} " GUI for the undo tree
Plug 'mhinz/vim-startify' " Better start screen
Plug 'sheerun/vim-polyglot' " Syntax highlighting
Plug 'w0rp/ale' " Linting

" Completion / Snippets
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'

" Color schemes
Plug 'drewtempelmeyer/palenight.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'junegunn/seoul256.vim'
Plug 'vim-airline/vim-airline-themes'

"----------------------------
" Additional Language Support
"----------------------------

" CSS
Plug 'ap/vim-css-color'

" HTML
Plug 'alvan/vim-closetag'

" Ruby
Plug 'keith/rspec.vim'
Plug 'tpope/vim-rails'
Plug 'thoughtbot/vim-rspec'

call plug#end()

" Shortcut for checking if a plugin is loaded
function! s:has_plugin(plugin)
  let lookup = 'g:plugs["' . a:plugin . '"]'
  return exists(lookup)
endfunction

"*****************************************************************************
" Basic Setup
"*****************************************************************************

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
if (executable('pbcopy') || executable('xclip') || executable('xsel')) && has('clipboard')
  set clipboard+=unnamed,unnamedplus
endif

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
  nmap <silent> <C-k> <Plug>(ale_previous_wrap)
  nmap <silent> <C-j> <Plug>(ale_next_wrap)
  nmap <silent> <leader>f <Plug>(ale_fix)
  let g:ale_ruby_rubocop_executable = 'bundle'
  let g:ale_linters = { 'ruby': ['rubocop'] }
  let g:ale_fixers = { 'ruby': ['rubocop'] }

  let g:ale_pattern_options = {'code\/find': {'ale_linters': ['rubocop'] } }
endif

if s:has_plugin('bullets.vim')
  let g:bullets_enabled_file_types = [
      \ 'markdown',
      \ 'text',
      \ 'gitcommit',
      \]
endif

if s:has_plugin('coc.nvim')
  " Use <Tab> and <S-Tab> for navigate completion list
  inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

  nmap <silent> <Leader>ld <Plug>(coc-definition)
  let g:coc_global_extensions = ['coc-solargraph']

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
  let g:fzf_height = '40%'
  let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

  autocmd! FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

  nnoremap <c-p> :FZF<cr>
  nnoremap <leader>zb :Buffers<cr>
  nnoremap <leader>zl :BLines<cr>
  nnoremap <leader>zh :History:<cr>
  nnoremap <leader>zc :Commits<cr>

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

  function! CreateCenteredFloatingWindow()
    let width = min([&columns - 4, max([80, &columns - 20])])
    let height = min([&lines - 4, max([20, &lines - 10])])
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
  endfunction

  let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }
endif

if s:has_plugin('vim-closetag')
  let g:closetag_filenames = "*.html,*.js,*.jsx"
  let g:closetag_close_shortcut = ''
endif

if s:has_plugin('vim-easymotion')
  let g:EasyMotion_do_mapping = 0 " Disable default mappings
  nmap s <Plug>(easymotion-s)
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

if s:has_plugin('vim-rspec')
  let g:rspec_command = "vsplit | term bundle exec rspec {spec}"
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
set guicursor+=n:hor10-blinkon0 " Horizontal cursor in normal mode
set cursorcolumn " Display highlighted column at cursor
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
" Color schemes
"*****************************************************************************

function! ColorsDark()
  set background=dark
  colorscheme palenight
  highlight ColorColumn guibg=#34394e
  highlight CursorColumn guibg=#34394e
  highlight CursorLine guibg=#34394e
  highlight Search guibg=#5c7aae guifg=white gui=underline
  highlight IncSearch guibg=#5c7aae guifg=white gui=underline
  :AirlineTheme palenight
endfunction

function! ColorsLight()
  set background=light
  colorscheme seoul256-light
  :AirlineTheme seoul256
endfunction

augroup vimrc-default-colorscheme
  autocmd!
  au VimEnter * call ColorsDark()
augroup END


"*****************************************************************************
" Autocmd Rules
"*****************************************************************************

augroup vimrc-whitespace
  autocmd!
  " Remove whitespace on save
  autocmd BufWritePre * :%s/\s\+$//e
augroup END

" Function to preview markdown in an app
function! s:setupMarkdownPreview()
  nnoremap <leader>mp :silent !marktext '%:p'<cr>
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

" MatchTagAlways jump shortcut
noremap <leader>% :MtaJumpToOtherTag<cr>

" Opens an edit command with the path of the currently edited file filled in
noremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Clear search highlight
noremap <silent> <leader>l :noh<cr>

" Open new tab
noremap <silent> <leader>t :tabnew<CR>

" Close all other tabs
noremap <leader>o :tabonly<cr>

" Replace within Quickfix with Qdo
noremap <leader>r :Qdo %s/

" Switch to a distraction-free writing mode
noremap <leader>G :Goyo 100<CR>

" Insert newline below or above
noremap <leader>j o<Esc>
noremap <leader>k O<Esc>

" -------------------------------
" Leader Key - multiple character
" -------------------------------

" Copy name of current file
noremap <leader>yf :let @+=expand("%")<CR>

" Color schemes
noremap <leader>cd :call ColorsDark()<CR>
noremap <leader>cl :call ColorsLight()<CR>

" Git
noremap <leader>gl :Git log<CR>
noremap <leader>gb :Git blame<CR>
noremap <leader>gc :Git commit<CR>
noremap <leader>gs :Git<CR>
noremap <leader>go :GBrowse<CR>

" Line number toggles
noremap <leader>ln :set nu!<CR>
noremap <leader>lr :set relativenumber!<CR>

" Ruby - add a binding.pry at the cursor
noremap <leader>rb orequire 'pry-byebug';binding.pry;sleep 1<CR><Esc>
" Ruby - Capybara - add a save_and_open_page at the cursor
noremap <leader>rso osave_and_open_page<CR><Esc>
" Expand yml key under cursor and add it to clipboard
nnoremap <silent> <leader>rye :let @+=localorie#expand_key()<CR>

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

" Disable Ex mode shortcut
nnoremap Q <nop>

