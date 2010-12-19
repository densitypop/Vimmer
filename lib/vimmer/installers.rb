module Vimmer
  module Installers
    extend self

    autoload :Github,      'vimmer/installers/github'
    autoload :VimDotOrg,   'vimmer/installers/vim_dot_org'


    def for_url(url)
      if Github.match?(url)
        Github
      elsif VimDotOrg.match?(url)
        VimDotOrg.for_url(url)
      else
        raise Vimmer::InstallerNotFoundError.new(url)
      end
    end


  end
end
