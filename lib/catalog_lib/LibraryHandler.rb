# 
# Assumes Library Classes are named the same as their filename
#
# Operates on one catalog at a time
#

class LibraryHandler

  def initialize(args={})
    @libraries = Array.new
    get_libraries
    @current_full_path = false
  end
  
  def libraries
    @libraries.collect{ |library| library[:name] }
  end
  
  def set_library(name)
    index = @libraries.find_index { |library| library[:name] == name }
    @current_full_path = @libraries[index][:full_path] if index
    @current_full_path ? true : false
  end
  
  def get_sets
    current_library.sets
  end
  
  def get_set(set_name)
    current_library.set
  end
  
  def get_card(card_name)
    current_library.card
  end
  
  def get_card_image(card_name)
    current_library.card_image
  end
  
  def current_library_name
    current_library.name
  end
  
  private
    def get_libraries
      # Filter out template and handler files
      files = Dir.glob(Rails.root.to_s + "/lib/catalog_lib/*.rb").select do |full_path|
        filename = full_path.split("/")[-1]
        (filename != "LibraryTemplate.rb" && filename != "LibraryHandler.rb") ? true : false
      end
      files.each do |full_path|
        current = @current_full_path
        @current_full_path = full_path
        @libraries << {name: current_library_name, full_path: full_path} if current_library.class.superclass.name == 'LibraryTemplate'
        @current_full_path = current
      end
    end
  
    def current_library
      require @current_full_path
      class_name = @current_full_path.split("/")[-1].sub(".rb", "")
      full_class = class_name.constantize
      full_class.new
    end
  
end
