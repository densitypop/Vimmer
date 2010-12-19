require 'aruba/cucumber'
require 'webmock'
require File.dirname(__FILE__) + '/stubbed_http_requests'

ENV['RUBYOPT'] = "-r#{File.expand_path(File.join(File.dirname(__FILE__), 'stub-commands.rb'))} -rwebmock -r#{File.expand_path(File.join(File.dirname(__FILE__), 'stubbed_http_requests'))} #{ENV['RUBYOPT']}"
ENV['VIMMER_HOME'] = File.expand_path(File.join(File.dirname(__FILE__),
                                                %w(.. .. tmp aruba .vimmer)))
