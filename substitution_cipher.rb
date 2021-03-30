module SubstitutionCipher
  module Caesar
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using caesar cipher

      doc_shift_key = document.to_s.chars.map { |str| (str.ord + key).chr }
      doc_shift_key.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using caesar cipher
      doc_shift_key = document.chars.map { |str| (str.ord - key).chr }
      doc_shift_key.join
    end
  end

  module Permutation
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using a permutation cipher
      rand_key = (0..127).to_a.shuffle(random: Random.new(key))
      document.to_s.split('').map do |e|
        rand_key[e.ord].chr
      end
      .join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher
      rand_key = (0..127).to_a.shuffle(random: Random.new(key))
      document.to_s.split('').map do |d|
        rand_key.index(d.ord).chr
      end
      .join
    end
  end
end
