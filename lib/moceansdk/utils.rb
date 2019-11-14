module Moceansdk

  class Utils
    def self.nil_or_empty?(str)
      str.nil? || str.empty?
    end

    def self.convert_to_symbol_hash(str_hash)
      str_hash.each_with_object({}) do |(k, v), memo|
        memo[k.to_sym] = v
      end
    end
  end

end
