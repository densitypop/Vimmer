require 'bundler/setup'

$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)

require 'vimmer'

require 'fakefs/spec_helpers'
require 'bourne'


RSpec.configure do |config|

  config.include FakeFS::SpecHelpers
  config.mock_with :mocha

  def app_root
    Pathname.new(File.join(__FILE__, "..", "tmp", ".vimmer"))
  end


end
