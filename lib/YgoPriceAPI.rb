class YgoPriceAPI
  require "net/http"
  require "uri"
  require "json"
  
  # set_data
  # returns an array of names
  class CardSet
    attr_reader :items
    
    def initialize(data)
      @items = Array.new
      data['cards'].each do |card|
        card_data = Hash.new
        card_data[:name] = card['name']
        card_data[:print_tag] = card['numbers'][0]['print_tag']
        card_data[:rarity] = card['numbers'][0]['rarity']
        @items << card_data
      end
    end
  end
  
  def initialize
    @base_url = "http://yugiohprices.com/api"
  end
  
  def get_all_sets
    sets_data = JSON.parse( make_get_request("/card_sets") )
  end
  
  def get_set_data(set_name)
    card_name = encode_text(set_name)
    data = make_get_request("/set_data/#{set_name}")
    set_data = return_if_success(data)
    if set_data
      return CardSet.new(set_data)
    else
      return false
    end
  end
  
  def get_all_card_names
    JSON.parse( make_get_request("/card_names") )
  end
  
  # has following keys in data array
  # name, text, card_type, type, family, atk, def, level, property
  def get_single_card(card_name)
    card_name = encode_text(card_name)
    data = make_get_request("/card_data/#{card_name}")
    return_if_success(data)
  end
  
  def get_single_card_image(card_name)
    # must follow 302 redirect
    card_name = encode_text(card_name)
    uri = URI.parse( URI.encode(@base_url + "/card_image/#{card_name}") )
    response = Net::HTTP.get_response(uri)
    make_get_request_to_uri(response.header['Location'])
  end
  
  def encode_text(text)
    new_text = text.gsub("/", "%2F").gsub(".", "%2E")
    new_text ? new_text : text
  end
    
  private   
    def make_get_request(endpoint)
      uri = URI.parse( URI.encode(@base_url + endpoint) )
      puts uri
      response = Net::HTTP.get(uri)
      return response
    end
    
    def make_get_request_to_uri(uri)
      uri = URI.parse(uri)
      response = Net::HTTP.get(uri)
      return response
    end
    
    def return_if_success(response_body)
      JSON.parse(response_body)['data'] rescue false
    end
end