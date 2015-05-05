class Encryptor
  def cipher(rotation)
    characters = (' '..'z').to_a
    rotated_characters = characters.rotate(rotation)
    Hash[characters.zip(rotated_characters)]
  end

  def rotate_cipher(rotation)
    cipher(rotation)
  end

  def encrypt_letter(letter, rotation)
    rotate_cipher(rotation)[letter]
  end

  def decrypt_letter(letter, rotation)
    rotate_cipher(rotation).key(letter)
  end


  def encrypt(string, rotation)
    string.split("").each_with_object("") { |letter, str| str <<
        encrypt_letter(letter, rotation) }
  end

  def decrypt(string, rotation)
    string.split("").each_with_object("") { |letter, str| str <<
        decrypt_letter(letter, rotation) }
  end
end