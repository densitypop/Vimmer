Then /^a plugin named "([^"]*)" should be installed$/ do |arg1|
  @vimmer.installed_plugins.should include("vim-awesomemofo")
end

Then /^the plugin store should contain the "([^"]*)" plugin$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

