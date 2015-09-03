require 'catalog_lib/LibraryTemplate'

class YgoPriceAPI < LibraryTemplate
  require "net/http"
  require "uri"
  require "json"
  
  def name
    "Yu-Gi-Oh!"
  end
  
  # set_data
  # returns an array of names
  class CardSet
    attr_reader :items
    
    def initialize(data)
      @items = Array.new
      data['cards'].each do |card|
        card_data = Hash.new
        card_data[:print_tag] = card['numbers'][0]['print_tag']
        card_data[:rarity] = card['numbers'][0]['rarity']
        @items << {name: card['name'], data: card_data}
      end
    end
  end
  
  def initialize
    @base_url = "http://yugiohprices.com/api"
  end
  
  def sets
    JSON.parse( make_get_request("/card_sets") )
  end
  
  def set(set_name)
    encoded_name = encode_text(set_name)
    data = make_get_request("/set_data/#{encoded_name}")
    set_data = return_if_success(data)
    if set_data
      return CardSet.new(set_data).items
    else
      return false
    end
  end
  
  def get_all_card_names
    JSON.parse( make_get_request("/card_names") )
  end
  
  # has following keys in data array
  # name, text, card_type, type, family, atk, def, level, property
  def card(card_name)
    card_name = encode_text(card_name)
    data = make_get_request("/card_data/#{card_name}")
    return_if_success(data)
  end
  
  def card_image(card_name)
    # must follow 302 redirect
    card_name = encode_text(card_name)
    uri = URI.parse( URI.encode(@base_url + "/card_image/#{card_name}") )
    response = Net::HTTP.get_response(uri)
    response.header['Location']
  end
  
  def encode_text(text)
    new_text = text.gsub("/", "%2F").gsub(".", "%2E").gsub("?", "%3F")
    new_text ? new_text : text
  end
  
  private   
    def make_get_request(endpoint)
      uri = URI.parse( URI.encode(@base_url + endpoint) )
      puts uri
      response = Net::HTTP.get(uri)
      rest
      return response
    end
    
    def make_get_request_to_uri(uri)
      uri = URI.parse(uri)
      response = Net::HTTP.get(uri)
      rest
      return response
    end
    
    # 15 requests per second for apiary
    # http://docs.corepro.io/api/requestresponse/index
    def rest
      sleep(0.1)
    end
    
    def return_if_success(response_body)
      JSON.parse(response_body)['data'] rescue false
    end
end