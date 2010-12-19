require 'spec_helper'

describe "When loading an installer by URL" do
  include Vimmer

  context "for a Github URL" do

    subject { Installers.for_url("https://github.com/foo/bar.git") }

    it { should == Installers::Github }

  end


  context "for a Vim.org URL" do

    subject { Installers.for_url("http://vim.org/scripts/script.php?script_id=1234") }

    it { should == Installers::VimDotOrg }

  end


  context "for an unrecognized URL" do

    subject { Installers.for_url("http://foo.com/bar") }

    it { lambda { subject }.should raise_error(Vimmer::InstallerNotFoundError) }

  end


end
