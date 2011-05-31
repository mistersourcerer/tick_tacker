require 'spec_helper'

def tick
  2
end

module TickTacker
  describe Timer do
    let(:ticker) { Ticker.new.with :interval => 1.second }
    let(:timer) { Timer.new.with(:ticker => ticker, :total_time => 15.minutes) }
    let(:observer) { double('TimerObserver').as_null_object }

    it 'should be configured with 25 minutes by default' do
      Timer.new.total_time.should == 25.minutes
    end

    it 'should receive a number of minutes as parameter to configure a count down' do
      timer.total_time.should == 15.minutes
    end

    it 'should reduce by 1.second the remaining time when receives an update' do
      timer.update :elapsed_time => 1.second
      timer.elapsed_time.should == 1.second
    end

    it 'should notify the observer about the second elapsed' do
      timer = Timer.new.with :total_time => 1.minute
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

    describe "#start" do
      it "calls Ticker#repeat" do
        tickr = double("Ticker").as_null_object
        t = Timer.new.with :ticker => tickr
        tickr.should_receive(:repeat).once
        t.start
      end
    end

    describe "#stop" do
      it "stops the ticker" do
        tickr = double("Ticker").as_null_object
        t = Timer.new.with :ticker => tickr
        tickr.should_receive(:stop).once
        t.stop
      end
    end
  end
end
