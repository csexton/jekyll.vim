" autoload/jekyll.vim
" Author:   Christopher Sexton

" Install this file as autoload/jekyll.vim.  This file is sourced manually by
" plugin/jekyll.vim.  It is in autoload directory to allow for future usage of
" Vim 7's autoload feature.

" Exit quickly when:
" - this plugin was already loaded (or disabled)
" - when 'compatible' is set
if &cp || exists("g:autoloaded_jekyll")
  finish
endif
let g:autoloaded_jekyll= '1'

let s:cpo_save = &cpo
set cpo&vim

" Utility Functions {{{1
function! s:error(str)
  echohl ErrorMsg
  echomsg a:str
  echohl None
  let v:errmsg = a:str
endfunction
" }}}1
" Commands {{{1
function JekyllPublish()
  call s:error("Not implemented")
  "if (!exists("g:loaded_fugitive") || !g:loaded_fugitive)
  "    call s:error("Fugitive.vim is required for this, you can get it at github.com/tpope/vim-fugitive/")
  "endif
endfunction
command! -buffer -nargs=? JekyllPublish :call JekyllPublish()

let &cpo = s:cpo_save

" vim:set ft=vim ts=2 sw=2 sts=2:
