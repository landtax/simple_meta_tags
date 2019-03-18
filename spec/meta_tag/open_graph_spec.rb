require 'spec_helper'

describe SimpleMetaTags::MetaTag::OpenGraph do
  let(:tag) { SimpleMetaTags::MetaTag::OpenGraph.build('og:title', 'my title') }

  it 'builds the tag' do
    expect(tag.attributes).to eq({'property' => 'og:title', 'content' => 'my title'})
  end

  it 'renders properly' do
    html = "<meta property='og:title' content='my title' />"
    expect(tag.to_html).to eq(html)
  end

  context 'is not a valid meta_id' do
    let(:tag) { SimpleMetaTags::MetaTag::OpenGraph.build('og_title', 'my title') }

    it 'doesn\'t build the tag if it is not open graph' do
      expect(tag).to be_nil
    end
  end
end
