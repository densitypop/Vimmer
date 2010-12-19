require 'aruba/cucumber'

ENV['RUBYOPT'] = "-r#{File.expand_path(File.join(File.dirname(__FILE__), 'stub-commands.rb'))} #{ENV['RUBYOPT']}"
ENV['VIMMER_HOME'] = File.expand_path(File.join(File.dirname(__FILE__),
                                                %w(.. .. tmp aruba .vimmer)))
