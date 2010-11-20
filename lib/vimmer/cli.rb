require 'thor'
require 'vimmer'

module Vimmer
  class CLI < Thor

    desc "install PATH", "Installs plugin available at path PATH"
    def install(path)
      begin
        installer = Vimmer::Installers::Github.new(path)
        installer.install
      rescue Vimmer::InvalidPathError => e
        $stderr.puts "The URL #{e.path} is invalid."
        exit 1
      rescue Vimmer::PluginNotFoundError
        $stderr.puts "The plugin #{installer.plugin_name} could not be found"
        exit 1
      end
    end

  end
end
