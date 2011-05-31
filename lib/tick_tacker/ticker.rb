module TickTacker
  class Ticker
    attr_accessor :interval

    def initialize
      @can_run = true
      with :interval => 1.second
    end

    def with(options={})
      default = {:interval => 1.second}
      config = default.merge(options)
      @interval = config[:interval]
      repeat_every(@interval) { yield } if block_given?
      self
    end

    def time_block 
      start_time = Time.now 
      Thread.new { yield } 
      Time.now - start_time 
    end 

    def repeat_every(seconds)
      while @can_run do 
        time_spent = time_block { yield } # To handle -ve sleep interaval 
        sleep(seconds - time_spent) if time_spent < seconds 
      end
    end

    def stop
      @can_run = false
    end

    def repeat
      repeat_every(@interval) { yield }
    end
  end
end
