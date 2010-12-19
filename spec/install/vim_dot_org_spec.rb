require 'spec_helper'

include Vimmer::Installers

describe "When installing from vim.org" do

  VDO_NOT_FOUND_URL = "http://www.vim.org/scripts/script.php?script_id=0000"
  VDO_MALFORMED_URL = "https://foo.com/bar"

  RSpec::Matchers.define :be_a_valid_url do |expected|
    match do
      VimDotOrg.match?(expected) == true
    end
  end

  context "with a non-existent URL" do

    before do
      VimDotOrg.stubs(:repository).returns({})
    end

    it { should be_a_valid_url(VDO_NOT_FOUND_URL) }

    specify "the installer should raise an exception" do
      lambda { VimDotOrg.for_url(VDO_NOT_FOUND_URL) }.should raise_error(Vimmer::PluginNotFoundError)
    end

  end


  context "with a malformed URL" do

    it { should_not be_a_valid_url(VDO_MALFORMED_URL) }

  end

  context "with a good URL" do

    before do
      VimDotOrg.stubs(:repository).returns({"2975" => "fugitive.vim"})
    end

    let(:installer) { VimDotOrg.for_url("http://www.vim.org/scripts/script.php?script_id=2975") }

    context "using the vim-scripts mirror" do

      it "should return a Github installer" do
        installer.should be_a(Github)
      end

      it "uses the Github path" do
        installer.path.should == "https://github.com/vim-scripts/fugitive.vim.git"
      end

    end

    specify "the installer should not raise an exception" do

      class << installer
        def git_clone(arg1, arg2)
        end
      end

      lambda { installer.install }.should_not raise_error
    end

    specify "the installer calculates the plugin's name" do
      installer.plugin_name.should == "fugitive.vim"
    end

  end

end
