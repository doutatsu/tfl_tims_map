require 'open-uri'
require 'nokogiri'

class TflFeedService
  def initialize(url)
    @uri = URI.parse(url_cleanup(url))
  end

  def get_disruptions
    begin
      doc = Nokogiri::XML(open(@uri))
    rescue OpenURI::HTTPError
      return "there was an error"
    end

    doc.remove_namespaces!
    all_locations = []
    # get all disruptions coordinates
    coordinates = doc.xpath('//coordinatesLL')
    coordinates.each do |coordinate|
      arr = coordinate.children[0].text.split(",")
      # replaced whitespace in coordinated with 0
      unless arr[0] =~ %r{^(\d|-\d)}
        arr[0] = arr[0] =~ %r{^-.} ? arr[0].gsub(/^-./, '-0.') : arr[0].gsub(/^./, '0.')
      end
      all_locations << { lng: arr[0].to_f, lat: arr[1].to_f }
    end

    all_locations
  end

  private

  def url_cleanup(url)
    # delete spaces
    url.strip!
    # add http to string if missing
    url = 'http://' + url if url.match(%r{(http:\/\/|https:\/\/)}).nil?
    # Replace all unsafe characters with codes.
    URI.escape(url)
  end
end
