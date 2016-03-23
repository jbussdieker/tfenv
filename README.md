# tfenv

Simple gem to manage loading external Terraform module outputs from state files or consul.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tfenv'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tfenv

## Usage

Configuration options:

````
$ tfenv -h
Usage: tfenv [options] [command]
    -s, --state-file FILE            Include external state output from state file
    -c, --consul URL/KEY             Include external state output from consul
    -t, --tfvar FILE                 Write variables to tfvar file
    -v, --[no-]verbose               Run verbosely
````

Examine outputs for given configuration:

````
$ tfenv -s ~/main-module/terraform.tfstate
````

Run terraform (or any other command) using configured outputs:

````
$ tfenv -s ~/main-module/terraform.tfstate terraform plan
````

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jbussdieker/tfenv.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

