Feature: Install plugin

  Background:
    Given a directory named ".vimmer"
    And a file named "config" with:
    """
    bundle_path: "tmp/aruba/bundle"
    """

  Scenario: Install from Github
    Given I have no plugins installed
    When I successfully run "vimmer install \"https://github.com/tpope/vim-awesomemofo.git\""
    Then a plugin named "vim-awesomemofo" should be installed
    And the stdout should contain "vim-awesomemofo has been installed"
