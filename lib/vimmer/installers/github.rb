module Vimmer
  module Installers
    class Github
      attr_reader :path

      def initialize(path)
        raise "Invalid URL" unless path =~ %r{^https://github.com/[a-zA-Z0-9-_\+%]+/[a-zA-Z0-9\-_\+]+.git$}
        @path = path
      end


      def install
        if path =~ /not-found/
          raise "Not found"
        else
          puts "vim-awesomemofo has been installed"
        end
      end


    end
  end
end
