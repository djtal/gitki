require "rspec"
require "gitki/rugged_backend"

describe Gitki::RuggedBackend do
  let(:backend) { Gitki::RuggedBackend.new(File.expand_path("test/test_repo")) }

  it "should retrieve last sha of a given file" do
    expected = { "41fb9a11afd776a74655436faa2dd8d48fee610d" => "wiki creation\n" }
    backend.revision("file1.md").should == expected
  end

  it "it should get the last modified sha of a repo" do
    expected = { "860cced4c88b9d4170dd4919f453667681914a6d" => "add file 2, 3, 4\n" }
    backend.last_revision.should == expected
  end

  it "should list all files of a repo" do
    expected = %w(file1.md file2.md file3.md file4.md)
    backend.files.should == expected
  end

  it "should retriece all commit of a given file" do
    expected = {
      "babc5980334f21d4305f0a84b4dce6447d1d6fef" => "wiki creation",
      "9917b30be2b8b1d4d96b5cc72e6e0f5430ff7f50" => "file1 content"
    }
    backend.history(File.expand_path("./test/test_wiki/regexp.md")).should == expected
  end
end
