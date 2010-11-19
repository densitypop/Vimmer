require 'spec_helper'

describe "When installing from Github" do
  include Vimmer::Installers

  context "with a non-existant URL" do

    let(:installer) { Github.new("https://github.com/tpope/not-found.git") }

    before do
      stub(installer).git_clone
    end

    specify "the installer should raise an exception" do
      lambda { installer.install }.should raise_error(Vimmer::PluginNotFoundError)
    end

  end

  context "with a good URL" do

    let(:installer) { Github.new("https://github.com/tpope/vim-awesomemofo.git") }

    before do
      stub(installer).git_clone
    end

    specify "the installer should not raise an exception" do
      lambda { installer.install }.should_not raise_error
    end

    specify "the installer calculates the plugin's name" do
      installer.plugin_name.should == "vim-awesomemofo"
    end

  end

  context "with a malformed URL" do

    subject { Github.new("https://foo.com/bar") }

    specify "the installer should raise an exception" do
      lambda { subject }.should raise_error("Invalid URL")
    end

  end

  it "provides access to the path" do
    Github.new("https://github.com/tpope/vim-awesomemofo.git").
      path.should == "https://github.com/tpope/vim-awesomemofo.git"
  end

  it "adds plugin to list of installed plugins" do

    installer = Github.new("https://github.com/tpope/vim-awesomemofo.git")

    stub(installer).git_clone

    installer.install

    Vimmer.plugins["vim-awesomemofo"].should == "https://github.com/tpope/vim-awesomemofo.git"

  end

  it "installs the plugin" do

    installer = Github.new("https://github.com/tpope/vim-awesomemofo.git")

    stub(Vimmer).bundle_path do
      Pathname.new("tmp/bundle")
    end

    stub(installer).git_clone do
      FileUtils.mkdir_p(Vimmer.bundle_path.join("vim-awesomemofo", "plugins"))
      FileUtils.touch(Vimmer.bundle_path.join("vim-awesomemofo", "plugins", "vim-awesomemofo.vim"))
    end

    installer.install

    plugin_path = Vimmer.bundle_path.join("vim-awesomemofo")
    File.directory?(plugin_path.to_s).should be_true
    File.directory?(plugin_path.join("plugins").to_s).should be_true
    File.file?(plugin_path.join("plugins", "vim-awesomemofo.vim")).should be_true
  end


end
