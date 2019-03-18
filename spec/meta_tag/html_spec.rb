require 'spec_helper'

describe SimpleMetaTags::MetaTag::Html do
  let(:tag) { SimpleMetaTags::MetaTag::Html.build('title', 'my title') }

  it 'builds the tag' do
    tag = SimpleMetaTags::MetaTag::Html.build('title', 'my title')
    expect(tag.attributes).to eq({'name' => 'title', 'content' => 'my title'})
  end

  it 'renders properly' do
    tag = SimpleMetaTags::MetaTag::Html.build('title', 'my title')
    html = "<title>my title</title>"
    expect(tag.to_html).to eq(html)
  end
end
