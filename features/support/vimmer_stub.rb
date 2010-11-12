class VimmerStub

  def installed_plugins
    plugin_store.map{ |name,path| name }
  end


  def plugin_store
    YAML.load_file("tmp/aruba/.vimmer/plugins.yml")
  end

end
