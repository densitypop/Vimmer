Then /^a plugin named "([^"]*)" should be installed$/ do |name|
  @vimmer.installed_plugins.should include(name)
  @vimmer.plugin_store[name].should =~ %r{tmp/aruba/bundles/#{name}}
end

Then /^a plugin named "([^"]*)" should not be installed$/ do |name|
  @vimmer.installed_plugins.should_not include(name)
  @vimmer.plugin_store[name].should be_nil
end

