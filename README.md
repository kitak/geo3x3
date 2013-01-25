# Geo3x3

geo zone encoding

## Installation

Add this line to your application's Gemfile:

    gem 'geo3x3'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install geo3x3

## Usage

```ruby
require 'geo3x3'

code = Geo3x3.encode({
  lat: 36.208823,
  lng: 138.251953,
  level: 5
}) # => "E3793" 

Geo3x3.decode(code)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
