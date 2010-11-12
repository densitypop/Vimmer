module Vimmer
  class Settings


    def initialize
      @config = if File.exist?(config_file)
                  YAML.load_file(config_file)
                else
                  {}
                end
    end


    def [](key)
      @config[key.to_s]
    end


    def config_file
      config_root.join("config")
    end

    def plugin_store_file
      @plugin_store_file ||= config_root.join("plugins.yml")
    end

    def config_root
      Pathname.new(ENV['VIMMER_HOME'] || File.join(Gem.user_home, ".vimmer"))
    end


    def add_plugin(name, path)
      existing_plugins = plugins.dup
      existing_plugins.merge!(name => path)

      write_to_manifest(existing_plugins)
    end


    def plugins
      @plugins = if File.exist?(plugin_store_file.to_s)
                     read_from_manifest
                   else
                     write_to_manifest({})
                     read_from_manifest
                   end
    end


    def read_from_manifest
      YAML.load_file(plugin_store_file.to_s)
    end

    def write_to_manifest(hash)
      File.open(plugin_store_file.to_s, "w") do |f|
        f << hash.to_yaml
      end
    end

  end
end
