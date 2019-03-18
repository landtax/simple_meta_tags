require 'spec_helper'

describe SimpleMetaTags::MetaTag::LinkRel do
  let(:tag) { SimpleMetaTags::MetaTag::LinkRel.build('canonical', 'http://google.com') }

  it 'builds the tag' do
    tag = SimpleMetaTags::MetaTag::LinkRel.build('canonical', 'http://google.com')
    expect(tag.attributes).to eq({'rel' => 'canonical', 'href' => 'http://google.com'})
  end

  it 'renders properly' do
    tag = SimpleMetaTags::MetaTag::LinkRel.build('canonical', 'http://google.com')
    html = "<link rel='canonical' href='http://google.com' />"
    expect(tag.to_html).to eq(html)
  end
end
