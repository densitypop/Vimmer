Then /^a plugin named "([^"]*)" should be installed$/ do |arg1|
  @vimmer.installed_plugins.should include("vim-awesomemofo")
  @vimmer.plugin_store["vim-awesomemofo"].should =~ %r{tmp/aruba/bundles/vim-awesomemofo}
end

