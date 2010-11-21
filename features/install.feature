Feature: Install plugin

  Background:
    Given a directory named ".vimmer"
    And a bundle path set for my system

  Scenario: Install from Github
    Given I have no plugins installed
    When I successfully run "vimmer install 'https://github.com/tpope/vim-awesomemofo.git'"
    Then a plugin named "vim-awesomemofo" should be installed
    And the stdout should contain "vim-awesomemofo has been installed"

  Scenario: Install from Github with bad URL
    Given I have no plugins installed
    When I run "vimmer install 'https://github.com/tpope/not-found.git'"
    Then I should still not have any plugins installed
    And it should fail with:
    """
    The plugin not-found could not be found
    """

  Scenario: Install from Github with a non-Github URL
    Given I have no plugins installed
    When I run "vimmer install 'http://example.com/bad'"
    Then I should still not have any plugins installed
    And it should fail with:
    """
    The URL http://example.com/bad is invalid.
    """
