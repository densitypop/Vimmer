Feature: Install plugin

  Background:
    Given a directory named ".vimmer"
    And a bundle path set for my system
    And I have no plugins installed

  Scenario: Install from Github
    When I successfully run "vimmer install 'https://github.com/tpope/vim-awesomemofo.git'"
    Then a plugin named "vim-awesomemofo" should be installed
    And the stdout should contain "vim-awesomemofo has been installed"

  Scenario: Install from Github with bad URL
    When I run "vimmer install 'https://github.com/tpope/not-found.git'"
    Then I should still not have any plugins installed
    And it should fail with:
    """
    The plugin not-found could not be found
    """

  Scenario: Install from Github with a non-Github URL
    When I run "vimmer install 'http://example.com/bad'"
    Then I should still not have any plugins installed
    And it should fail with:
    """
    The URL http://example.com/bad is invalid.
    """

  Scenario Outline: Install from Github with a front-end Github URL
    When I successfully run "vimmer install '<URL>'"
    Then a plugin named "vim-awesomemofo" should be installed
    And the stdout should contain "vim-awesomemofo has been installed"

    Examples:
      | URL                                      |
      | http://github.com/tpope/vim-awesomemofo  |
      | https://github.com/tpope/vim-awesomemofo |

  Scenario: Accept URLs with a "."
    When I run "vimmer install 'http://github.com/tpope/awesomemofo.vim'"
    Then it should pass with:
    """
    awesomemofo.vim has been installed
    """

