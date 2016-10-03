class Oystercard

  attr_reader :balance
  MAXIMUM_BALANCE = 90

  def initialize(balance = 5)
    @balance = balance
  end

  def top_up(amount)
    raise("Maximum balance is £#{MAXIMUM_BALANCE}") if (@balance + amount) >= MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end
end
