require 'observer'

module TickTacker
  class Timer
    include Observable

    attr_reader :total_time
    attr_accessor :elapsed_time

    def initialize
      with(:total_time => 25.minutes)
    end

    def with(options)
      default = {:ticker => Ticker.new}
      config = default.merge(options)
      @ticker = config[:ticker]
      @ticker_time = @ticker.interval
      @total_time = config[:total_time]
      self
    end

    def notify
      time_remaining = total_time - elapsed_time
      notification_options = {:time_remaining => time_remaining}
      notify_observers(notification_options)
    end

    def update_time_elapsed(time)
      @elapsed_time += time
      if @elapsed_time >= @total_time
        @ticker.stop
      end
    end

    def update(options = {})
      @elapsed_time ||= 0
      default = {:time_elapsed => @ticker.interval}
      config = default.merge(options)
      update_time_elapsed(config[:time_elapsed])
      changed
      notify
    end

    def start
      @ticker.repeat do
        self.update
      end
    end

    def stop
      @ticker.stop
    end
  end
end
