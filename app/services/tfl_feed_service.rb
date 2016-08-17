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
    arr = []
    # get all disruptions coordinates
    coords = doc.xpath('//coordinatesLL')
    coords.each do |coordinate|
      splited = coordinate.children[0].text.split(",")
      # replaced whitespace in coordinated with 0
      unless splited[0] =~ %r{^(\d|-\d)}
        splited[0] = splited[0] =~ %r{^-.} ? splited[0].gsub(/^-./, '-0.') : splited[0].gsub(/^./, '0.')
      end
      arr << { lng: splited[0], lat: splited[1] }
    end

    arr
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