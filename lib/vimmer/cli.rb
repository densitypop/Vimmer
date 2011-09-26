require 'thor'
require 'vimmer'

module Vimmer
  class CLI < Thor

    desc "install PATH", "Installs plugin available at path PATH"
    def install(path)
      setup
      begin
        installer = Vimmer::Installers.for_url(path)
        # TODO: Make this consistent with VimDotOrg installer
        if installer == Vimmer::Installers::Github
          installer = installer.new(:path => path)
        end
        installer.install
      rescue Vimmer::InstallerNotFoundError => e
        $stderr.puts "The URL #{e.path} is invalid."
        exit 1
      rescue Vimmer::InvalidPathError => e
        $stderr.puts "The URL #{e.path} is invalid."
        exit 1
      rescue Vimmer::PluginNotFoundError
        $stderr.puts "The plugin #{installer.plugin_name} could not be found"
        exit 1
      end
    end

    desc "uninstall NAME", "Removes plugin named NAME"
    def uninstall(name)
      unless Vimmer.plugin?(name)
        $stderr.puts "The plugin #{name} is not installed."
        exit 1
      end
      installer = Vimmer::Installers::Github.new(:name => name)
      installer.uninstall
    end

    desc "list", "Lists currently installed plugins"
    def list
      plugins = Vimmer.plugins
      longest_name = plugins.keys.max { |a, b| a.length <=> b.length }
      plugins.each do |name, path|
        printf "%-#{longest_name.size}s  %s\n", name, "[#{path}]"
      end
    end

    private

    def setup
      Vimmer.setup
    end


    def method_missing(name, *args)
      $stderr.puts 'Could not find command "%s".' % name
      exit 1
    end


  end
end
