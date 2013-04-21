# Hallon::QueueOutput

An audio driver for Hallon, a ruby client for libspotify. Streams audio into a ruby [Queue][1], allowing your code to work directly with audio samples out of Hallon. One sample is an arrays of signed 16-bit integers, one for each channel.

[1]: http://www.ruby-doc.org/stdlib-2.0/libdoc/thread/rdoc/Queue.html

## Installation

Add this line to your application's Gemfile:

    gem 'hallon-queue-output'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hallon-queue-output

## Usage

Initialize a Hallon player and pass QueueOutput as the driver. Pass a `&block` as the second argument to set queue the driver should push into. (the block runs after Hallon creates the driver, where you would normally establish callbacks):

```ruby
# After loading Hallon and creating a session...

require 'thread'
require 'hallon-queue-output'

my_queue = Queue.new

player = Hallon::Player.new Hallon::QueueOutput, Proc.new do
	@driver.queue = my_queue
end
```