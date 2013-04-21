# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hallon-queue-output/version'

Gem::Specification.new do |gem|
  gem.name          = "hallon-queue-output"
  gem.version       = Hallon::QueueOutput::VERSION
  gem.authors       = ["Elliott Williams"]
  gem.email         = ["e@elliottwillia.ms"]
  gem.description   = <<END  
Stream Spotify via Hallon to ruby Queue for playback or processing in another thread.
END
  gem.summary       = "Stream Spotify via Hallon to ruby Queue for playback or processing in another thread."
  gem.homepage      = "http://github.com/elliottwilliams/hallon-queue-output"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end