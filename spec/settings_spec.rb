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


  it "expands the path when calling bundle_path" do
    ENV['VIMMER_HOME'] = vimmer_home.to_s

    bundle_path = app_root.join("lib", "..", "tmp", "bundle")
    File.open(vimmer_home.join("config").to_s, "w") do |f|
      f << "bundle_path: #{bundle_path}"
    end

    Vimmer::Settings.new[:bundle_path].should == File.expand_path(bundle_path)

    ENV['VIMMER_HOME'] = nil
  end


end
