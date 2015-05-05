class Encryptor

  def supported_characters
    (' '..'z').to_a
  end

  def cipher(rotation)
    characters = supported_characters
    rotated_characters = characters.rotate(rotation)
    Hash[characters.zip(rotated_characters)]
  end

  def encrypt_letter(letter, rotation)
    cipher(rotation)[letter]
  end

  def decrypt_letter(letter, rotation)
    cipher(rotation).key(letter)
  end

  def encrypt(string, rotation)
    string.split("").collect { |letter|
      decrypt_letter(letter, rotation)
    }.join
  end

  def decrypt(string, rotation)
    string.split("").collect { |letter|
      decrypt_letter(letter, rotation)
    }.join
  end

  def encrypt_file(filename, rotation)
    input = File.open(filename, "r")
    encrypted_input = encrypt(input.read, rotation)
    input.close
    output = File.open(filename + ".secret", "w")
    output.write(encrypted_input)
    output.close
  end

  def decrypt_file(filename)
    input = File.open(filename, "r")
    encrypted_input = input.read
    output = File.open(filename + ".decrypt", "w")
    supported_characters.count.times.collect do |attempt|
      output.write(decrypt(encrypted_input, attempt) + "\n")
    end
    input.close
    output.close
  end
end