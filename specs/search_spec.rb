require 'rspec'
require "gitki/search_index"


describe Gitki::SearchIndex do

  context "building an index" do

    describe "a fresh index" do
      it  "should be an empty Hash" do
        search = Gitki::SearchIndex.new
        search.index.should == {}
      end
    end

    describe "adding a page to the index" do
      it "should reference each word for the page" do
        search = Gitki::SearchIndex.new
        search.add_page_to_index "my_page", "roses are blue"
        search.index["roses"].should == ["my_page"]
      end
    end
  end

end
