class JourneyLog

  attr_reader :log

  def initialize
    @log = []
  end

  def record_trip(journey)
    @log << journey
  end

  def journeys
    @log
  end
end
