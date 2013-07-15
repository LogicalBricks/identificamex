# -*- encoding : utf-8 -*-
class RfcFormatValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    unless value =~ /\A[A-ZÑ&]{3,4}[0-9]{2}[0-1][0-9][0-3][0-9]([A-Z0-9]{0,3})?\z/i
      object.errors[attribute] << (options[:message] || "no es un RFC válido") 
    end
  end
end
