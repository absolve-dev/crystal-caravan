class PermalinkValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    # Check for anything other than letters, numbers, and dashes
    if value =~ /[^a-zA-Z\-\d]/
      record.errors[attribute] << "permalink has invalid characters; only use letters, numbers, and dashes"
    end
    
    # do duplication checks across all visible models
    models_with_permalinks = [Category, Product]
    models_with_permalinks.each do |model|
      results = model.where(permalink: value)
      
      record.errors[attribute] << "permalink already exists in '#{results.first.name}'" if results.length > 0 and record.id != results.first.id
    end
    
  end
end