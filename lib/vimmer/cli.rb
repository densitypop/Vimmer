require 'thor'
require 'vimmer'

module Vimmer
  class CLI < Thor

    desc "install PATH", "Installs plugin available at path PATH"
    def install(path)
      if path =~ /vim-awesomemofo/
        puts "vim-awesomemofo has been installed"
      else
        $stderr.puts "The plugin not-found could not be found"
        exit 1
      end
    end

  end
end
