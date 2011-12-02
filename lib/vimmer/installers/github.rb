module Vimmer
  module Installers

    GITHUB_GIT_PATH_TEMPLATE = "https://github.com/%s/%s.git"
    GITHUB_GIT_URL_PATTERN = %r{^https://github.com/[a-zA-Z0-9\-_\+%]+/([a-zA-Z0-9\-_\+\.]+).git$}
    GITHUB_PUBLIC_URL_PATTERN = %r{^https?://github.com/([a-zA-Z0-9\-_\+%]+)/([a-zA-Z0-9\-_\+\.]+[^.git])$}

    class Github < BaseInstaller

      def self.match?(url)
        is_github_url?(url)
      end

      def self.is_github_url?(url)
        !(GITHUB_PUBLIC_URL_PATTERN.match(url) ||
          GITHUB_GIT_URL_PATTERN.match(url)).nil?
      end

      private

      def initialize_with_path(path)

        path = public_path_to_git_path($1, $2) if path =~ GITHUB_PUBLIC_URL_PATTERN

        raise Vimmer::InvalidPathError.new(path) unless path =~ GITHUB_GIT_URL_PATTERN

        @plugin_name = $1
        @path = path
      end

      def public_path_to_git_path(user, repo)
        GITHUB_GIT_PATH_TEMPLATE % [user, repo]
      end

    end
  end
end
