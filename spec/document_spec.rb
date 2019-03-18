require 'spec_helper'

describe SimpleMetaTags::Document do
  let(:document) { SimpleMetaTags::Document.new }

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
      document.meta('og:title', 'my title')

      expected_text = "<meta name='MobileOptimized' content='320' />\n" +
        "<meta property='og:image:type' content='image/jpeg' />\n" +
        "<meta property='og:title' content='my title' />"

      expect(document.html_tags).to eq(expected_text)
    end

    it 'renders when added in list' do
      document.meta(%w(title og:title), 'my title')

      expected_text = "<meta name='title' content='my title' />\n" +
        "<meta property='og:title' content='my title' />"

      expect(document.html_tags).to eq(expected_text)
    end
  end

end
