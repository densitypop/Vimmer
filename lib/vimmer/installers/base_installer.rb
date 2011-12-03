module Vimmer
  module Installers
    class BaseInstaller
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
          git_clone(path, plugin_path)
          Vimmer.add_plugin(plugin_name, path)
          puts "#{plugin_name} has been installed"
        else
          raise Vimmer::PluginNotFoundError
        end
      end

      def uninstall
        Vimmer.remove_plugin(plugin_name)
        if File.directory? plugin_path
          FileUtils.rm_rf(plugin_path)
          puts "#{plugin_name} has been uninstalled"
        else
          raise Vimmer::PluginNotFoundError
        end
      end

      def update
        if File.directory? plugin_path
          if git_pull plugin_path
            puts "#{plugin_name} has been updated"
          end
        else
          raise Vimmer::PluginNotFoundError
        end
      end

      def path_exists?
        `curl --head -w %{http_code} -o /dev/null #{curl_url(path)} 2> /dev/null`.chomp == "200"
      end

      private

      def plugin_path
        File.join Vimmer.bundle_path, plugin_name
      end

      def git_needs_update(path)
        Dir.chdir path do
          `git ls-remote origin -h refs/heads/master` !=
          `git rev-list --max-count=1 origin/maser`
        end
      end

      def git_clone(path, install_to)
        output = `git clone #{path} #{install_to}`
      end

      def git_pull(path)
        output = ''
        Dir.chdir path do
          output = `git pull`
        end
        output == ''
      end

      def curl_url(path)
        curl_path = remove_extension(path)
        curl_path = make_protocol_http(curl_path)
      end

      def remove_extension(path)
        path.gsub(/\.git$/, '')
      end     

      def make_protocol_http(path)
        path.gsub(%r{git://},'http://')
      end

     def initialize_with_name(name)
        @path = Vimmer.plugins[name]
        @plugin_name = name
      end      
    end
  end
end
