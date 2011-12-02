require 'pathname'
require 'yaml'

module Vimmer
  class Settings


    def initialize
      @config = defaults.merge(load_config(config_file))
    end


    def [](key)
      value = File.expand_path(@config[key.to_s])
      if value && File.exists?(value)
        Pathname.new(value)
      else
        value
      end
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


    def create_vimmer_home!
      FileUtils.mkdir_p(config_root.to_s)
    end


    def create_default_config_file!
      return if File.exist?(config_file.to_s)
      write_default_config_file
      @config = load_config(config_file)
    end

    def write_default_config_file
      File.open(config_file.to_s, "w") do |f|
        f << "bundle_path: ~/.vim/bundle"
      end
    end


    def add_plugin(name, path)
      existing_plugins = plugins.dup
      existing_plugins.merge!(name => path)

      write_to_manifest(existing_plugins)
    end

    def remove_plugin(name)
      existing_plugins = plugins.dup
      existing_plugins.delete(name)

      write_to_manifest(existing_plugins)
    end

    def plugins
      @plugins = if !File.exist?(plugin_store_file.to_s)
                     write_to_manifest({})
                   end

      read_from_manifest
    end


    def read_from_manifest
      YAML.load_file(plugin_store_file.to_s)
    end

    def write_to_manifest(hash)
      File.open(plugin_store_file.to_s, "w") do |f|
        f << hash.to_yaml
      end
    end

    def load_config(config_file)
      config_file = File.expand_path(config_file)
      if config_file && File.exist?(config_file.to_s)
        YAML.load_file(config_file)
      else
        {}
      end
    end


    def defaults
      { "bundle_path" => "~/.vim/bundle",
        "autoload_path" => "~/.vim/autoload" }
    end

  end
end
