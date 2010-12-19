require 'bundler/setup'

$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)

require 'vimmer'

require 'fakefs/spec_helpers'
require 'bourne'

require 'webmock/rspec'


Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|

  config.include FakeFS::SpecHelpers
  config.include WebMock::API
  config.mock_with :mocha

  def app_root
    Pathname.new(File.join(File.dirname(__FILE__), ".."))
  end

  def vimmer_home
    app_root.join("tmp", ".vimmer")
  end


end
