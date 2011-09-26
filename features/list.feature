Feature: List plugins

  Background:
    Given a directory named ".vimmer"
    And a bundle path set for my system
    And I have no plugins installed

  Scenario: List without any plugins
    When I run "vimmer list"
    Then the stdout should be empty

  Scenario: List the plugin installed
    When I successfully run "vimmer install 'https://github.com/tpope/vim-awesomemofo.git'"
    And I run "vimmer list"
    Then the stdout should contain "vim-awesomemofo  [https://github.com/tpope/vim-awesomemofo.git]"
