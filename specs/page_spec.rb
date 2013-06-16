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

    context "any page" do
     describle "file_page_name" do
        it "should be the page title.html if title is given" do
          page.title = "an awsome page to read"
          page.file_page_name.should == "an_awesome_page_to_read.html"

        end

        it "should be the filename extension exetion plus html if no title is given" do
          page.title = nil
          page.file = "some_awesome_tools.md"
          page.file_page_name.should == "some_awesome_tools.html"
        end
      end

    end

  end
end


