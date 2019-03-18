require 'spec_helper'

describe SimpleMetaTags::MetaTag::Twitter do
  let(:tag) { SimpleMetaTags::MetaTag::Twitter.build('twitter:title', 'my title') }

  it 'builds the tag' do
    expect(tag.attributes).to eq({'name' => 'twitter:title', 'content' => 'my title'})
  end

  it 'renders properly' do
    html = "<meta name='twitter:title' content='my title' />"
    expect(tag.to_html).to eq(html)
  end

  context 'is not a valid meta_id' do
    let(:tag) { SimpleMetaTags::MetaTag::Twitter.build('twitter_title', 'my title') }

    it 'doesn\'t build the tag if it is not open graph' do
      expect(tag).to be_nil
    end
  end
end
