require 'thor'
require 'vimmer'

module Vimmer
  class CLI < Thor

    desc "install PATH", "Installs plugin available at path PATH"
    def install(path)
      setup
      begin
        installer = Vimmer::Installers.for_url(path)
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
      installer = Vimmer::Installers::BaseInstaller.new(:name => name)
      installer.uninstall
    rescue Vimmer::PluginNotFoundError
      $stderr.puts "The plugin #{installer.plugin_name} could not be found"
      exit 1
    end

    desc "update [NAME]", "Updates the plugin named NAME or all the plugins if no name is given"
    def update(name=nil)
      if name
        unless Vimmer.plugin?(name)
          $stderr.puts "The plugin #{name} is not installed."
          exit 1
        end
        installer = Vimmer::Installers::BaseInstaller.new(:name => name)
        installer.update
      else
        Vimmer.plugins.each do |name, path|
          update name
        end
        puts "all plugins updated"
      end
    end

    desc "list", "Lists currently installed plugins"
    def list
      plugins = Vimmer.plugins
      longest_name = plugins.keys.max { |a, b| a.length <=> b.length }
      plugins.each do |name, path|
        printf "%-#{longest_name.size}s  %s\n", name, "[#{path}]"
      end
    end

    desc "pathogen", "Installs pathogen"
    def pathogen
      installer = Vimmer::Installers::Pathogen.new
      installer.install
      
    rescue Vimmer::PluginNotFoundError
      $stderr.puts "The plugin #{installer.plugin_name} could not be found"
      exit 1
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
