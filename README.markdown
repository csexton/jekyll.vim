Jekyll.vim
==========

jekyll.vim:  Blogging from the command line should not be tedious.

This script is intended to automate the process of creating and editing [Jekyll](http://jekyllrb.com/) blog posts from within [vim](http://www.vim.org/).

Introduction
============

Install in ~/.vim, you can use the rake task to do this quickly:

    rake install

Set the path to your Jekyll Blog in your vimrc:

    let g:jekyll_path = "/path/to/jekyll/blog"

You may also want to ad a few mappings to stream line the behavior:

    map <Leader>jn  :JekyllPost<CR>
    map <Leader>jl  :JekyllList<CR>
    map <Leader>jc  :JekyllCommit<CR>
    map <Leader>jp  :JekyllPublish<CR>

Commands
========

List Jekyll posts:

    :JekyllList

Create a new Jekyll Post:

    :JekyllPost

If you are using git to store your blog, then you can use the following commands to speed that up.

Add and commit all the modified posts:

    :JekyllCommit

Pushe the changes to the remote origin:

    :JekyllPublish


LICENSE
=======

License: Same terms as Vim itself (see [license](http://vimdoc.sourceforge.net/htmldoc/uganda.html#license))

:-)
