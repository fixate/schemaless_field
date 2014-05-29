# SchemalessField

Basic accessor methods for schemaless ORM fields.
For e.g. a JSON field in Postgres.

## Installation

Add this line to your application's Gemfile:

    gem 'schemaless_field'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install schemaless_field

## Usage

```ruby

class Item < ActiveRecord::Base # Any class with a json string or hash can be used
  after_initialize :set_data

  json_attr :data do
    f.field :color, '$..color' # explicit path (not required)
    f.field :array             # implicit path
    f.field :nested_field      # nested implicit path i.e: $..nested.field

    f.first_thing, '$..things[0]' # explicit path
  end

  private

  def set_data
    self.data ||= {
      color: 'red',
      nested: {
        field: true
      },
      things: [
        {name: 'car'},
        {name: 'laptop'}
      ]
    }
  end

end
```

Now some field accessors will be available

```ruby

  item = Item.new
  item.color #= "red"
  item.color = "blue" # data = { 'color' => 'blue', ... }
  item.nested_field # true
  item.first_thing # "car"
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/schemaless_field/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
