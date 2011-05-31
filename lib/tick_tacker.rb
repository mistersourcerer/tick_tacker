require 'tick_tacker/timer'
require 'tick_tacker/ticker'

class Fixnum
  def minutes
    self * 60
  end

  def minute
    self.minutes
  end

  def seconds
    self
  end

  def second
    self.seconds
  end
end
