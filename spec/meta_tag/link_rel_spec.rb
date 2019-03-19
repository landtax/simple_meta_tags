require 'spec_helper'

describe SimpleMetaTags::MetaTag::LinkRel do
  let(:tag) { SimpleMetaTags::MetaTag::LinkRel.build('rel:canonical', 'http://google.com') }

  it 'builds the tag' do
    tag = SimpleMetaTags::MetaTag::LinkRel.build('rel:canonical', 'http://google.com')
    expect(tag.attributes).to eq({'href' => 'http://google.com'})
  end

  it 'renders properly' do
    tag = SimpleMetaTags::MetaTag::LinkRel.build('rel:canonical', 'http://google.com')
    html = "<link rel='canonical' href='http://google.com' />"
    expect(tag.to_html).to eq(html)
  end

  context 'alternate tag with several languages' do

    it 'builds the tag' do
      tag = SimpleMetaTags::MetaTag::LinkRel.build('rel:alternate:es', 'http://google.com')
      expect(tag.attributes).to eq({'href' => 'http://google.com', 'hreflang' => 'es'})
    end

    it 'renders 1 properly' do
      tag = SimpleMetaTags::MetaTag::LinkRel.build('rel:alternate:es', 'http://google.com')
      html = "<link rel='alternate' hreflang='es' href='http://google.com' />"
      expect(tag.to_html).to eq(html)
    end

    it 'renders 1 properly' do
      tag = SimpleMetaTags::MetaTag::LinkRel.build('rel:alternate:es', 'http://google.com')
      html = "<link rel='alternate' hreflang='es' href='http://google.com' />"
      expect(tag.to_html).to eq(html)
    end

  end
end
