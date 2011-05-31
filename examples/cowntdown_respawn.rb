$: << "../lib"
require 'tick_tacker'

class Cowntdown
  def timer
    @timer = TickTacker::Timer.new.with :total_time => 5.seconds
    @timer.add_observer self
  end

  def update(options)
    @time_remaining = options[:time_remaining]
    @respawn = true if options[:time_remaining] == 0
  end

  def forever
    timer
    Thread.new {
      @timer.start
    }
    while true
      puts "."
      puts "remaining: #{@time_remaining}"
      sleep(0.3)
      if @respawn
        @respawn = false
        respawn
      end
    end
  end

  def respawn
    @timer.stop
    timer
    puts "respawning..."
    Thread.new {
      @timer.start
    }
  end
end

Cowntdown.new.forever
