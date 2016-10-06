require_relative 'journey'
require_relative 'journey_log'

class Oystercard

	MAXIMUM_LIMIT = 90
	MINIMUM_FARE = 1

	attr_reader :balance, :cardholder_name
	attr_accessor :in_journey

	def initialize(balance = 0, cardholder = 'Example Mc Namington')
		@balance = balance
    @logger = JourneyLog.new
    @cardholder_name = cardholder
	end

	def top_up(amount)
		top_up_balance = @balance + amount
		raise "The maximum balance you can have is £#{MAXIMUM_LIMIT}!" if top_up_balance > MAXIMUM_LIMIT
		@balance += amount
	end

	def touch_in(entry_station)
		@journey = Journey.new
	  deduct(@journey.end_unfinished_trip) && @logger.record_trip(@journey) if @in_journey
		raise "Insufficient funds" if @balance < MINIMUM_FARE
		@journey.start_trip(entry_station)
		@in_journey = true
	end

	def touch_out(exit_station)
		@in_journey = false
		@journey.end_trip(exit_station)
	  deduct(@journey.fare)
    @logger.record_trip(@journey)
  end

	def in_journey?
		@in_journey
	end

	private

		def deduct(amount)
			@balance -= amount
		end
end
