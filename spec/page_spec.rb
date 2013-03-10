require 'rspec'
require 'gitki/page'


describe Gitki::Page do

  let(:page) { Gitki::Page.new(File.expand_path("./test/test_wiki/tools/misc.md")) }

  context "metadata" do
    describe ".metadata" do
      it "store file meatda in a hash" do
        page.metadata.class.should == Hash
      end
    end

    describe "set metdatadat value" do
      it "should set tha metada[key value]" do
        page[:my_data] = "value"
        page.metadata[:my_data].should == "value"
      end
    end

    describe "can be acces with a method on th instance level" do
      it "return the metadata[method]  value" do
        page[:my_data] = "value"
        page.my_data.should == "value"
      end
   end

  end
end


