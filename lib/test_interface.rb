require_relative 'station'
require_relative 'oystercard'

station_1 = Station.new("aldgate",2)
station_2 = Station.new("liverpool st",1)

card = Oystercard.new

card.top_up(10)

card.touch_in(station_1)
card.touch_out(station_2)

puts card.logger.log.inspect
