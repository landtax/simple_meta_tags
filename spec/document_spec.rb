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
      document.meta('refresh', 10)
      document.meta('rel:canonical', 'http://google.com')
      document.meta('og:title', 'my title')

      expected_text = "<meta name='MobileOptimized' content='320' />\n" +
        "<meta property='og:image:type' content='image/jpeg' />\n" +
        "<meta name='twitter:title' content='my title twitter' />\n" +
        "<title>my title basic</title>\n" +
        "<meta http-equiv='refresh' content='10' />\n" +
        "<link rel='canonical' href='http://google.com' />\n" +
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

  context 'many rel:alternate tags' do
    it 'renders it properly' do
      document.meta('rel:canonical', 'http://google.com')
      document.meta('rel:alternate:es', 'http://google.com/es')
      document.meta('rel:alternate:en', 'http://google.com/en')
      document.meta('rel:alternate:fr', 'http://google.com/fr')
      document.meta('og:title', 'my title')

      expected_text = "<link rel='canonical' href='http://google.com' />\n" +
        "<link rel='alternate' hreflang='es' href='http://google.com/es' />\n" +
        "<link rel='alternate' hreflang='en' href='http://google.com/en' />\n" +
        "<link rel='alternate' hreflang='fr' href='http://google.com/fr' />\n" +
        "<meta property='og:title' content='my title' />"

      expect(document.html_tags).to eq(expected_text)
    end
  end

  describe 'Required/optional meta tags' do
    let(:expected_text) {"<meta property='og:image:type' content='image/jpeg' />\n" +
                         "<link rel='canonical' href='http://google.com' />"}

    it 'raises an error when some tags are missing but doesn\'t when optional' do

      document.require(['og:title', 'og:image:type'])
      document.require('rel:canonical')
      document.meta('og:image:type', 'image/jpeg')
      expect{document.html_tags}.to raise_error(SimpleMetaTags::MetaTagMissing)

      document.optional('og:title')
      document.meta('rel:canonical', 'http://google.com')
      expect(document.html_tags).to eq(expected_text)

      document.require(['og:title', 'og:image:type'])
      expect{document.html_tags}.to raise_error(SimpleMetaTags::MetaTagMissing)
    end
  end

end
