Given /^I have no plugins installed$/ do
  @vimmer = VimmerStub.new
  Given('an empty file named "plugins.yml"')
end

