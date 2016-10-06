class Journey

  attr_reader :exit_zone, :entry_zone, :entry_name, :exit_name
  
  def start_trip(station)
    @entry_name = station.name
    @entry_zone = station.zone
  end

  def end_trip(station)
    @exit_name = station.name
    @exit_zone = station.zone
  end

  def end_unfinished_trip
    fare
  end

  def fare
    if @entry_zone == nil or @exit_zone == nil
      6
    else
      1 + (@entry_zone - @exit_zone).abs
    end
  end
end
