# Slevomat (Zboží) API Ruby Library

This library connects your web app with Slevomat zboží. Code was written with inspiration in [PHP library](https://github.com/slevomat/zbozi-api-php-library) and according to [Slevomat documentation](https://www.slevomat.cz/partner/zbozi-api).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'slevomat_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install slevomat_api

## Usage

Create client object which will create requests to Slevomat.

    client = SlevomatApi::Client.new(partner_token, api_secret, api_url, version, test)

Param version is for example `v1` and test should be `true` for testing and `false` (by default) for production.

Now we can send requests. Request are from section Partner => Slevomat:

Cancel order:

    items = []
    items << { 'slevomatId': '45454', 'amount': 1 }
    client.cancel_order('585551136396', items, 'Because I can!')

Mark order as pending:

    client.mark_pending('585551136396')
    
Mark order as on the road:

    client.mark_en_route('585551136396', true)
    
Mark order as ready to be picked up on pick-up point:

    client.mark_getting_ready_for_pickup('585551136396', true, true)
    
Mark order as ready for pickup:

    client.mark_ready_for_pickup('585551136396', true)
    
Mark order as delivered to customer:

    client.mark_delivered('585551136396')
    
Updates order's shipping address:

    client.update_shipping_address('585551136396', 'John Snow', 'Winter street 11', 'Winterfel', 'cz', '777123456', '44233', 'Kingslanding s.r.o.')

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/slevomat_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

Sponsored by [Mixit.cz](https://www.mixit.cz).
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).