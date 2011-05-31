module TickTacker
  class Ticker
    def initialize
      @can_run = true
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
  end
end
