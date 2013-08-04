require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/identificamex'

class MiniTest::Spec
  class << self
    alias_method :context, :describe
  end
end
