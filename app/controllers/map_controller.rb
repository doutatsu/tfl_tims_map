class MapController < ApplicationController
  def index
    @disruptions = TflFeedService.new('https://data.tfl.gov.uk/tfl/syndication/feeds/tims_feed.xml').get_disruptions
  end
end
