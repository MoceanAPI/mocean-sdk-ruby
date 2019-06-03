require_relative 'mocean_testing'
module Moceansdk

  class UtilsTest < MoceanTest::Test
    def test_is_nil_or_empty
      assert Utils.nil_or_empty?('')
      assert Utils.nil_or_empty?(nil)
      refute Utils.nil_or_empty?('test')
    end
  end

end
