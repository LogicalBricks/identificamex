# -*- encoding : utf-8 -*-
class CurpFormatValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    unless value =~ /\A[A-Z][AEIOUX][A-Z]{2}[0-9]{2}[0-1][0-9][0-3][0-9][MH][A-Z][A-Z][BCDFGHJKLMNÑPQRSTVWXYZ]{3}[0-9A-Z][0-9]\z/i
      object.errors[attribute] << (options[:message] || "no es una CURP válida")
    end
  end
end
