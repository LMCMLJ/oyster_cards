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
  end

  describe '#start_trip' do
    it 'adds start station name' do
      journey.start_trip(@station)
      expect(journey.entry_name).to eq('Waterloo')
    end
  end

  describe '#end_unfinished_trip' do
    it 'saves start location and zone hash to history' do
      journey.start_trip(@station)
      expect(journey.end_unfinished_trip).to eq(6)
    end
  end

  describe '#end_trip' do
    before :each do
      journey.start_trip(@station)
      journey.end_trip(@station2)
    end

    it 'adds end location name' do
      expect(journey.exit_name).to eq('Paddington')
    end
  end

  describe '#fare' do
    before :each do
      journey.start_trip(@station)
    end

    it 'Charges 6 for an incomplete trip (user error)' do
      expect(journey.fare).to eq(6)
    end

    it 'Charges 4 for going from 1 to 4' do
      journey.end_trip(@station2)
      expect(journey.fare).to eq(2)
    end
  end
end
