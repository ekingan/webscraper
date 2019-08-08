require 'HTTParty'
require 'Nokogiri'

class Scraper

  attr_accessor :names, :url

  def initialize(url)
    @url = url
    @names = []
  end

  def scrape
    parse_page.css('h2 div').children.map(&:text).each_slice(2) do |pair|
      names << pair
    end
  end

  private

  def doc
    HTTParty.get(url)
  end

  def parse_page
    @parse_page ||= Nokogiri::HTML(doc)
  end
end
