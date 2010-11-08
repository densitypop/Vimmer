module Vimmer
  module Installers
    class Github
      attr_reader :path

      def initialize(path)
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
