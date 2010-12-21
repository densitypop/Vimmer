require 'net/http'
require 'json'

module Vimmer
  module Installers

    VIM_DOT_ORG_URL_PATTERN = %r{https?://(?:www\.)?vim\.org/scripts/script.php\?script_id=(\d{1,5})}

    class VimDotOrg
      attr_reader :path, :plugin_name, :script_id


      def self.match?(url)
        !(url =~ VIM_DOT_ORG_URL_PATTERN).nil?
      end

      def self.for_url(path)

        m = VIM_DOT_ORG_URL_PATTERN.match(path)
        script_id = m[1]

        raise Vimmer::PluginNotFoundError unless repository.key?(script_id)

        script_name = repository[script_id]
        github_path_template = "https://github.com/vim-scripts/%s.git"

        github_path = github_path_template % [script_name]

        Github.new(:path => github_path)
      end

      private

      def self.repository
        @repository ||= JSON.parse(Net::HTTP.get(repository_uri))
      end

      def self.repository_uri
        URI.parse("http://vim-scripts.org/api/script_ids.json")
      end


    end

  end
end
