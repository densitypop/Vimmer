module Vimmer

  autoload :Installers,   'vimmer/installers'
  autoload :Settings,     'vimmer/settings'
  autoload :PluginPath,   'vimmer/plugin_path'
  autoload :Plugin,       'vimmer/plugin'

  class PluginNotFoundError < StandardError; end
  class InvalidPathError < StandardError
    attr_accessor :path

    def initialize(path)
      @path = path
    end

  end

  class InstallerNotFoundError < StandardError
    attr_accessor :path

    def initialize(path)
      @path = path
    end

  end


  def bundle_path
    settings[:bundle_path]
  end
  module_function :bundle_path

  def autoload_path
    settings[:autoload_path]
  end
  module_function :autoload_path

  def settings
    @settings ||= Settings.new
  end
  module_function :settings


  def add_plugin(name, path)
    settings.add_plugin(name, path)
  end
  module_function :add_plugin


  def remove_plugin(name)
    settings.remove_plugin(name)
  end
  module_function :remove_plugin


  def plugin?(name)
    plugins.key?(name)
  end
  module_function :plugin?

  def plugins
    settings.plugins
  end
  module_function :plugins


  def setup
    settings.create_vimmer_home!
    settings.create_default_config_file!
  end
  module_function :setup


end
