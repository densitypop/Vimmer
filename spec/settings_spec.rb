require 'spec_helper'

describe ".vimmer/" do

  let(:settings) { Vimmer::Settings.new }

  it "can be moved with an environment variable" do
    ENV['VIMMER_HOME'] = app_root.join("tmp", ".vimmer").to_s
    settings.config_root.relative_path_from(app_root).to_s.should == "tmp/.vimmer"
    settings.config_file.relative_path_from(app_root).to_s.should == "tmp/.vimmer/config"
  end
end
