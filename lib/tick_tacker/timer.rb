require 'observer'

module TickTacker
  class Timer
    include Observable

    attr_reader :total_minutes, :ticker_time
    attr_accessor :elapsed_time

    def initialize(options = {:with => 25.minutes})
      @total_minutes = options[:with]
      @ticker_time = 1.second
      @ticker = Ticker.new
    end

    def notify
      time_remaining = total_minutes - elapsed_time
      notification_options = {:time_remaining => time_remaining}
      notify_observers(notification_options)
    end

    def update_time_elapsed(time)
      @elapsed_time += time
      if @elapsed_time >= @total_minutes
        @ticker.stop
      end
    end

    def update(options)
      @elapsed_time ||= 0
      options[:time_elapsed] = 1 if options[:time_elapsed].nil?
      update_time_elapsed(options[:time_elapsed])
      changed
      notify
    end

    def start
      @ticker.repeat_every 1.second do 
        self.update({})
      end
    end

    def stop
      @ticker.stop
    end
  end
end
