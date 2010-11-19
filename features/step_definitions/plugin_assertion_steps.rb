Then /^a plugin named "([^"]*)" should be installed$/ do |name|
  @vimmer.installed_plugins.should include(name)
  @vimmer.plugin_store[name].should =~ %r{https://github.com/tpope/vim-awesomemofo.git}
end

Then /^I should still not have any plugins installed$/ do
  @vimmer.installed_plugins.length.should == 0
  @vimmer.plugin_store.should == {}
end

