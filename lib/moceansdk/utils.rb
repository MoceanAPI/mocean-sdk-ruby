module Moceansdk

  class Utils
    def self.nil_or_empty?(str)
      str.nil? || str.empty?
    end

    def self.convert_to_symbol_hash(str_hash)
      str_hash.inject({}) {|memo, (k, v)| memo[k.to_sym] = v; memo}
    end
  end

end
