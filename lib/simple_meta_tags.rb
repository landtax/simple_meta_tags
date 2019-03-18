require "simple_meta_tags/version"
require "simple_meta_tags/document"
require "simple_meta_tags/meta_tag"
require "simple_meta_tags/meta_tag_missing"

module SimpleMetaTags



#meta_alias(:titles).add(:title, :og_title, :twitter_title)
#meta_alias(:descriptions).add(:description, :og_description, :twitter_description)
#meta_alias(:images).add(:image, :og_logo, :twitter_image)

#meta :descriptions, 'my description'
#meta :titles, 'my title'
#meta :keywords, %w(a b c d e)
#meta :images, url('/i/og_logo.png')

#meta :og_title, 'my og title'
#meta :og_type, 'website'
#meta :og_url, 'http:/....'

#meta 'X-UA-Compatible', 'IE=edge,chrome=1'
#meta 'HandheldFriendly', 'True'
#meta 'MobileOptimized', 320
#meta 'viewport', 'width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1'
#meta 'format-detection', 'telephone=no, email=no'
#meta 'apple-mobile-web-app-capable', 'no'
#meta 'charset', 'UTF-8'
#meta 'robots', 'noindex,nofollow'

#SimpleMetaTags::MissingAttributeException
#SimpleMetaTags::MissingLanguageException

#def initialize_page_meta
  #@page_meta = PageMeta.new
  #@page_meta.require_attributes(:description, :title, ....)
  #@page_meta.require_languages(:en, :fr)
  #@page_meta.optional_languages(:fr)
  #@page_meta.optional_attributes('charset')
#end

#def meta(options=nil)
  #initialize_meta if @page_meta.nil?
  #if options
    #@page_meta.meta(options)
  #else
    #@page_meta
  #end
#end

#def meta_html_tags
  #meta.html_tags
#end

#def meta_optional attributes
  #meta.optional_attributes(attributes)
#end

#def canonical_url url
  #meta.canonical_url url
#end

#def alternative_url url
  #meta.alternative_url url
#end

#get 'aaa' do
  #meta_optional(:alternative_url)
  #meta :titles 'my new title for aaaa'
  #canonical_url url('...')
  #alternative_url en: url('...')

  #if experiment_id == 1
    #meta :twitter_title, 'my new title for aaa in twitter'
  #end


#end




#= meta_html_tags

    

  #end
end
