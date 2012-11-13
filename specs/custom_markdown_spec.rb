require 'rspec'
require 'redcarpet'
require 'gitki/renderers/full/custom_markdown'


describe Gitki::Renderer::CustomMarkdown do

  let(:custom_renderer) { Redcarpet::Markdown.new(Gitki::Renderer::CustomMarkdown.new(:with_toc_data => true)) }

  it "should render emojis" do
    doc = ":eyes:"
    expected  =  "<p><img class='emoji' src='assets/eyes.png' width='20' alt=':eyes:'></img></p>\n"
    custom_renderer.render(doc).to_s.should == expected
  end

  it "should render inter page link" do
    doc = "see [[this-awesome-page]] for more details on that topic"
    expected = "<p>see <a href=\"this-awesome-page.html\">this-awesome-page</a> for more details on that topic</p>\n"
    custom_renderer.render(doc).to_s.should == expected
  end

end


