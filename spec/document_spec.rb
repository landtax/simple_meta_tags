require 'spec_helper'

describe SimpleMetaTags::Document do
  let(:document) { SimpleMetaTags::Document.new }
  let(:expected_text) {"<meta name='title' content='my title' />\n" +
                       "<meta property='og:title' content='my title' />"}

  it 'adds single tag properly' do
    expect(document.tags.size).to eq(0)

    document.meta('MobileOptimized', 320)
    document.meta('og:image:type', 'image/jpeg')
    document.meta('og:title', 'my title')

    expect(document.tags.size).to eq(3)
    expect(document.tags.values.last.attributes['property']).to eq("og:title")
    expect(document.tags.values.last.attributes['content']).to eq("my title")
    expect(document.tags.values.first.attributes['name']).to eq("MobileOptimized")
    expect(document.tags.values.first.attributes['content']).to eq(320)
  end

  describe 'renders tags' do
    it 'renders when added 1 by 1' do
      document.meta('MobileOptimized', 320)
      document.meta('og:image:type', 'image/jpeg')
      document.meta('twitter:title', 'my title twitter')
      document.meta('title', 'my title basic')
      document.meta('og:title', 'my title')

      expected_text = "<meta name='MobileOptimized' content='320' />\n" +
        "<meta property='og:image:type' content='image/jpeg' />\n" +
        "<meta name='twitter:title' content='my title twitter' />\n" +
        "<title>my title basic</title>\n" +
        "<meta property='og:title' content='my title' />"

      expect(document.html_tags).to eq(expected_text)
    end

    it 'renders when added in list' do
      document.meta(%w(title og:title), 'my title')

      expected_text = "<title>my title</title>\n" +
        "<meta property='og:title' content='my title' />"

      expect(document.html_tags).to eq(expected_text)
    end
  end

  describe 'Required/optional meta tags' do
    let(:expected_text) {"<meta property='og:image:type' content='image/jpeg' />"}

    it 'raises an error when some tags are missing but doesn\'t when optional' do

      document.require(['og:title', 'og:image:type'])
      document.meta('og:image:type', 'image/jpeg')
      expect{document.html_tags}.to raise_error(SimpleMetaTags::MetaTagMissing)

      document.optional('og:title')
      expect(document.html_tags).to eq(expected_text)

      document.require(['og:title', 'og:image:type'])
      expect{document.html_tags}.to raise_error(SimpleMetaTags::MetaTagMissing)
    end
  end

end
