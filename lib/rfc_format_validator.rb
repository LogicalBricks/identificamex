# -*- encoding : utf-8 -*-
class RfcFormatValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    unless value =~ regexp
      object.errors[attribute] << (options[:message] || "no es un RFC válido") 
    end
  end

  def regexp
    if options[:force_homoclave]
      /\A[A-ZÑ&]{3,4}[0-9]{2}[0-1][0-9][0-3][0-9][A-Z0-9]{3}\z/i
    else
      /\A[A-ZÑ&]{3,4}[0-9]{2}[0-1][0-9][0-3][0-9]([A-Z0-9]{3})?\z/i
    end
  end
end
