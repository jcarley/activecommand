# ActiveCommand

[![Build Status](https://travis-ci.org/jcarley/activecommand.svg?branch=master)](https://travis-ci.org/jcarley/activecommand)

ActiveCommand adds the ability to use the command pattern commonly seen in CQRS.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activecommand'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activecommand

## Usage

Developing a new command is pretty straight forward.

First create your command.  Perhaps adding it to a commands folder under app, if you are using rails.

    app
      - commands
        - SubmitOrderCommand.rb

Then inherit from the base command class and implement an execute method.  The following example
is assuming the Order is an ActiveRecord model and has a submit? method.

```ruby
class SubmitOrderCommand < ActiveCommand::Command

  attribute :order_id, String

  validates :order_id, presence: true

  def execute
    order = Order.find(order_id)
    if order.submit?
      Emailer.send_order_submitted_notification_for(order)
    else
      raise OrderSubmitError, "Something went wrong submitting the order '#{order_id}'"
    end
  end
end
```

Add the desired implementation to the execute method.  In this case, what ever is needed to submit an order. To
execute the command, instantiate it and execute it using the CommandBus.  The returned value from executing the command
is a CommandResult object.  The CommandResult will tell you if the command was successful or not.

```ruby
submit_order_command = SubmitOrderCommand.new(:order_id => "ABC123")
cr = ActiveCommand::CommandBus.execute(submit_order_command)
if cr.success?
  redirect "/"
else
  render :submit
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jcarley/activecommand. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

