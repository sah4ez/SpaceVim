"=============================================================================
" init.vim --- Language && encoding in SpaceVim
" Copyright (c) 2016-2017 Wang Shidong & Contributors
" Author: Wang Shidong < wsdjeg at 163.com >
" URL: https://spacevim.org
" License: GPLv3
"=============================================================================

let s:SYSTEM = SpaceVim#api#import('system')

"Use English for anything in vim
try
  if s:SYSTEM.isWindows
    silent exec 'lan mes en_US.UTF-8'
  elseif s:SYSTEM.isOSX
    silent exec 'language en_US'
  else
    let s:uname = system('uname -s')
    if s:uname ==# "Darwin\n"
      " in mac-terminal
      silent exec 'language en_US'
    elseif s:uname ==# "SunOS\n"
      " in Sun-OS terminal
      silent exec 'lan en_US.UTF-8'
    elseif s:uname ==# "FreeBSD\n"
      " in FreeBSD terminal
      silent exec 'lan en_US.UTF-8'
    else
      " in linux-terminal
      silent exec 'lan en_US.utf8'
    endif
  endif
catch /^Vim\%((\a\+)\)\=:E197/
  call SpaceVim#logger#error('Can not set language to en_US.utf8')
endtry

" try to set encoding to utf-8
if s:SYSTEM.isWindows
  " Be nice and check for multi_byte even if the config requires
  " multi_byte support most of the time
  if has('multi_byte')
    " Windows cmd.exe still uses cp850. If Windows ever moved to
    " Powershell as the primary terminal, this would be utf-8
    set termencoding=cp850
    " Let Vim use utf-8 internally, because many scripts require this
    set encoding=utf-8
    setglobal fileencoding=utf-8
    " Windows has traditionally used cp1252, so it's probably wise to
    " fallback into cp1252 instead of eg. iso-8859-15.
    " Newer Windows files might contain utf-8 or utf-16 LE so we might
    " want to try them first.
    set fileencodings=ucs-bom,utf-8,gbk,utf-16le,cp1252,iso-8859-15
  endif

else
  " set default encoding to utf-8
  set encoding=utf-8
  set termencoding=utf-8
  set fileencoding=utf-8
  set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
endif
scriptencoding utf-8

" my config
let g:spacevim_custom_plugins = [
  \ ['fatih/vim-go',               { 'on_ft' : 'go'}],
  \ ['keith/swift.vim',            { 'on_ft' : 'swift'}],
  \ ['leafgarland/typescript-vim', { 'on_ft' : 'typescript' }],
  \ ['pangloss/vim-javascript',    { 'on_ft' : 'js' }],
  \ ['moll/vim-node',              { 'on_ft' : 'js' }],
  \ ['scrooloose/vim-slumlord',    { 'on_ft' : 'plantuml' }],
  \ ['cespare/vim-toml',           { 'on_ft' : 'toml' }],
  \ ['ensime/ensime-vim',          { 'on_ft' : 'scala' }],
  \ ['derekwyatt/vim-scala',       { 'on_ft' : 'scala' }],
  \ ['aklt/plantuml-syntax'],
  \ ['airblade/vim-gitgutter'],
  \ ['terryma/vim-multiple-cursors'],
  \ ['ekalinin/dockerfile.vim'],
  \ ['junegunn/gv.vim'],
  \ ['tpope/vim-fugitive'],
  \ ['chr4/nginx.vim'],
  \ ]

let g:spacevim_filemanager = 'nerdtree'
"set autochdir
"autocmd BufEnter * silent! lcd %:p:h
set viminfo='100,n$HOME/.vim/files/info/viminfo
nnoremap <silent> <F9> :TagbarToggle<CR>
nnoremap <leader>a <F9> :TagbarToggle<CR>
nnoremap <space>lga :Gblame<CR>

autocmd FileType golang nested :GoGuruScope /home/sah4ez/go/src
"autocmd BufRead /home/sah4ez/go/src/*.go silent :TagbarOpen

autocmd VimEnter * nested :call tagbar#autoopen(1)
set updatetime=100
set colorcolumn=120
autocmd VimEnter * nested :set wrap
let g:spacevim_windows_smartclose = 'Q'

" golang
let g:go_guru_scope = ["..."]
let g:go_highlight_functions = 1
let g:go_fmt_command = "goimports"
let g:go_textobj_include_function_doc = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_auto_type_info = 1

let g:go_metalinter_enabled = ['golint', 'errcheck']
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['golint']
let g:go_metalinter_deadline = "5s"

let g:go_auto_sameids = 1

nnoremap <space>lbr :GoReferrers<CR>
nnoremap <space>lbf :GoFmt<CR>
nnoremap <space>ltf :GoTestFunc<CR>

" PLANTUML settings
if exists("g:loaded_plantuml_plugin")
    finish
endif
let g:loaded_plantuml_plugin = 1

if !exists("g:plantuml_executable_script")
        let g:plantuml_executable_script = 'java -jar /home/sah4ez/.opt/plantuml.1.2018.11.jar'
endif
let s:makecommand=g:plantuml_executable_script." %"

" define a sensible makeprg for plantuml files
autocmd BufWrite plantuml,uml let 'java -jar /home/sah4ez/.opt/plantuml.1.2018.11.jar %'

let g:spacevim_default_indent = 4
let g:spacevim_expand_tab =0
set expandtab

set spell spelllang=en_us

" scala
" autocmd BufWritePost *.scala silent :EnTypeCheck
" nnoremap <localleader>t :EnType<CR>
