module Vimmer
  module Installers

    GIT_URL_PATTERN = %r{^git://(\w|[-_+./])+/((\w|[-_+.])+)\.git$}
  
    class GitUrl
      attr_reader :path, :plugin_name

      def initialize(args={})
        if args[:path]
          initialize_with_path(args[:path])
        elsif args[:name]
          initialize_with_name(args[:name])
        end
      end 

      def install
        if path_exists?
          git_clone(path, File.join(Vimmer.bundle_path, plugin_name))
          Vimmer.add_plugin(plugin_name, path)
          puts "#{plugin_name} has been installed"
        else
          raise Vimmer::PluginNotFoundError
        end
      end     

      def uninstall
        plugin_path = File.join(Vimmer.bundle_path, plugin_name)
        if File.directory? plugin_path
          FileUtils.rm_rf(plugin_path)
          Vimmer.remove_plugin(plugin_name)
          puts "#{plugin_name} has been uninstalled"
        else
          raise Vimmer::PluginNotFoundError
        end
      end      

      def path_exists?
        `curl --head -w %{http_code} -o /dev/null #{remove_extension(path)} 2> /dev/null`.chomp == "200"
      end

      def self.match?(url)
        is_git_url?(url)
      end

      def self.is_git_url?(url)
        GIT_URL_PATTERN.match(url)
      end

      private

      def git_clone(path, install_to)
        output = `git clone #{path} #{install_to}`
      end

      def initialize_with_path(path)

        raise Vimmer::InvalidPathError.new(path) unless path =~ GIT_URL_PATTERN

        @plugin_name = $2
        @path = path
      end

      def initialize_with_name(name)
        @path = Vimmer.plugins[name]
        @plugin_name = name
      end

      def remove_extension(path)
        path.gsub(/\.git$/, '')
      end

    end
  end
end
