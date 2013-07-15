class Empleado
  include ActiveModel::Validations
  attr_accessor :curp, :rfc
  validates :curp, curp_format: true
  validates :rfc, rfc_format: true

  def initialize(options)
    @curp = options[:curp] || 'AAAA111111HDFBBB01'
    @rfc  = options[:rfc]  || 'AAAA111111AAA'
  end
end
