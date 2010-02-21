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

The default post suffix is "markdown". You can override this if you like:

    let g:jekyll_post_suffix = "textile"

You may also want to ad a few mappings to stream line the behavior:

    map <Leader>jn  :JekyllPost<CR>
    map <Leader>jl  :JekyllList<CR>


By default all posts are created as drafts (published: false in the YAML), to publish that post simply delete that line.

Commands
========

List Jekyll posts:

    :JekyllList

Create a new Jekyll Post:

    :JekyllPost

If you are using git to store your blog, consider installing Tim Pope's [vim-fugitive](http://github.com/tpope/vim-fugitive) plugin. It allows you to use the following commands to speed things up.

Add and commit the current post:

    :Gwrite
    :Gcommit

Push the changes to the remote origin:

    :Git push


LICENSE
=======

License: Same terms as Vim itself (see [license](http://vimdoc.sourceforge.net/htmldoc/uganda.html#license))

:-)
