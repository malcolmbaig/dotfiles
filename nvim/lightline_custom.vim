" =============================================================================
" Filename: autoload/lightline/colorscheme/lightline_custom.vim
" Author: mobaig
" License: MIT License
" Last Change: 2016-01-11 11:11
" =============================================================================
"
" Basics:
let s:foreground = '#d0d0d0'
let s:background = '#2b303b'
let s:window = '#efefef'
let s:status = '#2b303b'
let s:error = '#5f0000'

" Tabline:
let s:tabline_bg = '#3c4a52'
let s:tabline_active_fg = '#eeeeee'
let s:tabline_active_bg = '#3c4a52'
let s:tabline_inactive_fg = '#a8a8a8'
let s:tabline_inactive_bg = '#3c4a52'

" Statusline:
let s:statusline_active_fg = '#d0d0d0'
let s:statusline_active_bg = '#2b303b'
let s:statusline_inactive_fg = '#3c4a52'
let s:statusline_inactive_bg = '#444444'

" Normal:
let s:normal_dark_bg = '#3e4a51'
let s:normal_light_bg = '#728793'
let s:normal_lightest_bg = '#7d909b'

" Visual:
let s:visual_fg = '#ffffff'
let s:visual_bg = '#ff6600'

" Insert:
let s:insert_fg= '#ffffff'
let s:insert_bg= '#0095de'

" Replace:
let s:replace_fg= '#ffffff'
let s:replace_bg= '#cc3300'

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left = [ [ s:normal_lightest_bg, s:normal_dark_bg], [ s:normal_lightest_bg, s:normal_dark_bg], [ s:normal_dark_bg, s:normal_light_bg] ]
let s:p.normal.right = [ [ s:normal_lightest_bg, s:normal_dark_bg], [ s:normal_lightest_bg, s:normal_dark_bg], [ s:normal_lightest_bg, s:normal_dark_bg] ]
let s:p.normal.middle = [ [ s:statusline_active_fg, s:normal_dark_bg]]

let s:p.inactive.right = [ [ s:foreground, s:background ], [ s:foreground, s:background ] ]
let s:p.inactive.left = [ [ s:foreground, s:background ], [ s:foreground, s:background ] ]
let s:p.inactive.middle = [ [ s:foreground, s:background ], ]

let s:p.insert.left = [ ['darkestcyan', 'white', 'bold'], ['white', 'darkblue'] ]
let s:p.insert.right = [ [ 'darkestcyan', 'mediumcyan' ], [ 'mediumcyan', 'darkblue' ], [ 'mediumcyan', 'darkestblue' ] ]
let s:p.insert.middle = [ [ 'mediumcyan', 'darkestblue' ] ]

let s:p.replace.left = [ [ s:replace_fg, s:replace_bg], [s:statusline_active_fg, s:status ], [ s:statusline_active_fg, s:statusline_active_bg ] ]
let s:p.replace.right= [ [s:statusline_active_fg, s:status], [s:statusline_active_fg, s:status ], [ s:statusline_active_fg, s:statusline_active_bg ] ]
let s:p.replace.middle= [ [ s:statusline_active_fg, s:status ], [s:statusline_active_fg, s:status ], [ s:statusline_active_fg, s:statusline_active_bg ] ]

let s:p.visual.left = [ [ s:visual_fg, s:visual_bg ], [s:statusline_active_fg, s:status ], [ s:statusline_active_fg, s:statusline_active_bg ] ]
let s:p.visual.right= [ [s:statusline_active_fg, s:status], [s:statusline_active_fg, s:status ], [ s:statusline_active_fg, s:statusline_active_bg ] ]
let s:p.visual.middle= [ [ s:statusline_active_fg, s:status ], [s:statusline_active_fg, s:status ], [ s:statusline_active_fg, s:statusline_active_bg ] ]

let s:p.tabline.left = [ [s:tabline_inactive_fg, s:tabline_inactive_bg ]]
let s:p.tabline.tabsel = [ [s:tabline_active_fg, s:tabline_active_bg ] ]
let s:p.tabline.middle = [ [s:tabline_bg, s:tabline_bg]]
let s:p.tabline.right = copy(s:p.normal.right)

let s:p.normal.error = [ [ s:background, s:error ] ]

let g:lightline#colorscheme#lightline_custom#palette = lightline#colorscheme#fill(s:p)
