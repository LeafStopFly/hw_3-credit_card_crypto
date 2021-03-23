module DoubleTranspositionCipher
  def self.encrypt(document, key)
    # TODO: FILL THIS IN!
    ## Suggested steps for double transposition cipher
    # 1. find number of rows/cols such that matrix is almost square
    words = document.to_s.split('')
    words_num = words.size
    matrix_num = Math.sqrt(words_num).ceil
    (matrix_num**2 - words_num).times { words.push('#') }
    # 2. break plaintext into evenly sized blocks
    blocks = words.each_slice(matrix_num).to_a

    # 3. sort rows in predictibly random way using key as seed
    rows = [*0..blocks.size - 1].shuffle(random: Random.new(key))
    rows.each_with_index { |r, i| rows[i] = blocks[r] }

    # 4. sort columns of each row in predictibly random way
    columns = [*0..blocks[0].size - 1].shuffle(random: Random.new(key))
    columns.each_with_index { |c, i| columns[i] = rows.transpose[c] }

    # 5. return joined cyphertext
    columns.transpose.join
  end

  def self.decrypt(ciphertext, key)
    # TODO: FILL THIS IN!
    words = ciphertext.split('')
    words_num = words.size
    matrix_num = Math.sqrt(words_num).ceil

    blocks = words.each_slice(matrix_num).to_a
    rows_d = unshuffle([*0..blocks.size - 1], random: Random.new(key))
    columns_d = unshuffle([*0..blocks[0].size - 1], random: Random.new(key))

    columns_d.each_with_index { |c, i| columns_d[i] = blocks.transpose[c] }
    rows_d.each_with_index { |r, i| rows_d[i] = columns_d.transpose[r] }
    rows_d.join.delete('#')
  end

  def self.unshuffle(length, random:)
    transformed_order = length.to_a.shuffle!(random: random)
    length.sort_by { |i| transformed_order[i] }
  end
end
