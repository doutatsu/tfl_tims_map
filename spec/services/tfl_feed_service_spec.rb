require './app/services/tfl_feed_service'

describe TflFeedService do
  describe '#get_disruptions' do
    it "should return all the disruptions given an xml" do
      tfl_service = TflFeedService.new('https://data.tfl.gov.uk/tfl/syndication/feeds/tims_feed.xml')

      expect(tfl_service.get_disruptions).to eq([
        { location: {lat: "51.500152" ,lang: "-0.126236"} },
        { location: { lat: "51.500152", lang: "-0.126236" } }
        ])
    end
  end
end