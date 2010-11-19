Given /^a bundle path set for my system$/ do
  bundle_path = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "tmp", "aruba", "bundle"))
  Given 'a file named ".vimmer/config" with:', "bundle_path: #{bundle_path}"
end

