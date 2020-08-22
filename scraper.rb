require 'nokogiri'
require 'open-uri'
require 'pry-byebug'

class Scraper
  # state
  # base_url = String
  def initialize(base_url)
    @base_url = base_url
  end

  # behavior - instance method

  def call(keyword)
    # get all top 5 urls
    # return all hashes based on the url

    urls = fetch_recipe_urls(keyword)
    fetch_recipe_details(urls)
  end

  private

  def fetch_recipe_urls(keyword)
    url = "#{@base_url}/search/recipes?q=#{keyword}"
    doc = Nokogiri::HTML(open(url), nil, 'utf-8')

    # grab the top 5 recipe url
    doc.search('h4 a').first(5).map do |element|
      relative_url = element.attribute('href').value
      @base_url + relative_url
    end
  end

  def fetch_recipe_details(urls)
    urls.map do |url|
      doc = Nokogiri::HTML(open(url), nil, 'utf-8')
      name = doc.search('h1').text
      description = doc.search('p').first.text

      {
        name: name,
        description: description
      }
    end
  end
end

