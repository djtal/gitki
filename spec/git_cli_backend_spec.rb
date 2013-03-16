require "rspec"
require "gitki/git_cli_backend"

describe Gitki::GitCliBackend do
  let(:backend) { Gitki::GitCliBackend.new(File.expand_path("test/test_repo")) }

  it "should retrieve last sha of a given file" do
    expected = { "58832619e7af65c6fbb563793653e6df5e7566ed" => "file1 content" }
    backend.revision("file1.md").should == expected
  end

  it "it should get the last modified sha of a repo" do
    expected = { "58832619e7af65c6fbb563793653e6df5e7566ed" => "file1 content" }
    backend.last_revision.should == expected
  end

  it "should list all files of a repo" do
    expected = %w(file1.md file2.md file3.md file4.md)
    backend.files.should == expected
  end

  it "should retriece all commit of a given file" do
    expected = {
      "58832619e7af65c6fbb563793653e6df5e7566ed" => "file1 content",
      "41fb9a11afd776a74655436faa2dd8d48fee610d" => "wiki creation",
    }
    backend.history("file1.md").should == expected
  end

  context "reading file content" do

    it "should read file at the given sha" do
      backend.file("file1.md", "41fb9a11afd776a74655436faa2dd8d48fee610d").should == ""
    end

    it "should read file content if no revision given" do
      backend.file("file1.md").should == "awesome content\n"
    end
  end
end
