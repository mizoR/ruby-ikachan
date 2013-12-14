# Ikachan

Send message vi Ikachan

## Installation

Add this line to your application's Gemfile:

    gem 'ikachan', :github => 'mizoR/ruby-ikachan'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install 'git@github.com:mizoR/ruby-ikachan.git'

## Usage

```ruby
require 'ikachan'

client = Ikachan::Client.new(:hostname => 'irc.example.com')
client.to('#ruby').notify('No Ruby No Life')
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
