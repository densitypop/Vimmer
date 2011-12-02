module Vimmer
  module Installers
    extend self

    autoload :BaseInstaller, 'vimmer/installers/base_installer'
    autoload :Github,        'vimmer/installers/github'
    autoload :GitUrl,        'vimmer/installers/git_url'
    autoload :VimDotOrg,     'vimmer/installers/vim_dot_org'
    autoload :Pathogen,      'vimmer/installers/pathogen'

    @installers = [Github, GitUrl, VimDotOrg]

    def for_url(url)
      @installers.each do |installer|
        return installer.new(:path => url) if installer.match? url
      end

      raise Vimmer::InstallerNotFoundError.new(url)
    end
  end
end
