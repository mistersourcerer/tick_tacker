$: << "../lib"
require 'tick_tacker'

class Cowntdown
  def initialize
    @timer = TickTacker::Timer.new.with :total_time => 5.seconds
    @timer.add_observer self
    Thread.new {
      @timer.start
    }
    6.times do
      do_nothing
    end
  end

  def do_nothing
    puts "this is the cowntdown doing another things, nothing to be more precisely."
    sleep(1)
  end

  def update(options)
    puts "time remaining: #{options[:time_remaining]}"
  end
end

Cowntdown.new
