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

    def config_root
      Pathname.new(ENV['VIMMER_HOME'] || File.join(Gem.user_home, ".vimmer"))
    end

  end
end
