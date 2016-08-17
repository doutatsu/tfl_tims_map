require './app/services/tfl_feed_service'

describe TflFeedService do
  describe '#get_disruptions' do
    let(:disruptions) { TflFeedService.new('https://data.tfl.gov.uk/tfl/syndication/feeds/tims_feed.xml').get_disruptions }
    it "should return an array given an url of xml" do
      expect(disruptions.kind_of?(Array)).to eq(true)
    end

    it "should contain hashes of locations" do
      expect(disruptions.map(&:keys).all? {|loc| loc == [:lng, :lat]}).to eq(true)
    end
  end
end
