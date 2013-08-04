require_relative '../test_helper'
require_relative '../../lib/identificamex/razon_social'

module Identificamex
  describe RazonSocial do

    describe '#to_s' do
      it 'is razon_social' do
        RazonSocial.new('Una razon social').to_s.must_equal 'UNA RAZON SOCIAL'
      end
    end

    describe '#siglas' do
      context 'when company name has 3 words' do
        it 'takes the first letters of the 3 words' do
          RazonSocial.new('Sonora Industrial Azucarera, S. de R.L').siglas.must_equal 'SIA'
        end

        it 'takes the first letters of the 3 words skipping invalid names' do
          RazonSocial.new('Compañía Sonora Industrial del Azucar, S. de R.L').siglas.must_equal 'SIA'
        end
      end

      context 'when company name has 2 words' do
        it 'takes the first letter from the first word and 2 letters from the second word' do
          RazonSocial.new('Soc. Sonora Industrial, S. de R.L').siglas.must_equal 'SIN'
        end
      end

      context 'when company name has 1 word' do
        context 'when word has more than 3 letters' do
          it 'takes the first 3 letters from the first word' do
            RazonSocial.new('Soc. Sonora, S. de R.L').siglas.must_equal 'SON'
          end
        end

        context 'when word has 3 letters' do
          it 'takes the first 3 letters from the first word' do
            RazonSocial.new('Sol, S. A.').siglas.must_equal 'SOL'
          end
        end

        context 'when word has 2 letters' do
          it 'takes the first 3 letters from the first word' do
            RazonSocial.new('Pi, S.A.').siglas.must_equal 'PIX'
          end
        end

        context 'when word has 1 letter' do
          it 'takes the first 3 letters from the first word' do
            RazonSocial.new('Z, SA').siglas.must_equal 'ZXX'
          end
        end

      end
    end
  end
end
