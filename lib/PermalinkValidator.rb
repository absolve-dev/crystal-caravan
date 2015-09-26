class PermalinkValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    # Check for anything other than letters, numbers, and dashes
    if value =~ /[^a-zA-Z\-\d]/
      record.errors[attribute] << "has invalid characters; only use letters, numbers, and dashes"
    end
    
    # do duplication checks across all visible models
    models_with_permalinks = [Category, Product]
    models_with_permalinks.each do |model|
      results = model.where(permalink: value)
      
      record.errors[attribute] << "already exists in '#{results.first.name}'" if results.length > 0 and record.id != results.first.id
    end
    
    # do not allow only numbers, because of how permalinks work
    if value =~ /^[0-9]+$/
      record.errors[attribute] << "contains only numbers (not allowed)"
    end
    
  end
end