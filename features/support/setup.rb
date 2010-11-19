require 'aruba'

ENV['PATH'] = File.expand_path(File.dirname(__FILE__)) + ":" + ENV['PATH']
ENV['VIMMER_HOME'] = File.expand_path(File.join(File.dirname(__FILE__),
                                                %w(.. .. tmp aruba .vimmer)))
