require 'spec_helper'

describe SimpleMetaTags::MetaTag::Generic do
  let(:tag) { SimpleMetaTags::MetaTag::Generic.build('referrer', 'unsafe-url') }

  it 'builds the tag' do
    tag = SimpleMetaTags::MetaTag::Generic.build('referrer', 'unsafe-url')
    expect(tag.attributes).to eq({'name' => 'referrer', 'content' => 'unsafe-url'})
  end

  it 'renders properly' do
    tag = SimpleMetaTags::MetaTag::Generic.build('referrer', 'unsafe-url')
    html = "<meta name='referrer' content='unsafe-url' />"
    expect(tag.to_html).to eq(html)
  end
end
