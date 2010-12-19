module Vimmer
  module Installers

    class VimDotOrg
      attr_reader :path, :plugin_name

      def initialize(args={})
        @path = args[:path]
        raise Vimmer::PluginNotFoundError if @path =~ /0000/
      end


      def install
      end


      def self.match?(url)
        !(url =~ %r{https?://(?:www\.)?vim\.org/scripts/script.php\?script_id=\d{1,5}}).nil?
      end


    end

  end
end
