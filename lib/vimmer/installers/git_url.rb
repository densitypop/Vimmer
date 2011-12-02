module Vimmer
  module Installers

    GIT_URL_PATTERN = %r{^git://(\w|[-_+./])+/((\w|[-_+.])+)\.git$}
  
    class GitUrl < BaseInstaller
      
      def self.match?(url)
        is_git_url?(url)
      end

      def self.is_git_url?(url)
        GIT_URL_PATTERN.match(url)
      end

      private

      def initialize_with_path(path)
        raise Vimmer::InvalidPathError.new(path) unless path =~ GIT_URL_PATTERN

        @plugin_name = $2
        @path = path
      end

    end
  end
end
