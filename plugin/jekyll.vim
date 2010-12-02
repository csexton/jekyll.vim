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

if !exists('g:jekyll_post_published')
  let g:jekyll_post_published = "true"
endif

if !exists('g:jekyll_post_created')
  let g:jekyll_post_created = ""
endif

if !exists('g:jekyll_title_pattern')
  let g:jekyll_title_pattern = "[ '\"]"
endif

if !exists('g:jekyll_prompt_tags')
  let g:jekyll_prompt_tags = ""
endif

if !exists('g:jekyll_prompt_categories')
  let g:jekyll_prompt_categories = ""
endif

function s:esctitle(str)
  let str = a:str
  let str = tolower(str)
  let str = substitute(str, g:jekyll_title_pattern, '-', 'g')
  let str = substitute(str, '\(--\)\+', '-', 'g')
  let str = substitute(str, '\(^-\|-$\)', '', 'g')
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
function JekyllBuild(args)
  exe "!jekyll " . a:args
endfunction
command! -nargs=* JekyllBuild :call JekyllBuild(<q-args>)

function JekyllList()
  exe "e " . g:jekyll_path . "/_posts"
endfunction
command! -nargs=0 JekyllList :call JekyllList()

function JekyllPost(title)
  let published = g:jekyll_post_published
  let created = g:jekyll_post_created
  let tags = g:jekyll_prompt_tags
  let categories = g:jekyll_prompt_categories

  if created == "epoch"
    let created = localtime() 
  elseif created != ""
    let created = strftime(created)
  endif
  let title = a:title
  if title == ''
    let title = input("Post title: ")
  endif
  if tags != ""
    let tags = input("Post tags: ")
  endif
  if categories != ""
    let categories = input("Post categories: ")
  endif
  if title != ''
    let file_name = strftime("%Y-%m-%d-") . s:esctitle(title) . "." . g:jekyll_post_suffix
    echo "Making that post " . file_name
    exe "e " . g:jekyll_path . "/_posts/" . file_name

    let template = ["---", "layout: post", "title: \"" . title . "\"", "published: " . published]
    if created != ""
      call add(template, "created:  "  . created)
    endif
    if tags != ""
      call add(template, "tags: [" . tags . "]")
    endif
    if categories != ""
      call add(template, "categories: [" . categories . "]")
    endif
    call extend(template,["---", ""])

    let err = append(0, template)
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
