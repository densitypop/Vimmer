module Vimmer
  module Installers

    GITHUB_GIT_PATH_TEMPLATE = "https://github.com/%s/%s.git"
    GITHUB_GIT_URL_PATTERN = %r{^https://github.com/[a-zA-Z0-9\-_\+%]+/([a-zA-Z0-9\-_\+\.]+).git$}
    GITHUB_PUBLIC_URL_PATTERN = %r{^https?://github.com/([a-zA-Z0-9\-_\+%]+)/([a-zA-Z0-9\-_\+\.]+)$}

    class Github
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


      private

      def git_clone(path, install_to)
        output = `git clone #{path} #{install_to}`
      end


      def initialize_with_path(path)

        path = public_path_to_git_path($1, $2) if path =~ GITHUB_PUBLIC_URL_PATTERN

        raise Vimmer::InvalidPathError.new(path) unless path =~ GITHUB_GIT_URL_PATTERN

        @plugin_name = $1
        @path = path
      end


      def initialize_with_name(name)
        @path = Vimmer.plugins[name]
        @plugin_name = name
      end


      def remove_extension(path)
        path.gsub(/\.git$/, '')
      end


      def public_path_to_git_path(user, repo)
        GITHUB_GIT_PATH_TEMPLATE % [user, repo]
      end

    end
  end
end
