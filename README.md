# SimpleMetaTags

SimpleMetaTags attemps to make HTML metadata management keeping it simple.

## Motivation

HTML metadata inside routes or controllers is a mess. There are
some gems that tackle the problem but I found them too complex.

At the same time, I missed the ability to add some extra semantics like required tags as validation system or aliases to identify which data is copied over as default.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple_meta_tags'
```

## Usage


It's used like this:

```
  @doc = SimpleMetaTags::Document.new

  @doc.meta('title', 'My Website title')
  @doc.meta('description', 'My Website description')


  @doc.html_tags

  # <title> Another title for my website </title>
  # <meta name="description" content="My Website description" />

```


## Features

### Validation

Set validation requirements and trigger exceptions when metadata is
missing.

```
  @doc = SimpleMetaTags::Document.new

  @doc.require('title')
  @doc.html_tags

  # => raises SimpleMetaTags::MetaTagMissing

  @doc.meta('title', 'My Website title')

  @doc.html_tags

  # <title> Another title for my website </title>

```

This is specially handy for sending error information to Sentry, Rollbar or
any other error tracking system.

### Lazy generation

Tags are generated only when requested so can be updated many times through the request.

```
  @doc = SimpleMetaTags::Document.new
  @doc.meta('title', 'My Website title')
  @doc.meta('title', 'Another title for my website')

  @doc.html_tags

  # <title> Another title for my website </title>

```

### Aliases (under development)
Use multiple times the same content in several tags with aliases.
Aliases use aliased content. When aliased content changes, all aliases
are affected and reflect the new content


```
  @doc = SimpleMetaTags::Document.new
  @doc.alias('titles', ['title', 'og:title'])
  @doc.meta('titles', 'My Website title')

  @doc.html_tags

  # <title>My Website title</title>
  # <meta property='og:title' content='My Website title' />

  @doc.meta('title', 'Another title for my website')
  @doc.html_tags

  # <title> Another title for my website </title>
  # <meta property='og:title' content='Another title for my website' />

  @doc.alias('titles').remove(['og:title'])
  @doc.html_tags

  # <title> Another title for my website </title>
```

## Supported metadata

### Open Graph

Use the prefix `og:` when setting Open Graph metadata.

```
  @doc = SimpleMetaTags::Document.new
  @doc.meta('og:title', 'My title')
  @doc.meta('og:description', 'My description')

  @doc.html_tags

  # <meta property='og:title' content='My title' />
  # <meta property='og:description' content='My description' />

```
All metadata starting with `og:` prefix will be displayed as Open Graph

### Twitter

Use the prefix `twitter:` when setting Twitter metadata.

```
  @doc = SimpleMetaTags::Document.new
  @doc.meta('twitter:title', 'My title')
  @doc.meta('twitter:description', 'My description')

  @doc.html_tags

  # <meta name='twitter:title' content='My title' />
  # <meta name='twitter:description' content='My description' />

```

All metadata starting with `twitter:` prefix will be displayed as
Twitter `meta` with `name` and `content` attributes

### Related links

For simplicity we use some conventions:

* `rel:canonical` for canonical links
* `rel:alternate:lang` for language alternate links
* `rel:next` or `rel:prev` for pagination links


```
  @doc = SimpleMetaTags::Document.new

  @doc.meta('rel:canonical', 'http://mywebsite.com')
  @doc.meta('rel:alternate:ca', 'http://mywebsite.com/ca')

  @doc.html_tags

  # <link rel='canonical' href='http://mywebsite.com' />
  # <link rel='alternate' hreflang='ca' href='http://mywebsite.com/ca' />

```

### HTTP-EQUIV

Supported types:

* `X-UA-Compatible`
* `content-type`
* `default-style`
* `refresh`

More types can be added. Please, create a PR if you need any.


```
  @doc = SimpleMetaTags::Document.new

  @doc.meta('refresh', 30)

  @doc.html_tags

  # <meta http-equiv='refresh' content='30' />

```

### Other metadata

Any other metadata not mathing the previous sections will fall into this
category and displayed as `meta` tag

```

  @doc = SimpleMetaTags::Document.new

  @doc.meta('referrer', 'unsafe-url')
  @doc.meta('robots', 'noindex,nofollow')
  @doc.meta('viewport', 'width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1')

  @doc.html_tags

  # <meta name='referrer' content='unsafe-url' />
  # <meta name='robots' content='noindex,nofollow' />
  # <meta name='viewport' content='width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1' />

```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/simple_meta_tags. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

