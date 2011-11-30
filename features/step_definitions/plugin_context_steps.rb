Given /^I have no plugins installed$/ do
  @vimmer = VimmerStub.new
  step 'a file named ".vimmer/plugins.yml" with:', {}.to_yaml
  step 'a directory named "bundle"'
end
