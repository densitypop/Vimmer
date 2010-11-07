Then /^a bundle named "([^"]*)" should be installed$/ do |arg1|
  @vimmer.installed_bundles.should include("vim-awesomemofo")
end

Then /^the bundle store should contain the "([^"]*)" bundle$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

