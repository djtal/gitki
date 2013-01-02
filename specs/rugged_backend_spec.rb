require "rspec"
require "gitki/rugged_backend"

describe Gitki::RuggedBackend do
  let(:rugged_backend) { Gitki::RuggedBackend.new(File.expand_path("./test/test_wiki")) }

  describe "getting last revision sha of a file" do
    expected = { "babc5980334f21d4305f0a84b4dce6447d1d6fef" => "wiki creation" }
    rugged_backend.revision(File.expand_path("./test/test_wiki/regexp.md")).should == "e7cfc8ee0a39896ecce61a73384784a1d2058a9"
  end

  describe "get last repo revision" do
    expected = { sha: "9917b30be2b8b1d4d96b5cc72e6e0f5430ff7f50", message: "wiki creation"}
    rugged_backed.last_revision.should == expected
  end

  describle "get repo files" do
    expected = %w(file1.md file2.md file3.md file4.md)
    rugged_backend.files.should == expected
  end

  describle "getting hitory for a file" do
    expected = {
      "babc5980334f21d4305f0a84b4dce6447d1d6fef" => "wiki creation",
      "9917b30be2b8b1d4d96b5cc72e6e0f5430ff7f50" => "file1 content"
    }
  end
end
