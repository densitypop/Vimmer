require 'spec_helper'

include Vimmer::Installers

describe "When installing from Github" do

  FOUND_URL = "https://github.com/tpope/vim-awesomemofo.git"
  NOT_FOUND_URL = "https://github.com/tpope/not-found.git"

  context "with a non-existant URL" do

    let(:installer) { Github.new(:path => NOT_FOUND_URL) }

    before do
      installer.stubs(:path_exists?).returns(false)
      installer.stubs(:git_clone)
    end

    specify "the installer should raise an exception" do
      lambda { installer.install }.should raise_error(Vimmer::PluginNotFoundError)
    end

  end

  context "with a good URL" do

    let(:installer) { Github.new(:path => FOUND_URL) }

    before do
      installer.stubs(:git_clone)
      installer.stubs(:path_exists?).returns(true)
    end

    specify "the installer should not raise an exception" do
      lambda { installer.install }.should_not raise_error
    end

    specify "the installer calculates the plugin's name" do
      installer.plugin_name.should == "vim-awesomemofo"
    end

  end

  context "with a malformed URL" do

    subject { Github.new(:path => "https://foo.com/bar") }

    specify "the installer should raise an exception" do
      lambda { subject }.should raise_error(Vimmer::InvalidPathError)
    end

  end

  it "provides access to the path" do
    Github.new(:path => FOUND_URL).
      path.should == FOUND_URL
  end

  it "adds plugin to list of installed plugins" do

    installer = Github.new(:path => FOUND_URL)

    installer.stubs(:path_exists?).returns(true)
    installer.stubs(:git_clone)

    installer.install

    Vimmer.plugins["vim-awesomemofo"].should == FOUND_URL

  end

  def stub_for_install!(installer)

    Vimmer.stubs(:bundle_path).returns(Pathname.new("tmp/bundle"))

    class << installer
      def git_clone(arg1, arg2)
        FileUtils.mkdir_p(Vimmer.bundle_path.join("vim-awesomemofo", "plugins"))
        FileUtils.touch(Vimmer.bundle_path.join("vim-awesomemofo", "plugins", "vim-awesomemofo.vim"))
      end
    end

    installer.stubs(:path_exists?).returns true

  end


  it "installs the plugin" do

    installer = Github.new(:path => FOUND_URL)

    stub_for_install! installer

    installer.install

    plugin_path = Vimmer.bundle_path.join("vim-awesomemofo")
    File.directory?(plugin_path.to_s).should be_true
    File.directory?(plugin_path.join("plugins").to_s).should be_true
    File.file?(plugin_path.join("plugins", "vim-awesomemofo.vim")).should be_true
  end

  it "uninstalls the plugin" do

    installer = Github.new(:name => "vim-awesomemofo")

    stub_for_install! installer

    installer.install

    installer.uninstall

    plugin_path = Vimmer.bundle_path.join("vim-awesomemofo")
    File.directory?(plugin_path.to_s).should be_false
    File.directory?(plugin_path.join("plugins").to_s).should be_false
  end


end
