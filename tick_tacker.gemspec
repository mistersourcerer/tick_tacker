# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require "tick_tacker/version"

Gem::Specification.new do |s|
  s.name        = "tick_tacker"
  s.version     = TickTacker::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ricardo Valeriano"]
  s.email       = ["ricardo@backslashes.net"]
  s.homepage    = "https://github.com/ricardovaleriano/tick_tacker"
  s.summary     = %q{A timer wich accepts subscribers and use a ticker}
  s.description = %q{From time to time, the timer notifies the subscribers}

  s.rubyforge_project = "tick_tacker"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
