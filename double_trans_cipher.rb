module DoubleTranspositionCipher
  def self.encrypt(document, key)
    # TODO: FILL THIS IN!
    ## Suggested steps for double transposition cipher
    # 1. find number of rows/cols such that matrix is almost square
    words = document.split('')
    words_num = words.size
    matrix_num = Math.sqrt(words_num).ceil
    # 2. break plaintext into evenly sized blocks
    # blocks = [["p", "i", "k"], ["a", "c", "h"]]
    blocks = words.each_slice(matrix_num).to_a
    # 3. sort rows in predictibly random way using key as seed
    # a.shuffle(random: Random.new(1))  #=> [1, 3, 2]
    rows = [*0..blocks.size - 1].shuffle(random: Random.new(key))
    cipher_row = []
    blocks.each_with_index { |_, index| cipher_row << blocks[rows[index]] }
    # 4. sort columns of each row in predictibly random way
    columns = [*0..blocks[0].size - 1].shuffle(random: Random.new(key))
    cipher_col = Array.new(matrix_num) { Array.new(matrix_num) }

    # 5. return joined cyphertext
    cipher_col.join
  end

  def self.decrypt(ciphertext, key)
    # TODO: FILL THIS IN!
    words_num = ciphertext.size
    matrix_num = Math.sqrt(words_num).ceil
    blocks = ciphertext.each_slice(matrix_num).to_a
    rows = blocks.unshuffle(random: Random.new(key))
    # columns =
  end

  def unshuffle(random:)
    transformed_order = (0...length).to_a.shuffle!(random: random)
    sort_by.with_index { |_, i| transformed_order[i] }
  end
end
