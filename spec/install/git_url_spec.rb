require 'spec_helper'

include Vimmer::Installers

describe "When installing from git:// urls" do

  GIT_FOUND_URL = "git://git.wincent.com/command-t.git"
  GIT_NOT_FOUND_URL = "git://git.wincent.com/command-not-found.git"
  GIT_MALFORMED_URL = "git://foo.com/bar"

  RSpec::Matchers.define :be_a_valid_git_url do |expected|
    match do
      GitUrl.match?(expected)
    end
  end

  context "with a non-existant URL" do

    let(:installer) { GitUrl.new(:path => GIT_NOT_FOUND_URL) }

    before(:each) do
      installer.stubs(:path_exists?).returns(false)
      installer.stubs(:git_clone)
    end

    it { should be_a_valid_git_url(GIT_NOT_FOUND_URL) }

    specify "the installer should raise an exception" do
      lambda { installer.install }.should raise_error(Vimmer::PluginNotFoundError)
    end
  end

  context "with a good URL" do

    let(:installer) { GitUrl.new(:path => GIT_FOUND_URL) }

    before do
      installer.stubs(:git_clone)
      installer.stubs(:path_exists?).returns(true)
    end

    it { should be_a_valid_github_url(FOUND_URL) }

    specify "the installer should not raise an exception" do
      lambda { installer.install }.should_not raise_error
    end

    specify "the installer calculates the plugin's name" do
      installer.plugin_name.should == "command-t"
    end

  end  

  context "with a malformed URL" do

    let(:installer) { GitUrl.new(:path => GIT_MALFORMED_URL) }


    it { should_not be_a_valid_github_url(GIT_MALFORMED_URL) }

    specify "the installer should raise an exception" do
      lambda { installer }.should raise_error(Vimmer::InvalidPathError)
    end

  end  

  it "provides access to the path" do
    GitUrl.new(:path => GIT_FOUND_URL).
      path.should == GIT_FOUND_URL
  end  

  it "adds plugin to list of installed plugins" do

    installer = GitUrl.new(:path => GIT_FOUND_URL)

    installer.stubs(:path_exists?).returns(true)
    installer.stubs(:git_clone)

    installer.install

    Vimmer.plugins["command-t"].should == GIT_FOUND_URL
  end

  it "installs the plugin" do

    installer = GitUrl.new(:path => GIT_FOUND_URL)

    stub_for_install! installer

    installer.install

    plugin_path = Vimmer.bundle_path.join("command-t")


    File.directory?(plugin_path.to_s).should be_true
    File.directory?(plugin_path.join("plugins").to_s).should be_true
    File.file?(plugin_path.join("plugins", "command-t.vim")).should be_true

  end
 
  it "uninstalls the plugin" do

    installer = GitUrl.new(:name => "command-t")


    stub_for_install! installer

    installer.install

    installer.uninstall

    plugin_path = Vimmer.bundle_path.join("command-t")
    File.directory?(plugin_path.to_s).should be_false
    File.directory?(plugin_path.join("plugins").to_s).should be_false
  end

  private

  def stub_for_install!(installer)

    Vimmer.stubs(:bundle_path).returns(Pathname.new("tmp/bundle"))

    class << installer
      def git_clone(arg1, arg2)
        FileUtils.mkdir_p(Vimmer.bundle_path.join("command-t", "plugins"))
        FileUtils.touch(Vimmer.bundle_path.join("command-t", "plugins", "command-t.vim"))
      end
    end

    installer.stubs(:path_exists?).returns true

  end
end
