Feature: Install pathogen

  Background:
    Given a directory named ".vimmer"
    And config set for my system
    And I have no plugins installed

  Scenario: Install pathogen
    When I run "vimmer pathogen"
    Then a git plugin named "vim-pathogen" should be installed
