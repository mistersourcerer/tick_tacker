require 'spec_helper'

def loop_number
  2
end

module TickTacker
  describe Ticker do
    let(:ticker) { Ticker.new }
    let(:ticker_execute) do
      start = Time.now
      x = 0;
      ticker.with :interval => 1.second do 
        ticker.stop if x == loop_number-1
        x += 1
      end
      elapsed = Time.now - start
      {:counter => x, :elapsed => elapsed.round}
    end

    it "should starts with default interval of 1.second" do
      ticker.interval.should == 1.second
    end

    describe "execution loop" do
      it "execute #{loop_number} times in #{loop_number} seconds if the interval is of 1 second" do
        result = ticker_execute
        result[:elapsed].should == loop_number
      end
    end

    describe "#with" do
      it "returns a default ticker" do
        ticker = Ticker.new.with
        ticker.should be_a Ticker
      end
    end

    describe '#stop' do
      it 'stops Ticker loops' do
        result = ticker_execute
        result[:counter].should == loop_number
      end
    end

    describe "#repeat" do
      it "starts loop with default interval" do
        ticker = Ticker.new
        x = 0
        start = Time.now
        ticker.repeat do 
          ticker.stop if x == loop_number-1
          x += 1
        end
        elapsed = Time.now - start
        elapsed.round.should == loop_number
      end
    end

  end
end
