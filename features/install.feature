Feature: Install plugin

  Scenario: Install from Github
    When I run "vimmer install https://github.com/tpope/vim-awesomemofo.git"
    Then a bundle named "vim-awesomemofo" should be installed
    And the bundle store should contain the "vim-awesomemofo" bundle
    And the stdout should contain "vim-awesomemofo has been installed"
