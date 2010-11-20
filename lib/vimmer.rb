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

  def bundle_path
    settings[:bundle_path]
  end
  module_function :bundle_path


  def settings
    @settings ||= Settings.new
  end
  module_function :settings


  def add_plugin(name, path)
    settings.add_plugin(name, path)
  end
  module_function :add_plugin


  def plugins
    settings.plugins
  end
  module_function :plugins


end
