@announce
Feature: Setup

  Scenario: Run without .vimmer directory
    Given no directory named ".vimmer"
    When I successfully run "vimmer install 'https://github.com/tpope/vim-awesomemofo.git'"
    Then a directory named ".vimmer" should exist
    And the file ".vimmer/config" should contain "bundle_path: ~/.vim/bundle"

  @backlog
  Scenario: Run with .vimmer directory (doesn't overwrite)
    Given a directory named ".vimmer"
    And a file named ".vimmer/config" with:
    """
    bundle_path: ~/.vim/custom_bundle
    """
    When I successfully run "vimmer install 'https://github.com/tpope/vim-awesomemofo.git'"
    Then the file ".vimmer/config" should contain "bundle_path: ~/.vim/custom_bundle"
