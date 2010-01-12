Jekyll.vim
==========

jekyll.vim:  Blogging from the command line should not be tedious.

Introduction
============

Install in ~/.vim, or in ~\vimfiles if you're on Windows and feeling lucky.

Set the path to your Jekyll Blog in your vimrc:

    let g:jekyll_path = "/path/to/jekyll/blog"

You may also want to ad a few mappings to stream line the behavior:

    map <Leader>jp  :JekyllPost<CR>
    map <Leader>jl  :JekyllList<CR>

Commands
========

List Jekyll posts:

    :JekyllList

Create a new Jekyll Post:

    :JekyllPost

LICENSE
=======

License: Same terms as Vim itself (see |license|)
