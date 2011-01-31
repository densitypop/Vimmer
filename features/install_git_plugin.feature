Feature: Install git:// plugin

  Background:
    Given a directory named ".vimmer"
    And a bundle path set for my system
    And I have no plugins installed
    
  Scenario: Install from wincent.com
    When I successfully run "vimmer install git://git.wincent.com/command-t.git"
    Then a git plugin named "command-t" should be installed
    And the stdout should contain "command-t has been installed"

  Scenario: Install from a git url with bad URL
    When I run "vimmer install 'git://git.wincent.com/not-found.git'"
    Then I should still not have any plugins installed
    And it should fail with:
    """
    The plugin not-found could not be found
    """

  Scenario: Install from git url with a git protocol URL
    When I run "vimmer install 'http://git.wincent.com/command-t.git'"
    Then I should still not have any plugins installed
    And it should fail with:
    """
    The URL http://git.wincent.com/command-t.git is invalid.
    """

