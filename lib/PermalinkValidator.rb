class PermalinkValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    # Check for anything other than letters, numbers, and dashes
    if value =~ /[^a-zA-Z\-\d]/
      record.errors[attribute] << "has invalid characters; only use letters, numbers, and dashes"
    end    
  end
end