require "journey"

describe Journey do
  subject(:journey) {described_class.new}

  before :each do
    @station = double(:station)
    allow(@station).to receive(:name).and_return('Waterloo')
    allow(@station).to receive(:zone).and_return(1)
    @station2 = double(:station)
    allow(@station2).to receive(:name).and_return('Paddington')
    allow(@station2).to receive(:zone).and_return(2)
    @hash1 = {entry_station: nil,
              entry_zone: nil,
              exit_station: nil,
              exit_zone: nil}
    @hash2 = {entry_station: 'Waterloo',
              entry_zone: 1,
              exit_station: nil,
              exit_zone: nil}
    @hash3 = {entry_station: 'Waterloo',
              entry_zone: 1,
              exit_station: 'Paddington',
              exit_zone: 2}
    @hash4 = {entry_station: 'Waterloo',
              entry_zone: 1,
              exit_station: 'Paddington',
              exit_zone: 4}
  end

  describe '#initialize' do

    it "contains a hash with empty keys" do
      expect(journey.current_trip).to eq(@hash1)
    end
  end

  describe '#start_trip' do
    it 'adds start station name and zone to trip' do
      journey.start_trip(@station)
      expect(journey.current_trip).to eq(@hash2)
    end
  end

  describe '#clear_current_trip' do
    it 'resets current trip hash' do
      journey.start_trip(@station)
      journey.clear_current_trip
      expect(journey.current_trip).to eq(@hash1)
    end
  end

  describe '#end_unfinished_trip' do
    it 'saves start location and zone hash to history' do
      journey.start_trip(@station)
      journey.end_unfinished_trip
      expect(journey.current_trip).to eq(@hash2)
    end
  end

  describe '#end_trip' do
    before :each do
      journey.start_trip(@station)
      journey.end_trip(@station2)
    end

    it 'adds end location and zone to trip' do
      expect(journey.current_trip).to eq(@hash3)
    end
  end

  describe '#fare' do
    before :each do
    end

    it 'Charges 6 for an incomplete trip (user error)' do
      journey.current_trip = @hash2
      expect(journey.fare).to eq(6)
    end

    it 'Charges 4 for going from 1 to 4' do
      journey.current_trip = @hash4
      expect(journey.fare).to eq(4)
    end
  end
end
