require 'spec_helper'

describe ".vimmer/" do

  let(:settings) { Vimmer::Settings.new }

  it "can be moved with an environment variable" do
    ENV['VIMMER_HOME'] = app_root.join("tmp", ".vimmer").to_s
    settings.config_root.relative_path_from(app_root).to_s.should == "tmp/.vimmer"
    settings.config_file.relative_path_from(app_root).to_s.should == "tmp/.vimmer/config"
    ENV['VIMMER_HOME'] = nil
  end

  it "creates the .vimmer directory" do
    settings.create_vimmer_home!
    settings.config_root.should exist
  end


  it "creates the config file" do
    settings.create_default_config_file!
    settings.config_file.should exist
    File.read(settings.config_file).should =~ /bundle_path: ~\/.vim\/bundle/
  end

end
