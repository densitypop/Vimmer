module Vimmer
  module Installers

    class Pathogen < Github

      def initialize
        super :path => "https://github.com/tpope/vim-pathogen.git"
      end

      def install
        super

        old_name = File.join Vimmer.bundle_path, plugin_name, "autoload", "pathogen.vim"
        new_name = File.join Vimmer.autoload_path, "pathogen.vim"

        if !File.exists? new_name
          File.symlink old_name, new_name
        end
      end
    end
  end
end
