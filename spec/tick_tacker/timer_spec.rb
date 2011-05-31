require 'spec_helper'

module TickTacker
  describe Timer do
    let(:timer) { Timer.new :with => 15.minutes }
    let(:observer) { double('TimerObserver').as_null_object }

    it 'should be configured with 25 minutes by default' do
      Timer.new.total_minutes.should == 25.minutes
    end

    it 'should have a default ticker configured with 1.second' do
      timer.ticker_time.should == 1.second
    end

    it 'should receive a number of minutes as parameter to configure a count down' do
      timer.total_minutes.should == 15.minutes
    end

    it 'should reduce by one second the remaining time when receives an update' do
      timer.update :elapsed_time => 1.second
      timer.elapsed_time.should == 1.second
    end

    it 'should notify the observer about the second elapsed' do
      timer = Timer.new :with => 1.minutes
      timer.add_observer observer
      observer.should_receive(:update).with({:time_remaining => 59.seconds}).once
      timer.update :elapsed_time => 1.second
    end

    it 'should notify an observer when the time is over' do
      timer.add_observer observer
      timer.elapsed_time = 14.minutes
      observer.should_receive(:update).with({:time_remaining => 0}).once
      60.times do
        timer.update :elapsed_time => 1.second
      end
    end
  end
end
