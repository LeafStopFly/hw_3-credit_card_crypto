# frozen_string_literal: true

require_relative '../credit_card'
require_relative '../substitution_cipher'
require_relative '../double_trans_cipher'
require_relative '../sk_cipher'
require 'minitest/autorun'

describe 'Test card info encryption' do
  before do
    @cc = CreditCard.new('4916603231464963', 'Mar-30-2020',
                         'Soumya Ray', 'Visa')
    @key = 3
    @ciphers = {
      'Caesar' => SubstitutionCipher::Caesar,
      'Permutation' => SubstitutionCipher::Permutation,
      'Double_Transposition' => DoubleTranspositionCipher,
      'Modern_Symmetric' => ModernSymmetricCipher
    }
  end

  %w[Caesar Permutation Double_Transposition Modern_Symmetric].each do |method|
    describe "Using #{method} Cipher" do
      it 'should encrypt card information' do
        enc = @ciphers[method].encrypt(@cc, @key)
        _(enc).wont_equal @cc.to_s
        _(enc).wont_be_nil
      end
      it 'should decrypt card information' do
        enc = @ciphers[method].encrypt(@cc, @key)
        dec = @ciphers[method].decrypt(enc, @key)
        _(dec).must_equal @cc.to_s
      end
    end
  end
  describe 'generate ModernSymmetricCipher key' do
    it 'should return a valid key' do
      key = ModernSymmetricCipher.generate_new_key
      _(key).wont_be_nil
      _(key.length).must_equal(32)
    end
  end
end
