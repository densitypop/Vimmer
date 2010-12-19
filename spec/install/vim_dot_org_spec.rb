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

    let(:installer) { VimDotOrg.new(:path => VDO_NOT_FOUND_URL) }

    it { should be_a_valid_url(VDO_NOT_FOUND_URL) }

    specify "the installer should raise an exception" do
      lambda { installer.install }.should raise_error(Vimmer::PluginNotFoundError)
    end

  end


  context "with a malformed URL" do

    it { should_not be_a_valid_url(VDO_MALFORMED_URL) }

  end

  context "with a good URL" do

    let(:installer) { VimDotOrg.new(:path => "http://www.vim.org/scripts/script.php?script_id=2975") }

    specify "the installer should not raise an exception" do
      lambda { installer.install }.should_not raise_error
    end

    specify "the installer calculates the plugin's name" do
      pending
      installer.plugin_name.should == "fugitive.vim"
    end

    specify "provides access to the path" do
      installer.path.should == "http://www.vim.org/scripts/script.php?script_id=2975"
    end

  end

end
