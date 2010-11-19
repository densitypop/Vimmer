class VimmerStub

  def installed_plugins
    bundle_path.entries.map do |entry|
      next if entry.to_s =~ /^\.\.?$/

      entry = bundle_path.join(entry)
      if entry.directory?
        entry.split.last.to_s
      end
    end.compact
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


  def bundle_path
    Pathname.new("tmp/aruba/bundle")
  end

end
