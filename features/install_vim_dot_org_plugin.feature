Feature: Install vim.org plugin

  Background:
    Given a directory named ".vimmer"
    And a bundle path set for my system
    And I have no plugins installed

  @wip
  Scenario: Install from vim.org
    When I successfully run "vimmer install http://www.vim.org/scripts/script.php?script_id=2975"
    Then a github plugin named "fugitive.vim" should be installed
    And the stdout should contain "fugitive.vim has been installed"


