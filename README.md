MoceanAPI Client Library for Ruby 
============================

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
require "moceanapi/init"

token = Client.new("API_KEY_HERE", "API_SECRET_HERE")
mocean = Mocean.new(token)
```

## Example

To use [Mocean's SMS API][doc_sms] to send an SMS message, call the `mocean.sms.create().send()` method.

The API can be called directly, using a simple array of parameters, the keys match the [parameters of the API][doc_sms].

```ruby
res = mocean.sms.create({
	"mocean-text"=>'Hello World',
    "mocean-from"=>'MOCEAN',
    "mocean-to"=>'60123456789'
    }).send()

puts res
```

## License

This library is released under the [MIT License][license]

[signup]: https://dashboard.moceanapi.com/register?medium=github&campaign=sdk-ruby
[doc_sms]: https://docs.moceanapi.com/?ruby#send-sms
[doc_inbound]: https://docs.moceanapi.com/?ruby#receive-sms
[doc_verify]: https://docs.moceanapi.com/?ruby#overview-3
[license]: LICENSE.txt