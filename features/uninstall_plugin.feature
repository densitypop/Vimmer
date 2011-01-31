Feature: Uninstall plugin

  Background:
    Given a directory named ".vimmer"
    And a bundle path set for my system
    And I have no plugins installed

  Scenario: Uninstall from Github
    When I successfully run "vimmer install 'https://github.com/tpope/vim-awesomemofo.git'"
    And I successfully run "vimmer uninstall 'vim-awesomemofo'"
    Then I should still not have any plugins installed

  Scenario: Uninstall from a git:// url
    When I successfully run "vimmer install 'git://git.wincent.com/command-t.git'"
    And I successfully run "vimmer uninstall 'command-t'"
    Then I should still not have any plugins installed

  Scenario: Attempt to uninstall a plugin that is not installed
    When I run "vimmer uninstall not_installed"
    Then it should fail with:
    """
    The plugin not_installed is not installed.
    """

