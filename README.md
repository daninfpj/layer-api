# Layer::Api
[![Build Status](https://travis-ci.org/cakejelly/layer-api.svg?branch=master)](https://travis-ci.org/cakejelly/layer-api) [![Gem Version](https://badge.fury.io/rb/layer-api.svg)](http://badge.fury.io/rb/layer-api)

A very simple wrapper for the Layer Platform API.

If you want to learn more, check out the [official documentation](https://developer.layer.com/docs/platform).

See [here](https://github.com/cakejelly/ruby-platform-implementation) for a sample API implementation using this gem and [Grape](https://github.com/intridea/grape)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'layer-api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install layer-api

## Usage

### Authentication/setup

```ruby
layer = Layer::Api::Client.new(
  api_token: "your_api_token",
  app_id: "your_app_id"
)
```
If you have `ENV['LAYER_API_TOKEN']` and `ENV['LAYER_APP_ID']` environment variables setup, they will be used by default don't need to be included:
```ruby
layer = Layer::Api::Client.new
```

### Retrieving conversations

```ruby
layer.get_conversation("conversation_id")
```

### Creating conversations

```ruby
# A sample conversation
conversation = {
  participants: [
    "1234",
    "5678"
  ],
  distinct: false,
  metadata: {
    background_color: "#3c3c3c"
  }
}

layer.create_conversation(conversation)
```

### Editing conversations

```ruby
# Sample edit operations
operations = [
  {operation: "add", property: "participants", value: "user1"},
  {operation: "add", property: "participants", value: "user2"}
]

layer.edit_conversation("conversation_id", operations)
```

### Delete conversations

```ruby
layer.delete_conversation("conversation_id")
```

### Sending messages
```ruby
# A sample message to send
message = {
  sender: {
    name: "t-bone"
  },
  parts: [
    {
        body: "Hello, World!",
        mime_type: "text/plain"
    },
    {
        body: "YW55IGNhcm5hbCBwbGVhc3VyZQ==",
        mime_type: "image/jpeg",
        encoding: "base64"
    }
  ],
  notification: {
    text: "This is the alert text to include with the Push Notification.",
    sound: "chime.aiff"
  }
}

layer.send_message("conversation_id", message)

```

### Get messages

```ruby
# Get messages from a conversation
layer.get_messages("conversation_id")
```

### Get message

```ruby
# Get a message from a conversation
layer.get_message("conversation_id", "message_id")
```

### Sending Announcements

```ruby
# A sample announcement
announcement = {
  recipients: [ "1234", "5678" ],
  sender: {
    name: "The System"
  },
  parts: [
    {
        body: "Hello, World!",
        mime_type: "text/plain"
    },
    {
        body: "YW55IGNhcm5hbCBwbGVhc3VyZQ==",
        mime_type: "image/jpeg",
        encoding: "base64"
    }
  ],
  notification: {
    text: "This is the alert text to include with the Push Notification.",
    sound: "chime.aiff"
  }
}

layer.send_announcement(announcement)
```

### Managing User Block Lists

```ruby
# Retrieves a users blocklist
layer.get_blocklist("user_id")

# Adds a user to another users blocklist
layer.block_user("owner_id", "user_id")

# Removes a user from another users blocklist
layer.unblock_user("owner_id", "user_id")
```

### Generating Identity Tokens
See: [the official authentication guide](https://developer.layer.com/docs/android/guides#authentication)

Make sure the following environment variables are set:
`ENV['LAYER_KEY_ID']`
`ENV['LAYER_PROVIDER_ID']`
`ENV['LAYER_PRIVATE_KEY']`

```ruby
# Returns a valid signed identity token.
layer.generate_identity_token(user_id: "1234", nonce: "your_random_nonce")
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cakejelly/layer-api.
