require 'thor'
require 'vimmer'

module Vimmer
  class CLI < Thor

    desc "install PATH", "Installs plugin available at path PATH"
    def install(path)
      if path =~ /vim-awesomemofo/
        installer = Vimmer::Installers::Github.new(path)
        installer.install
      else
        $stderr.puts "The plugin not-found could not be found"
        exit 1
      end
    end

  end
end
