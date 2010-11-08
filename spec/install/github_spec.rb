require 'spec_helper'

describe "When installing from Github" do
  include Vimmer::Installers

  context "with a non-existant URL" do

    let(:installer) { Github.new("https://github.com/tpope/not-found") }

    specify "the installer should raise an exception" do
      lambda { installer.install }.should raise_error("Not found")
    end

  end

  context "with a good URL" do

    let(:installer) { Github.new("https://github.com/tpope/vim-awesomemofo") }

    specify "the installer should not raise an exception" do
      lambda { installer.install }.should_not raise_error
    end

  end


  it "provides access to the path" do
    Github.new("https://github.com/tpope/vim-awesomemofo").
      path.should == "https://github.com/tpope/vim-awesomemofo"

  end


end
