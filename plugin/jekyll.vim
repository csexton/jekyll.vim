" jekyll.vim - Jekyll
" Maintainer:   Christopher Sexton
"
" See doc/jekyll.txt for instructions and usage.

" Code {{{1
" Exit quickly when:
" - this plugin was already loaded (or disabled)
" - when 'compatible' is set
if (exists("g:loaded_jekyll") && g:loaded_jekyll) || &cp
  finish
endif
let g:loaded_jekyll = 1

let s:cpo_save = &cpo
set cpo&vim

if !exists('g:jekyll_path')
  let g:jekyll_path = $HOME . "/src/blog"
endif

if !exists('g:jekyll_post_suffix')
  let g:jekyll_post_suffix = "markdown"
endif

function s:esctitle(str)
  let str = a:str
  let str = tolower(str)
  let str = substitute(str, ' ', '-', 'g')
  let str = substitute(str, '"', '-', 'g')
  let str = substitute(str, "'", '-', 'g')
  return str
endfunction

function! s:error(str)
  echohl ErrorMsg
  echomsg a:str
  echohl None
  let v:errmsg = a:str
endfunction

function! s:escvar(r)
  let r = fnamemodify(a:r,':~')
  let r = substitute(r,'\W','\="_".char2nr(submatch(0))."_"','g')
  let r = substitute(r,'^\d','_&','')
  return r
endfunction

function! s:Detect(filename)
  let fn = substitute(fnamemodify(a:filename,":p"),'\c^file://','','')
  let sep = matchstr(fn,'^[^\\/]\{3,\}\zs[\\/]')
  if sep != ""
    let fn = getcwd().sep.fn
  endif
  let ofn = ""
  " Look through the parent folders to see if a _posts folder exists, if so
  " assume this is a jekyll project.
  while fn != ofn
    if isdirectory(fn . "/_posts")
      return s:BufInit(fn)
    endif
    let ofn = fn
    let fn = fnamemodify(fn,':h')
  endwhile
  return 0
endfunction

function! s:BufInit(path)
  let b:jekyll_root = a:path
  if !exists("g:autoloaded_jekyll") && v:version >= 700
    runtime! autoload/jekyll.vim
  endif
  " FIXME: This should be handled by the autocmd, but we don't set jekyll_root
  " until after that autocmd is run, so it won't match.
  syn match Comment /\%^---\_.\{-}---$/ contains=@Spell
endfunction

" Commands
function JekyllList()
  exe "e " . g:jekyll_path . "/_posts"
endfunction
command! -nargs=0 JekyllList :call JekyllList()

function JekyllPost(title)
  let title = a:title
  if title == ''
    let title = input("Post title: ")
  endif
  if title != ''
    let file_name = strftime("%Y-%m-%d-") . s:esctitle(title) . "." . g:jekyll_post_suffix
    echo "Making that post " . file_name
    exe "e " . g:jekyll_path . "/_posts/" . file_name
    let err = append(0, ['---', 'layout: post', 'title: "' . title . '"', 'published: true', '---', ''])
  else
    call s:error("You must specify a title")
  endif
endfunction
command! -nargs=? JekyllPost :call JekyllPost(<q-args>)

" Initialization {{{1
augroup jekyllPluginDetect
  autocmd!
  autocmd BufNewFile,BufRead * call s:Detect(expand("<afile>:p"))
  autocmd VimEnter * if expand("<amatch>") == "" && !exists("b:jekyll_root") | call s:Detect(getcwd()) | endif
  autocmd Syntax html,xml,markdown,textile if exists("b:jekyll_root") | syn match Comment /\%^---\_.\{-}---$/ contains=@Spell | endif
augroup END

" }}}1

let &cpo = s:cpo_save

" vim:set ft=vim ts=2 sw=2 sts=2:
