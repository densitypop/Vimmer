Given /^a bundle path set for my system$/ do
  bundle_path = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "tmp", "aruba", "bundle"))
  step 'a file named ".vimmer/config" with:', "bundle_path: #{bundle_path}"
end

Given /^no directory named "([^"]*)"$/ do |directory|
  in_current_dir do
    FileUtils.rm_rf(directory)
  end
end

