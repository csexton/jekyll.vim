require "rubygems"
require "rake"

desc "Deploy to codeography.com"
task :install do
  puts "Copying jekyll.vim to #{ENV['HOME']}/.vim"
  FileUtils.copy(File.dirname(__FILE__) + "/plugin/jekyll.vim", ENV['HOME'] + "/.vim/plugin")
  FileUtils.copy(File.dirname(__FILE__) + "/doc/jekyll.txt", ENV['HOME'] + "/.vim/doc")
  puts "Yay."
end

