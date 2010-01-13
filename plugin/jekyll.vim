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

function! s:ExecuteInTree(cmd) abort
  let cd = exists('*haslocaldir') && haslocaldir() ? 'lcd ' : 'cd '
  let dir = getcwd()
  try
    execute cd.' `=g:jekyll_path`'
    execute a:cmd
  finally
    execute cd.' `=dir`'
  endtry
endfunction

function JekyllList()
    exe "e " . g:jekyll_path . "/_posts"
endfunction
command! -nargs=? -range=% JekyllList :call JekyllList()

function JekyllPost()
    let title = input("Post title: ")
    if title != ''
        let file_name = strftime("%Y-%m-%d-") . substitute(tolower(title), ' ', '-', 'g') . ".markdown"
        echo "Making that post " . file_name
        exe "e " . g:jekyll_path . "/_posts/" . file_name
        let err = append(0, ['---', 'layout: post', 'title: ' . title, '---', ''])
    else
        echo "You must specify a title"
    endif
endfunction
command! -nargs=? -range=% JekyllPost :call JekyllPost()

function JekyllCommit()
    let message = input("Commit Message: ")
    call s:ExecuteInTree('!git add _posts/*.markdown && git commit -a -m "' . message . '"' )
endfunction
command! -nargs=? -range=% JekyllCommit :call JekyllCommit()

function JekyllPublish()
    call s:ExecuteInTree('!git push' )
endfunction
command! -nargs=? -range=% JekyllPublish :call JekyllPublish()

let &cpo = s:cpo_save
" }}}1

" vim:set ft=vim ts=8 sw=4 sts=4:
