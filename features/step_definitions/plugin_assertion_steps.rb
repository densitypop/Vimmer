Then /^a plugin named "([^"]*)" should be installed$/ do |name|
  @vimmer.installed_plugins.should include(name)
  @vimmer.plugin_store[name].should =~ %r{https://github.com/.*/#{name}\.git}
end

Then /^I should still not have any plugins installed$/ do
  @vimmer.installed_plugins.should be_empty
  @vimmer.plugin_store.should == {}
end

