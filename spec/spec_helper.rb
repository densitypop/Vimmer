require 'bundler/setup'

$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)

require 'vimmer'

require 'fakefs/spec_helpers'

RSpec.configure do |config|

  config.mock_with :rr

  config.include FakeFS::SpecHelpers

  def app_root
    Pathname.new(File.join(__FILE__, "..", "tmp", ".vimmer"))
  end


end
