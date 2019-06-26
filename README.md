MoceanAPI Client Library for Ruby 
============================
[![Gem Version](https://img.shields.io/gem/v/moceansdk.svg)](https://rubygems.org/gems/moceansdk) 
[![build status](https://img.shields.io/travis/com/MoceanAPI/mocean-sdk-ruby.svg)](https://travis-ci.com/MoceanAPI/mocean-sdk-ruby)
[![codecov](https://img.shields.io/codecov/c/github/MoceanAPI/mocean-sdk-ruby.svg)](https://codecov.io/gh/MoceanAPI/mocean-sdk-ruby)
[![codacy](https://img.shields.io/codacy/grade/7564ecfa8e7948a7ba15cb7634258c7e.svg)](https://app.codacy.com/project/MoceanAPI/mocean-sdk-ruby/dashboard)
[![MIT license](http://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT)
[![total downloads](https://img.shields.io/gem/dt/moceansdk.svg)](https://rubygems.org/gems/moceansdk)

This is the Ruby client library for use Mocean's API. To use this, you'll need a Mocean account. Sign up [for free at 
moceanapi.com][signup].

 * [Installation](#installation)
 * [Usage](#usage)
 * [Example](#example)

## Installation

To use the client library you'll need to have [created a Mocean account][signup]. 

To install the Ruby client library using Gem.

```bash
gem install moceansdk
```

## Usage

Create a client with your API key and secret:

```ruby
require 'moceansdk'

credential = Moceansdk::Auth::Basic.new("API_KEY_HERE", "API_SECRET_HERE")
mocean = Moceansdk::Client.new(credential)
```

## Example

To use [Mocean's SMS API][doc_sms] to send an SMS message, call the `mocean.sms.send()` method.

The API can be called directly, using a simple array of parameters, the keys match the [parameters of the API][doc_sms].

```ruby
res = mocean.sms.send({
    "mocean-text": 'Hello World',
    "mocean-from": 'MOCEAN',
    "mocean-to": '60123456789'
})

puts res
```

### Responses

For your convenient, the API response has been parsed to `Hash` using [hash_dot](https://github.com/adsteel/hash_dot) package.
```ruby
puts res           # show full response string
puts res.status    # show response status, '0' in this case
puts res['status'] # same as above
```

## Documentation

Kindly visit [MoceanApi Docs][doc_main] for more usage

## License

This library is released under the [MIT License][license]

[signup]: https://dashboard.moceanapi.com/register?medium=github&campaign=sdk-ruby
[doc_main]: https://moceanapi.com/docs/?ruby
[doc_sms]: https://moceanapi.com/docs/?ruby#send-sms
[license]: LICENSE.txt
