require './app/services/tfl_feed_service'

describe TflFeedService do
  describe '#get_disruptions' do
    it "should return all the disruptions given an xml" do
      tfl_service = TflFeedService.new('https://data.tfl.gov.uk/tfl/syndication/feeds/tims_feed.xml')

      expect(tfl_service.get_disruptions[0]).to eq({:lng=>"-0.066583", :lat=>"51.442505"})
    end
  end
end