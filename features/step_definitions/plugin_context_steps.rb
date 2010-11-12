Given /^I have no plugins installed$/ do
  @vimmer = VimmerStub.new
  Given('a file named ".vimmer/plugins.yml" with:', "--- {}\n")
end

