module Vimmer

  autoload :Settings,     'vimmer/settings'
  autoload :PluginPath,   'vimmer/plugin_path'
  autoload :Plugin,       'vimmer/plugin'

  def bundle_path
    settings[:bundle_path]
  end
  module_function :bundle_path


  def settings
    @settings ||= Settings.new
  end
  module_function :settings


end
