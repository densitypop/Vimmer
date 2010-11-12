class VimmerStub

  def installed_plugins
    plugin_store.map{ |name,path| name }
  end


  def plugin_store
    if plugin_store_file.exist?
      YAML.load_file(plugin_store_file)
    else
      {}
    end
  end


  def plugin_store_file
    Pathname.new("tmp/aruba/.vimmer/plugins.yml")
  end

end
