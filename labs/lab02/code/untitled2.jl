function vigenere_encrypt(plaintext::String, key::String)
    result = ""
    key = uppercase(key)
    plaintext = uppercase(plaintext)
    key_len = length(key)
    key_pos = 1

    for c in plaintext
        if 'A' <= c <= 'Z'
            shift = Int(key[key_pos]) - Int('A')
            encrypted_char = Char(((Int(c) - Int('A') + shift) % 26) + Int('A'))
            result *= encrypted_char
            key_pos = key_pos == key_len ? 1 : key_pos + 1
        else
            result *= c  # Неалфавитные символы не меняем
        end
    end
    return result
end

plaintext = "Help me, please"
key = "Water"
println("Vigenère cipher encrypted: ", vigenere_encrypt(plaintext, key))