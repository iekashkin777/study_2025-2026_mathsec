enc = "e"  # "e" = encrypt, "d" = decrypt
msg = "Hello"
key = 6

function encrypt(msg, key)
    result = ""
    for c in msg
        if Int(c) > 1041 && Int(c) < 1104
            base = (uppercase(c) == c) ? Int('А') : Int('а')
            t = base + (Int(c) - base + key) % 32
        elseif isletter(c)
            base = (uppercase(c) == c) ? Int('A') : Int('a')
            t = base + (Int(c) - base + key) % 26
        else
            result *= c  # не шифруем символы вне алфавита
            continue
        end
        result *= Char(t)
    end
    return result
end

if enc == "e"
    # key уже правильный
elseif enc == "d"
    if Int(msg[1]) > 1041 && Int(msg[1]) < 1104
        key = 32 - key
    else
        key = 26 - key
    end
else
    println("Wrong argument. Use 'e' for encrypt or 'd' for decrypt.")
    exit(1)
end

res = encrypt(msg, key)
println(res)