module Vimmer
  module Installers
    extend self

    autoload :BaseInstaller, 'vimmer/installers/base_installer'
    autoload :Github,        'vimmer/installers/github'
    autoload :GitUrl,        'vimmer/installers/git_url'
    autoload :VimDotOrg,     'vimmer/installers/vim_dot_org'

    def for_url(url)
      if Github.match?(url)
        Github
      elsif GitUrl.match?(url)
        GitUrl
      elsif VimDotOrg.match?(url)
        VimDotOrg.for_url(url)
      else
        raise Vimmer::InstallerNotFoundError.new(url)
      end
    end


  end
end
