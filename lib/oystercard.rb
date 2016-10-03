class Oystercard

  attr_reader :balance

  def initialize(balance = 5)
    @balance = balance
  end

  def top_up(amount)
    @balance += amount
  end
end
