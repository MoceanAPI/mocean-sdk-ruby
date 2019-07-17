require_relative 'mocean_testing'
module Moceansdk

  class UtilsTest < MoceanTest::Test
    def test_is_nil_or_empty
      assert Utils.nil_or_empty?('')
      assert Utils.nil_or_empty?(nil)
      refute Utils.nil_or_empty?('test')
    end

    def test_convert_to_symbol_hash
      hash1 = {'test': 'testing'}
      hash2 = {'test' => 'testing'}

      converted_hash1 = Utils.convert_to_symbol_hash hash1
      converted_hash2 = Utils.convert_to_symbol_hash hash2

      assert_equal converted_hash1[:test], hash1[:test]
      assert_equal converted_hash2[:test], hash2['test']
    end
  end

end
