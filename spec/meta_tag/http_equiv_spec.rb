require 'spec_helper'

describe SimpleMetaTags::MetaTag::HttpEquiv do
  let(:tag) { SimpleMetaTags::MetaTag::HttpEquiv.build('refresh', 30) }

  it 'builds the tag' do
    expect(tag.attributes).to eq({'http-equiv' => 'refresh', 'content' => 30})
  end

  it 'renders properly' do
    html = "<meta http-equiv='refresh' content='30' />"
    expect(tag.to_html).to eq(html)
  end

  context 'is not a valid meta_id' do
    let(:tag) { SimpleMetaTags::MetaTag::HttpEquiv.build('og:refresh', 30) }

    it 'doesn\'t build the tag if it is not open graph' do
      expect(tag).to be_nil
    end
  end
end
